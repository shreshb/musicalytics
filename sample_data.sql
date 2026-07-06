USE SpotifyAnalytics;

INSERT INTO Genres (GenreID, GenreName) VALUES
(1, 'Pop'),
(2, 'Rock'),
(3, 'Hip-Hop'),
(4, 'Bollywood'),
(5, 'Indie'),
(6, 'R&B'),
(7, 'Electronic'),
(8, 'K-Pop');

INSERT INTO Users (UserID, Username, Email, PasswordHash, DateJoined, Country, DateOfBirth, IsPremium, ProfileImage, Status) VALUES
(1, 'arjun_malik', 'arjun.malik@gmail.com', '$2y$10$abc123hasharjunmalik', '2023-01-15', 'India', '1998-07-22', TRUE, 'profiles/arjun.jpg', 'Active'),
(2, 'priya_sharma', 'priya.sharma@yahoo.in', '$2y$10$def456hashpriyasharma', '2023-03-08', 'India', '2000-11-03', FALSE, NULL, 'Active'),
(3, 'james_wilson', 'james.wilson@gmail.com', '$2y$10$ghi789hashjameswilson', '2022-11-20', 'United Kingdom', '1995-04-18', TRUE, 'profiles/james_w.png', 'Active'),
(4, 'sophie_martin', 'sophie.martin@outlook.fr', '$2y$10$jkl012hashsophiemartin', '2024-02-14', 'France', '1999-09-30', FALSE, 'profiles/sophie.jpg', 'Active'),
(5, 'rahul_iyer', 'rahul.iyer@hotmail.com', '$2y$10$mno345hashrahuliyer', '2023-06-01', 'India', '1997-12-05', TRUE, NULL, 'Active'),
(6, 'emily_chen', 'emily.chen@icloud.com', '$2y$10$pqr678hashemilychen', '2022-08-09', 'United States', '2001-02-28', TRUE, 'profiles/emily_chen.jpg', 'Active'),
(7, 'vikram_patel', 'vikram.patel@gmail.com', '$2y$10$stu901hashvikrampatel', '2024-05-22', 'India', '2002-06-14', FALSE, NULL, 'Active'),
(8, 'maria_garcia', 'maria.garcia@gmail.com', '$2y$10$vwx234hashmariagarcia', '2023-09-17', 'Spain', '1996-08-21', FALSE, 'profiles/maria.jpg', 'Suspended');

INSERT INTO Artists (ArtistID, ArtistName, Country, MonthlyListeners, Verified, Biography) VALUES
(1, 'Taylor Swift', 'United States', 95000000, TRUE, 'American singer-songwriter known for narrative songwriting.'),
(2, 'Drake', 'Canada', 78000000, TRUE, 'Canadian rapper and singer, one of the best-selling music artists.'),
(3, 'Arijit Singh', 'India', 62000000, TRUE, 'Indian playback singer, popular in Bollywood films.'),
(4, 'BTS', 'South Korea', 55000000, TRUE, 'South Korean boy band, global K-pop phenomenon.'),
(5, 'Ed Sheeran', 'United Kingdom', 89000000, TRUE, 'English singer-songwriter known for acoustic pop hits.'),
(6, 'A.R. Rahman', 'India', 45000000, TRUE, 'Indian composer, won Academy Award for Slumdog Millionaire.'),
(7, 'Billie Eilish', 'United States', 72000000, TRUE, 'American singer known for dark pop and whisper vocals.'),
(8, 'The Weeknd', 'Canada', 81000000, TRUE, 'Canadian singer known for R&B and synth-pop style.');

INSERT INTO Albums (AlbumID, ArtistID, AlbumName, ReleaseDate, AlbumType, CoverImage, TotalTracks) VALUES
(1, 1, 'Midnights', '2022-10-21', 'Album', 'covers/midnights.jpg', 13),
(2, 1, '1989 (Taylors Version)', '2023-10-27', 'Album', 'covers/1989_tv.jpg', 21),
(3, 2, 'For All The Dogs', '2023-10-06', 'Album', 'covers/for_all_the_dogs.jpg', 23),
(4, 3, 'Best of Arijit Singh', '2021-06-15', 'Album', 'covers/arijit_best.jpg', 15),
(5, 4, 'Map of the Soul: 7', '2020-02-21', 'Album', 'covers/mots7.jpg', 20),
(6, 5, 'Divide', '2017-03-03', 'Album', 'covers/divide.jpg', 16),
(7, 6, 'Dil Se', '1998-08-20', 'Album', 'covers/dil_se.jpg', 8),
(8, 7, 'Happier Than Ever', '2021-07-30', 'Album', 'covers/happier_than_ever.jpg', 16),
(9, 8, 'After Hours', '2020-03-20', 'Album', 'covers/after_hours.jpg', 14),
(10, 2, 'Gods Plan', '2018-01-19', 'Single', NULL, 1),
(11, 3, 'Tum Hi Ho', '2013-05-10', 'Single', 'covers/tum_hi_ho.jpg', 1);

INSERT INTO Songs (SongID, AlbumID, SongTitle, DurationSeconds, Language, ReleaseDate, GenreID, Explicit, AudioQuality) VALUES
(1, 1, 'Anti-Hero', 201, 'English', '2022-10-21', 1, FALSE, 'High'),
(2, 1, 'Lavender Haze', 202, 'English', '2022-10-21', 1, FALSE, 'Lossless'),
(3, 1, 'Midnight Rain', 174, 'English', '2022-10-21', 1, FALSE, 'High'),
(4, 2, 'Shake It Off', 219, 'English', '2023-10-27', 1, FALSE, 'High'),
(5, 2, 'Blank Space', 231, 'English', '2023-10-27', 1, FALSE, 'Normal'),
(6, 3, 'First Person Shooter', 247, 'English', '2023-10-06', 3, TRUE, 'High'),
(7, 3, 'Slime You Out', 318, 'English', '2023-10-06', 3, TRUE, 'High'),
(8, 4, 'Kesariya', 268, 'Hindi', '2021-06-15', 4, FALSE, 'High'),
(9, 4, 'Channa Mereya', 298, 'Hindi', '2021-06-15', 4, FALSE, 'High'),
(10, 4, 'Raabta', 243, 'Hindi', '2021-06-15', 4, FALSE, 'Normal'),
(11, 5, 'Dynamite', 199, 'English', '2020-08-21', 8, FALSE, 'High'),
(12, 5, 'Boy With Luv', 229, 'Korean', '2019-04-12', 8, FALSE, 'High'),
(13, 6, 'Shape of You', 233, 'English', '2017-01-06', 1, FALSE, 'Lossless'),
(14, 6, 'Perfect', 263, 'English', '2017-03-03', 1, FALSE, 'High'),
(15, 7, 'Chaiyya Chaiyya', 375, 'Hindi', '1998-08-20', 4, FALSE, 'Normal'),
(16, 7, 'Jiya Jale', 318, 'Hindi', '1998-08-20', 4, FALSE, 'High'),
(17, 8, 'bad guy', 194, 'English', '2019-03-29', 1, FALSE, 'High'),
(18, 8, 'Happier Than Ever', 298, 'English', '2021-07-30', 5, FALSE, 'High'),
(19, 9, 'Blinding Lights', 200, 'English', '2019-11-29', 6, FALSE, 'Lossless'),
(20, 9, 'Save Your Tears', 215, 'English', '2020-03-20', 6, FALSE, 'High'),
(21, 10, 'Gods Plan', 198, 'English', '2018-01-19', 3, TRUE, 'High'),
(22, 11, 'Tum Hi Ho', 262, 'Hindi', '2013-05-10', 4, FALSE, 'High');

INSERT INTO Playlists (PlaylistID, UserID, PlaylistName, Description, CreatedAt, Visibility) VALUES
(1, 1, 'Late Night Drives', 'songs i listen to while driving back from college', '2023-02-10 22:30:00', 'Private'),
(2, 1, 'Bollywood Favourites', 'my fav hindi songs', '2023-04-05 18:15:00', 'Public'),
(3, 3, 'Gym Mix', 'workout playlist - updated weekly', '2022-12-01 07:00:00', 'Private'),
(4, 5, 'Study Focus', 'instrumental and calm songs for exams', '2023-07-20 14:45:00', 'Private'),
(5, 6, 'Road Trip USA', NULL, '2023-01-08 10:20:00', 'Public'),
(6, 2, 'Chill Vibes', 'relaxing music after work', '2024-01-12 21:00:00', 'Private');

INSERT INTO PlaylistSongs (PlaylistID, SongID, AddedAt) VALUES
(1, 19, '2023-02-10 22:35:00'),
(1, 13, '2023-02-10 22:36:00'),
(1, 1, '2023-03-01 23:10:00'),
(1, 20, '2023-05-15 00:22:00'),
(2, 8, '2023-04-05 18:20:00'),
(2, 9, '2023-04-05 18:21:00'),
(2, 22, '2023-04-06 09:00:00'),
(2, 10, '2023-06-10 11:30:00'),
(3, 6, '2022-12-01 07:05:00'),
(3, 11, '2022-12-15 08:00:00'),
(3, 21, '2023-01-20 06:45:00'),
(3, 17, '2023-03-22 07:30:00'),
(4, 14, '2023-07-20 14:50:00'),
(4, 18, '2023-07-20 14:52:00'),
(4, 2, '2023-08-01 16:00:00'),
(5, 4, '2023-01-08 10:25:00'),
(5, 13, '2023-01-08 10:26:00'),
(5, 19, '2023-02-14 12:00:00'),
(6, 15, '2024-01-12 21:05:00'),
(6, 16, '2024-01-12 21:06:00'),
(6, 8, '2024-02-01 19:30:00');

INSERT INTO ListeningHistory (HistoryID, UserID, SongID, PlayedAt, DurationPlayed, Completed) VALUES
(1, 1, 8, '2024-06-01 08:15:00', 268, TRUE),
(2, 1, 19, '2024-06-01 22:40:00', 200, TRUE),
(3, 1, 1, '2024-06-02 07:30:00', 150, FALSE),
(4, 2, 22, '2024-06-03 19:20:00', 262, TRUE),
(5, 2, 9, '2024-06-03 19:25:00', 298, TRUE),
(6, 3, 6, '2024-06-04 06:10:00', 247, TRUE),
(7, 3, 11, '2024-06-04 06:15:00', 199, TRUE),
(8, 5, 14, '2024-06-05 14:00:00', 263, TRUE),
(9, 5, 18, '2024-06-05 14:05:00', 120, FALSE),
(10, 6, 4, '2024-06-06 11:30:00', 219, TRUE),
(11, 6, 13, '2024-06-06 11:35:00', 233, TRUE),
(12, 7, 15, '2024-06-07 20:00:00', 375, TRUE),
(13, 7, 17, '2024-06-08 21:45:00', 194, TRUE),
(14, 1, 13, '2024-06-09 09:00:00', 233, TRUE),
(15, 4, 12, '2024-06-10 16:20:00', 229, TRUE),
(16, 3, 21, '2024-06-11 07:00:00', 198, TRUE),
(17, 5, 2, '2024-06-12 23:30:00', 202, TRUE),
(18, 6, 19, '2024-06-13 08:45:00', 200, TRUE),
(19, 2, 10, '2024-06-14 18:00:00', 243, TRUE),
(20, 1, 20, '2024-06-15 00:10:00', 215, TRUE);

INSERT INTO SubscriptionPlans (PlanID, PlanName, Price, Duration, MaxDevices) VALUES
(1, 'Free', 0.00, 'Unlimited', 1),
(2, 'Premium Individual', 119.00, '1 Month', 1),
(3, 'Family', 179.00, '1 Month', 6);

INSERT INTO Payments (PaymentID, UserID, PlanID, Amount, PaymentDate, PaymentMethod) VALUES
(1, 1, 2, 119.00, '2023-01-16', 'UPI'),
(2, 3, 2, 119.00, '2022-11-22', 'Card'),
(3, 5, 2, 119.00, '2023-06-03', 'UPI'),
(4, 6, 2, 119.00, '2022-08-12', 'Card'),
(5, 1, 2, 119.00, '2024-01-14', 'UPI'),
(6, 6, 2, 119.00, '2023-08-10', 'Card'),
(7, 3, 3, 179.00, '2024-02-01', 'Card'),
(8, 8, 2, 119.00, '2023-09-18', 'Card'),
(9, 7, 2, 119.00, '2024-05-25', 'Net Banking'),
(10, 5, 3, 179.00, '2024-05-02', 'UPI');
