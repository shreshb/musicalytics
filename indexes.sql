USE SpotifyAnalytics;

-- Index for searching users by username
CREATE INDEX idx_users_username
ON Users(Username);

-- Index for searching users by email
CREATE INDEX idx_users_email
ON Users(Email);

-- Index for searching songs by title
CREATE INDEX idx_songs_title
ON Songs(SongTitle);

-- Index for joining and filtering songs by genre
CREATE INDEX idx_songs_genre
ON Songs(GenreID);

-- Index for joining songs with albums
CREATE INDEX idx_songs_album
ON Songs(AlbumID);

-- Index for joining albums with artists
CREATE INDEX idx_albums_artist
ON Albums(ArtistID);

-- Index for finding listening history by user
CREATE INDEX idx_listeninghistory_user
ON ListeningHistory(UserID);

-- Index for finding listening history by song
CREATE INDEX idx_listeninghistory_song
ON ListeningHistory(SongID);

-- Index for finding payments by user
CREATE INDEX idx_payments_user
ON Payments(UserID);

-- Index for filtering and sorting payments by date
CREATE INDEX idx_payments_date
ON Payments(PaymentDate);

-- Index for finding playlists created by a user
CREATE INDEX idx_playlists_user
ON Playlists(UserID);

-- Index for finding songs in a playlist
CREATE INDEX idx_playlistsongs_playlist
ON PlaylistSongs(PlaylistID);

-- Index for finding playlists containing a song
CREATE INDEX idx_playlistsongs_song
ON PlaylistSongs(SongID);