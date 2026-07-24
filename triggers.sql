USE SpotifyAnalytics;

DELIMITER //

-- Set default Status to Active when a new user is inserted without one
DROP TRIGGER IF EXISTS trg_users_before_insert_status //
CREATE TRIGGER trg_users_before_insert_status
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    IF NEW.Status IS NULL THEN
        SET NEW.Status = 'Active';
    END IF;
END //

-- Prevent negative payment amounts from being inserted
DROP TRIGGER IF EXISTS trg_payments_before_insert_amount //
CREATE TRIGGER trg_payments_before_insert_amount
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.Amount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment amount cannot be negative';
    END IF;
END //

-- Set default AudioQuality to High when a new song is inserted without one
DROP TRIGGER IF EXISTS trg_songs_before_insert_audio_quality //
CREATE TRIGGER trg_songs_before_insert_audio_quality
BEFORE INSERT ON Songs
FOR EACH ROW
BEGIN
    IF NEW.AudioQuality IS NULL THEN
        SET NEW.AudioQuality = 'High';
    END IF;
END //

-- Set default Visibility to Private when a new playlist is inserted without one
DROP TRIGGER IF EXISTS trg_playlists_before_insert_visibility //
CREATE TRIGGER trg_playlists_before_insert_visibility
BEFORE INSERT ON Playlists
FOR EACH ROW
BEGIN
    IF NEW.Visibility IS NULL THEN
        SET NEW.Visibility = 'Private';
    END IF;
END //

-- Prevent DurationPlayed from exceeding the song's actual duration
DROP TRIGGER IF EXISTS trg_listeninghistory_before_insert_duration //
CREATE TRIGGER trg_listeninghistory_before_insert_duration
BEFORE INSERT ON ListeningHistory
FOR EACH ROW
BEGIN
    DECLARE v_SongDuration INT;

    SELECT DurationSeconds
    INTO v_SongDuration
    FROM Songs
    WHERE SongID = NEW.SongID;
    IF NEW.DurationPlayed IS NOT NULL
       AND NEW.DurationPlayed > v_SongDuration THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'DurationPlayed cannot be greater than song duration';
    END IF;
END //

DELIMITER ;
