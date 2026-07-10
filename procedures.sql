USE SpotifyAnalytics;

DELIMITER //

-- Return all playlists created by a specific user
DROP PROCEDURE IF EXISTS GetUserPlaylists //
CREATE PROCEDURE GetUserPlaylists(IN p_UserID INT)
BEGIN
    SELECT
        p.PlaylistID,
        p.PlaylistName,
        p.Description,
        p.CreatedAt,
        p.Visibility
    FROM Playlists AS p
    WHERE p.UserID = p_UserID
    ORDER BY p.CreatedAt DESC;
END //

-- Return all songs by a specific artist
DROP PROCEDURE IF EXISTS GetSongsByArtist //
CREATE PROCEDURE GetSongsByArtist(IN p_ArtistID INT)
BEGIN
    SELECT
        s.SongID,
        s.SongTitle,
        al.AlbumName,
        s.DurationSeconds,
        s.Language,
        s.ReleaseDate,
        s.Explicit,
        s.AudioQuality
    FROM Songs AS s
    INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
    INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
    WHERE ar.ArtistID = p_ArtistID
    ORDER BY s.SongTitle;
END //

-- Return all songs belonging to a specific genre
DROP PROCEDURE IF EXISTS GetSongsByGenre //
CREATE PROCEDURE GetSongsByGenre(IN p_GenreID INT)
BEGIN
    SELECT
        s.SongID,
        s.SongTitle,
        g.GenreName,
        al.AlbumName,
        ar.ArtistName,
        s.DurationSeconds,
        s.ReleaseDate
    FROM Songs AS s
    INNER JOIN Genres AS g ON s.GenreID = g.GenreID
    INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
    INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
    WHERE g.GenreID = p_GenreID
    ORDER BY s.SongTitle;
END //

-- Return all active premium users
DROP PROCEDURE IF EXISTS GetPremiumUsers //
CREATE PROCEDURE GetPremiumUsers()
BEGIN
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
      AND u.Status = 'Active'
    ORDER BY u.Username;
END //

-- Return listening history for a user with song and artist details
DROP PROCEDURE IF EXISTS GetListeningHistory //
CREATE PROCEDURE GetListeningHistory(IN p_UserID INT)
BEGIN
    SELECT
        lh.HistoryID,
        s.SongTitle,
        ar.ArtistName,
        lh.PlayedAt,
        lh.DurationPlayed,
        lh.Completed
    FROM ListeningHistory AS lh
    INNER JOIN Songs AS s ON lh.SongID = s.SongID
    INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
    INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
    WHERE lh.UserID = p_UserID
    ORDER BY lh.PlayedAt DESC;
END //

-- Return payments and total revenue for a selected month and year
DROP PROCEDURE IF EXISTS GetRevenueByMonth //
CREATE PROCEDURE GetRevenueByMonth(IN p_Month INT, IN p_Year INT)
BEGIN
    SELECT
        p.PaymentID,
        u.Username,
        sp.PlanName,
        p.Amount,
        p.PaymentDate,
        p.PaymentMethod
    FROM Payments AS p
    INNER JOIN Users AS u ON p.UserID = u.UserID
    INNER JOIN SubscriptionPlans AS sp ON p.PlanID = sp.PlanID
    WHERE MONTH(p.PaymentDate) = p_Month
      AND YEAR(p.PaymentDate) = p_Year
    ORDER BY p.PaymentDate;

    SELECT
        ROUND(SUM(p.Amount), 2) AS TotalRevenue
    FROM Payments AS p
    WHERE MONTH(p.PaymentDate) = p_Month
      AND YEAR(p.PaymentDate) = p_Year;
END //

-- Search songs by partial title match
DROP PROCEDURE IF EXISTS SearchSong //
CREATE PROCEDURE SearchSong(IN p_SongTitle VARCHAR(100))
BEGIN
    SELECT
        s.SongID,
        s.SongTitle,
        ar.ArtistName,
        al.AlbumName,
        g.GenreName,
        s.DurationSeconds,
        s.ReleaseDate
    FROM Songs AS s
    INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
    INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
    INNER JOIN Genres AS g ON s.GenreID = g.GenreID
    WHERE s.SongTitle LIKE CONCAT('%', p_SongTitle, '%')
    ORDER BY s.SongTitle;
END //

-- Return album count, song count and stream count for an artist
DROP PROCEDURE IF EXISTS GetArtistPerformance //
CREATE PROCEDURE GetArtistPerformance(IN p_ArtistID INT)
BEGIN
    SELECT
        ar.ArtistName,
        COUNT(DISTINCT al.AlbumID) AS TotalAlbums,
        COUNT(DISTINCT s.SongID) AS TotalSongs,
        COUNT(lh.HistoryID) AS TotalStreams
    FROM Artists AS ar
    LEFT JOIN Albums AS al ON ar.ArtistID = al.ArtistID
    LEFT JOIN Songs AS s ON al.AlbumID = s.AlbumID
    LEFT JOIN ListeningHistory AS lh ON s.SongID = lh.SongID
    WHERE ar.ArtistID = p_ArtistID
    GROUP BY ar.ArtistID, ar.ArtistName;
END //

DELIMITER ;
