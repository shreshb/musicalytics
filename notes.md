# Spotify Analytics Database

## Project Objective

Design and implement a production-quality relational database for a music streaming platform similar to Spotify using MySQL.

The database will support:

- User Management
- Music Catalog
- Artist Management
- Albums
- Playlists
- Listening History
- Subscription Plans
- Analytics & Reporting

---

## Why are we building this?

Spotify stores millions of users, songs, playlists, artists, and billions of listening events every day.

Instead of storing everything in one table, we design a normalized relational database where each entity has its own table.

This improves:

- Data Integrity
- Scalability
- Performance
- Maintainability

---

## Project Goals

- Design a normalized database (3NF)
- Build relationships using Primary Keys and Foreign Keys
- Perform analytical SQL queries
- Implement Views
- Implement Stored Procedures
- Implement Triggers
- Optimize queries using Indexes

# Core Entities

1. Users
   - Stores account information.

2. Artists
   - Stores artist information.

3. Albums
   - Stores music albums.

4. Songs
   - Stores songs.

5. Playlists
   - Stores playlists created by users.

6. ListeningHistory
   - Stores every listening event.

7. SubscriptionPlans
   - Stores Premium, Student and Family plans.

8. Payments
   - Stores subscription payments.

9. Devices
   - Stores listening devices.

10. Genres
   - Stores music genres.

   # User Journey

User
 │
 ▼
Logs In
 │
 ▼
Searches Song
 │
 ▼
Streams Song
 │
 ▼
ListeningHistory
 │
 ▼
Likes Song
 │
 ▼
Adds Song To Playlist
 │
 ▼
Purchases Subscription

# Relationships

User (1) ---- (M) Playlist

Artist (1) ---- (M) Album

Album (1) ---- (M) Song

Playlist (M) ---- (M) Song
Resolved using PlaylistSongs

User (M) ---- (M) Song
Resolved using ListeningHistory

SubscriptionPlan (1) ---- (M) UserSubscription

User (1) ---- (M) Payment

# Table Design

## Users

Purpose:
Stores all Spotify users.

Columns:

UserID
Username
Email
PasswordHash
DateJoined
Country
DateOfBirth
IsPremium
ProfileImage
Status

## Artists

Purpose:
Stores artist information.

Columns:

ArtistID
ArtistName
Country
MonthlyListeners
Verified
Biography
CreatedAt

## Albums

Purpose:
Stores albums released by artists.

Columns:

AlbumID
ArtistID
AlbumName
ReleaseDate
AlbumType
CoverImage
TotalTracks

## Songs

Purpose:
Stores every song.

Columns:

SongID
AlbumID
SongTitle
Duration
Language
ReleaseDate
Explicit
AudioQuality

## Playlists

Purpose:
Stores playlists created by users.

Columns:

PlaylistID
UserID
PlaylistName
Description
CreatedAt
Visibility

## ListeningHistory

HistoryID

UserID

SongID

DeviceID

PlayedAt

ListeningDuration

Completed

Skipped

## Devices

DeviceID

DeviceName

DeviceType

OperatingSystem

## SubscriptionPlans

PlanID

PlanName

Price

Duration

MaxDevices

## UserSubscriptions

SubscriptionID

UserID

PlanID

StartDate

EndDate

Status

## Payments

PaymentID

UserID

Amount

PaymentMethod

PaymentDate

