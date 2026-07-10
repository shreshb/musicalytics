USE SpotifyAnalytics;

DROP VIEW IF EXISTS PremiumUsersView;
DROP VIEW IF EXISTS TopPlayedSongsView;
DROP VIEW IF EXISTS ArtistAlbumDetailsView;
DROP VIEW IF EXISTS PlaylistDetailsView;
DROP VIEW IF EXISTS RevenueSummaryView;
DROP VIEW IF EXISTS ListeningHistoryDetailsView;
DROP VIEW IF EXISTS SongDetailsView;
DROP VIEW IF EXISTS ArtistPerformanceView;

-- 1. Active premium subscribers
CREATE VIEW PremiumUsersView AS
SELECT
    u.UserID,
    u.Username,
    u.Email,
    u.DateJoined,
    u.Country,
    u.DateOfBirth,
    u.ProfileImage,
    u.Status
FROM Users AS u
WHERE u.IsPremium = 1
AND u.Status = 'Active';



-- 2. Songs ranked by total play count
CREATE VIEW TopPlayedSongsView AS
SELECT
    s.SongID,
    s.SongTitle,
    ar.ArtistName,
    al.AlbumName,
    COUNT(lh.HistoryID) AS TotalPlays
FROM ListeningHistory AS lh
INNER JOIN Songs AS s ON lh.SongID = s.SongID
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
GROUP BY s.SongID, s.SongTitle, ar.ArtistName, al.AlbumName;


-- 3. Artist information combined with album details
CREATE VIEW ArtistAlbumDetailsView AS
SELECT
    ar.ArtistID,
    ar.ArtistName,
    ar.Country AS ArtistCountry,
    ar.MonthlyListeners,
    ar.Verified,
    al.AlbumID,
    al.AlbumName,
    al.ReleaseDate,
    al.AlbumType,
    al.TotalTracks
FROM Artists AS ar
INNER JOIN Albums AS al ON ar.ArtistID = al.ArtistID;


-- 4. Playlists with owner information
CREATE VIEW PlaylistDetailsView AS
SELECT
    p.PlaylistID,
    p.PlaylistName,
    p.Description,
    p.CreatedAt,
    p.Visibility,
    u.UserID,
    u.Username AS OwnerUsername,
    u.Email AS OwnerEmail,
    u.Country AS OwnerCountry
FROM Playlists AS p
INNER JOIN Users AS u ON p.UserID = u.UserID;


-- 5. Payment records with plan and user details
CREATE VIEW RevenueSummaryView AS
SELECT
    p.PaymentID,
    p.PaymentDate,
    p.Amount,
    p.PaymentMethod,
    u.UserID,
    u.Username,
    u.Country,
    sp.PlanID,
    sp.PlanName,
    sp.MonthlyPrice
FROM Payments AS p
INNER JOIN Users AS u
ON p.UserID = u.UserID
INNER JOIN SubscriptionPlans AS sp
ON p.PlanID = sp.PlanID;

-- 6. Listening history enriched with user, song and artist details
CREATE VIEW ListeningHistoryDetailsView AS
SELECT
    lh.HistoryID,
    lh.PlayedAt,
    lh.DurationPlayed,
    lh.Completed,
    u.UserID,
    u.Username,
    u.Country AS UserCountry,
    s.SongID,
    s.SongTitle,
    s.DurationSeconds AS SongDuration,
    ar.ArtistName,
    al.AlbumName
FROM ListeningHistory AS lh
INNER JOIN Users AS u ON lh.UserID = u.UserID
INNER JOIN Songs AS s ON lh.SongID = s.SongID
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID;


-- 7. Full song catalog with genre and album context
CREATE VIEW SongDetailsView AS
SELECT
    s.SongID,
    s.SongTitle,
    s.DurationSeconds,
    s.Language,
    s.ReleaseDate,
    s.Explicit,
    s.AudioQuality,
    g.GenreID,
    g.GenreName,
    al.AlbumID,
    al.AlbumName,
    al.AlbumType,
    ar.ArtistID,
    ar.ArtistName
FROM Songs AS s
INNER JOIN Genres AS g ON s.GenreID = g.GenreID
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID;


-- 8. Artist catalog size and listening performance
CREATE VIEW ArtistPerformanceView AS
SELECT
    ar.ArtistID,
    ar.ArtistName,
    ar.Country,
    ar.MonthlyListeners,
    ar.Verified,
    COUNT(DISTINCT al.AlbumID) AS TotalAlbums,
    COUNT(DISTINCT s.SongID) AS TotalSongs,
    COUNT(lh.HistoryID) AS TotalStreams
FROM Artists AS ar
LEFT JOIN Albums AS al ON ar.ArtistID = al.ArtistID
LEFT JOIN Songs AS s ON al.AlbumID = s.AlbumID
LEFT JOIN ListeningHistory AS lh ON s.SongID = lh.SongID
GROUP BY
    ar.ArtistID,
    ar.ArtistName,
    ar.Country,
    ar.MonthlyListeners,
    ar.Verified;
