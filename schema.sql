
CREATE DATABASE IF NOT EXISTS SpotifyAnalytics;

USE SpotifyAnalytics;

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,

    Username VARCHAR(50) NOT NULL,

    Email VARCHAR(100) NOT NULL UNIQUE,

    PasswordHash VARCHAR(255) NOT NULL,

    DateJoined DATE NOT NULL DEFAULT (CURRENT_DATE),

    Country VARCHAR(50) NOT NULL,

    DateOfBirth DATE,

    IsPremium BOOLEAN DEFAULT FALSE,

    ProfileImage VARCHAR(255),

    Status ENUM('Active','Suspended','Deleted')
    DEFAULT 'Active'
);

CREATE TABLE Artists (

    ArtistID INT AUTO_INCREMENT PRIMARY KEY,

    ArtistName VARCHAR(100) NOT NULL,

    Country VARCHAR(50),

    MonthlyListeners BIGINT DEFAULT 0,

    Verified BOOLEAN DEFAULT FALSE,

    Biography TEXT,

    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

CREATE TABLE Albums (

    AlbumID INT AUTO_INCREMENT PRIMARY KEY,

    ArtistID INT NOT NULL,

    AlbumName VARCHAR(150) NOT NULL,

    ReleaseDate DATE,

    AlbumType ENUM('Single','EP','Album'),

    CoverImage VARCHAR(255),

    TotalTracks INT DEFAULT 0,

    FOREIGN KEY (ArtistID)

    REFERENCES Artists(ArtistID)

);

CREATE TABLE Songs (

    SongID INT AUTO_INCREMENT PRIMARY KEY,

    AlbumID INT NOT NULL,

    SongTitle VARCHAR(150) NOT NULL,

    DurationSeconds INT NOT NULL,

    Language VARCHAR(50),

    ReleaseDate DATE,

GenreID INT NOT NULL,

Explicit BOOLEAN DEFAULT FALSE,

AudioQuality ENUM('Low','Normal','High','Lossless')
DEFAULT 'High',

FOREIGN KEY (AlbumID)
REFERENCES Albums(AlbumID),

FOREIGN KEY (GenreID)
REFERENCES Genres(GenreID)
);


CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Playlists (
    PlaylistID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    PlaylistName VARCHAR(100) NOT NULL,
    Description TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Visibility ENUM('Public','Private') DEFAULT 'Private',

    FOREIGN KEY (UserID)
    REFERENCES Users(UserID)
);

CREATE TABLE PlaylistSongs (
    PlaylistID INT,
    SongID INT,
    AddedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (PlaylistID, SongID),

    FOREIGN KEY (PlaylistID)
    REFERENCES Playlists(PlaylistID),

    FOREIGN KEY (SongID)
    REFERENCES Songs(SongID)
);

CREATE TABLE ListeningHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,

    UserID INT NOT NULL,

    SongID INT NOT NULL,

    PlayedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    DurationPlayed INT,

    Completed BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (UserID)
    REFERENCES Users(UserID),

    FOREIGN KEY (SongID)
    REFERENCES Songs(SongID)
);

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,

    UserID INT NOT NULL,

    PlanID INT NOT NULL,

    Amount DECIMAL(6,2) NOT NULL,

    PaymentDate DATE NOT NULL,

    PaymentMethod ENUM(
        'UPI',
        'Card',
        'Net Banking'
    ),

    FOREIGN KEY (UserID)
    REFERENCES Users(UserID),

    FOREIGN KEY (PlanID)
    REFERENCES SubscriptionPlans(PlanID)
);