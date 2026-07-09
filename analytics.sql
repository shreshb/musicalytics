USE SpotifyAnalytics;

-- 1. Top 10 most played songs by total stream count
SELECT
    s.SongID,
    s.SongTitle,
    ar.ArtistName,
    COUNT(lh.HistoryID) AS TotalPlays
FROM ListeningHistory AS lh
INNER JOIN Songs AS s ON lh.SongID = s.SongID
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
GROUP BY s.SongID, s.SongTitle, ar.ArtistName
ORDER BY TotalPlays DESC
LIMIT 10;


-- 2. Artist performance based on total song streams
SELECT
    ar.ArtistID,
    ar.ArtistName,
    ar.Country,
    COUNT(lh.HistoryID) AS TotalStreams
FROM Artists AS ar
INNER JOIN Albums AS al ON ar.ArtistID = al.ArtistID
INNER JOIN Songs AS s ON al.AlbumID = s.AlbumID
INNER JOIN ListeningHistory AS lh ON s.SongID = lh.SongID
GROUP BY ar.ArtistID, ar.ArtistName, ar.Country
ORDER BY TotalStreams DESC;


-- 3. Most popular genres based on listening activity
SELECT
    g.GenreID,
    g.GenreName,
    COUNT(lh.HistoryID) AS TotalPlays,
    COUNT(DISTINCT s.SongID) AS UniqueSongsPlayed
FROM Genres AS g
INNER JOIN Songs AS s ON g.GenreID = s.GenreID
INNER JOIN ListeningHistory AS lh ON s.SongID = lh.SongID
GROUP BY g.GenreID, g.GenreName
ORDER BY TotalPlays DESC;


-- 4. Most active users ranked by number of songs played
SELECT
    u.UserID,
    u.Username,
    u.Country,
    COUNT(lh.HistoryID) AS TotalPlays,
    SUM(lh.DurationPlayed) AS TotalSecondsListened
FROM Users AS u
INNER JOIN ListeningHistory AS lh ON u.UserID = lh.UserID
WHERE u.Status = 'Active'
GROUP BY u.UserID, u.Username, u.Country
ORDER BY TotalPlays DESC, TotalSecondsListened DESC;


-- 5. Compare listening activity between Premium and Free users
SELECT
    CASE
        WHEN u.IsPremium = TRUE THEN 'Premium'
        ELSE 'Free'
    END AS UserType,
    COUNT(DISTINCT u.UserID) AS UserCount,
    COUNT(lh.HistoryID) AS TotalPlays,
    ROUND(AVG(lh.DurationPlayed), 2) AS AvgDurationPerPlay
FROM Users AS u
LEFT JOIN ListeningHistory AS lh ON u.UserID = lh.UserID
WHERE u.Status = 'Active'
GROUP BY
    CASE
        WHEN u.IsPremium = TRUE THEN 'Premium'
        ELSE 'Free'
    END
ORDER BY TotalPlays DESC;


-- 6. Total subscription revenue from all recorded payments
SELECT
    ROUND(SUM(p.Amount), 2) AS TotalRevenue,
    COUNT(p.PaymentID) AS TotalPayments,
    COUNT(DISTINCT p.UserID) AS PayingUsers
FROM Payments AS p
INNER JOIN SubscriptionPlans AS sp ON p.PlanID = sp.PlanID
WHERE sp.PlanName <> 'Free';


-- 7. Monthly subscription revenue breakdown
SELECT
    DATE_FORMAT(p.PaymentDate, '%Y-%m') AS RevenueMonth,
    COUNT(p.PaymentID) AS PaymentCount,
    ROUND(SUM(p.Amount), 2) AS MonthlyRevenue
FROM Payments AS p
GROUP BY DATE_FORMAT(p.PaymentDate, '%Y-%m')
ORDER BY RevenueMonth;


-- 8. Average listening duration per user in minutes
SELECT
    u.UserID,
    u.Username,
    COUNT(lh.HistoryID) AS TotalPlays,
    ROUND(AVG(lh.DurationPlayed), 2) AS AvgDurationSeconds,
    ROUND(AVG(lh.DurationPlayed) / 60, 2) AS AvgDurationMinutes
FROM Users AS u
INNER JOIN ListeningHistory AS lh ON u.UserID = lh.UserID
GROUP BY u.UserID, u.Username
ORDER BY AvgDurationMinutes DESC;


-- 9. Songs with the highest completion rate (minimum 1 play)
SELECT
    s.SongID,
    s.SongTitle,
    ar.ArtistName,
    COUNT(lh.HistoryID) AS TotalPlays,
    SUM(CASE WHEN lh.Completed = TRUE THEN 1 ELSE 0 END) AS CompletedPlays,
    ROUND(
        SUM(CASE WHEN lh.Completed = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(lh.HistoryID),
        2
    ) AS CompletionRatePercent
FROM Songs AS s
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
INNER JOIN ListeningHistory AS lh ON s.SongID = lh.SongID
GROUP BY s.SongID, s.SongTitle, ar.ArtistName
ORDER BY CompletionRatePercent DESC, TotalPlays DESC;


-- 10. Songs most frequently added to user playlists
SELECT
    s.SongID,
    s.SongTitle,
    ar.ArtistName,
    COUNT(ps.SongID) AS TimesAddedToPlaylists
FROM PlaylistSongs AS ps
INNER JOIN Songs AS s ON ps.SongID = s.SongID
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
GROUP BY s.SongID, s.SongTitle, ar.ArtistName
ORDER BY TimesAddedToPlaylists DESC;


-- 11. Count of Public vs Private playlists
SELECT
    p.Visibility,
    COUNT(p.PlaylistID) AS PlaylistCount
FROM Playlists AS p
GROUP BY p.Visibility
ORDER BY PlaylistCount DESC;


-- 12. Top playlist creators by number of playlists created
SELECT
    u.Username,
    u.Country,
    COUNT(pl.PlaylistID) AS PlaylistsCreated
FROM Users u
INNER JOIN Playlists pl
ON u.UserID = pl.UserID
GROUP BY u.Username, u.Country
ORDER BY PlaylistsCreated DESC;

-- 13. Number of songs released per artist
SELECT
    ar.ArtistName,
    COUNT(s.SongID) AS TotalSongs
FROM Artists ar
LEFT JOIN Albums al
ON ar.ArtistID = al.ArtistID
LEFT JOIN Songs s
ON al.AlbumID = s.AlbumID
GROUP BY ar.ArtistName
ORDER BY TotalSongs DESC;

-- 14. Number of albums per artist
SELECT
    ar.ArtistName,
    COUNT(al.AlbumID) AS TotalAlbums
FROM Artists ar
LEFT JOIN Albums al
ON ar.ArtistID = al.ArtistID
GROUP BY ar.ArtistName
ORDER BY TotalAlbums DESC;

-- 15. Distribution of Explicit vs Non-explicit songs
SELECT
    CASE
        WHEN s.Explicit = TRUE THEN 'Explicit'
        ELSE 'Non-Explicit'
    END AS ContentRating,
    COUNT(s.SongID) AS SongCount,
    ROUND(COUNT(s.SongID) * 100.0 / (SELECT COUNT(*) FROM Songs), 2) AS Percentage
FROM Songs AS s
GROUP BY s.Explicit
    END
ORDER BY SongCount DESC;


-- 16. Audio quality distribution across the song catalog
SELECT
    s.AudioQuality,
    COUNT(s.SongID) AS SongCount,
    ROUND(AVG(s.DurationSeconds), 2) AS AvgDurationSeconds
FROM Songs AS s
GROUP BY s.AudioQuality
ORDER BY SongCount DESC;


-- 17. Country-wise distribution of registered users
SELECT
    u.Country,
    COUNT(*) AS TotalUsers
FROM Users u
GROUP BY u.Country
ORDER BY TotalUsers DESC;


-- 18.  Most popular song language
SELECT
    Language,
    COUNT(*) AS TotalSongs
FROM Songs
GROUP BY Language
ORDER BY TotalSongs DESC;

-- 19. Recently released songs (newest first)
SELECT
    s.SongID,
    s.SongTitle,
    ar.ArtistName,
    al.AlbumName,
    s.ReleaseDate,
    s.Language
FROM Songs AS s
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
ORDER BY s.ReleaseDate DESC
LIMIT 10;


-- 20. Longest songs in the catalog
SELECT
    s.SongID,
    s.SongTitle,
    ar.ArtistName,
    s.DurationSeconds,
    CONCAT(FLOOR(s.DurationSeconds / 60), 'm ', MOD(s.DurationSeconds, 60), 's') AS DurationFormatted
FROM Songs AS s
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
ORDER BY s.DurationSeconds DESC
LIMIT 10;


-- 21. Shortest songs in the catalog
SELECT
    s.SongID,
    s.SongTitle,
    ar.ArtistName,
    s.DurationSeconds,
    CONCAT(FLOOR(s.DurationSeconds / 60), 'm ', MOD(s.DurationSeconds, 60), 's') AS DurationFormatted
FROM Songs AS s
INNER JOIN Albums AS al ON s.AlbumID = al.AlbumID
INNER JOIN Artists AS ar ON al.ArtistID = ar.ArtistID
ORDER BY s.DurationSeconds ASC
LIMIT 10;


-- 22. Active users who have not created any playlists
SELECT
    u.UserID,
    u.Username,
    u.Email,
    u.Country,
    u.DateJoined
FROM Users AS u
LEFT JOIN Playlists AS p ON u.UserID = p.UserID
WHERE p.PlaylistID IS NULL
  AND u.Status = 'Active'
ORDER BY u.DateJoined;


-- 23. Artists with no albums in the catalog
SELECT
    ar.ArtistID,
    ar.ArtistName,
    ar.Country,
    ar.MonthlyListeners
FROM Artists AS ar
LEFT JOIN Albums AS al ON ar.ArtistID = al.ArtistID
WHERE al.AlbumID IS NULL
ORDER BY ar.ArtistName;


-- 24. Average song duration by genre
SELECT
    g.GenreName,
    COUNT(s.SongID) AS SongCount,
    ROUND(AVG(s.DurationSeconds), 2) AS AvgDurationSeconds,
    ROUND(AVG(s.DurationSeconds) / 60, 2) AS AvgDurationMinutes,
    MIN(s.DurationSeconds) AS ShortestSong,
    MAX(s.DurationSeconds) AS LongestSong
FROM Genres AS g
INNER JOIN Songs AS s ON g.GenreID = s.GenreID
GROUP BY g.GenreID, g.GenreName
ORDER BY AvgDurationSeconds DESC;


-- 25. Dashboard summary with key platform metrics in a single result
SELECT
    (SELECT COUNT(*) FROM Users WHERE Status = 'Active') AS ActiveUsers,
    (SELECT COUNT(*) FROM Users WHERE IsPremium = TRUE AND Status = 'Active') AS PremiumUsers,
    (SELECT COUNT(*) FROM Artists) AS TotalArtists,
    (SELECT COUNT(*) FROM Songs) AS TotalSongs,
    (SELECT COUNT(*) FROM Playlists) AS TotalPlaylists,
    (SELECT COUNT(*) FROM ListeningHistory) AS TotalStreams,
    (SELECT ROUND(SUM(Amount), 2) FROM Payments) AS TotalRevenue,
    (SELECT ROUND(AVG(DurationPlayed) / 60, 2) FROM ListeningHistory) AS AvgListenMinutes,
    (SELECT COUNT(*) FROM PlaylistSongs) AS TotalPlaylistAdds,
    (
        SELECT Visibility
        FROM Playlists
        GROUP BY Visibility
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS MostCommonPlaylistVisibility;
