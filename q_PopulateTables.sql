USE Chinook
GO
DROP TABLE IF EXISTS tbl_Album, tbl_Artist,tbl_Track;
GO


--Write statements to generate empty tbl_Album, tbl_Artist and tbl_Track tables, ?based on Album,Artist and Track tables, using SELECT INTO command
SELECT * 
INTO tbl_Artist 
FROM Artist
WHERE 1=2;
ALTER TABLE tbl_Artist
ADD CONSTRAINT PK_tbl_Artist PRIMARY KEY(ArtistId);

SELECT * 
INTO tbl_Album 
FROM Album 
WHERE 1=2;
ALTER TABLE tbl_Album
ADD CONSTRAINT PK_tbl_Album PRIMARY KEY(AlbumId);
ALTER TABLE tbl_Album
ADD CONSTRAINT FK_tbl_Album FOREIGN KEY (ArtistId) REFERENCES tbl_Artist (ArtistId);

SELECT * 
INTO tbl_Track
FROM Track
WHERE 1=2;
ALTER TABLE tbl_Track
ADD CONSTRAINT PK_tbl_Track PRIMARY KEY(TrackId);
ALTER TABLE tbl_Track
ADD CONSTRAINT FK_tbl_Track_Album FOREIGN KEY (AlbumId) REFERENCES tbl_Album (AlbumId);


--	Insert all artists in tbl_Artist, from Artist table, whose name starts with P and Q
INSERT INTO tbl_Artist
(
		ArtistId
		,Name
)
SELECT 
		ArtistId
		,Name
FROM Artist
WHere Name like 'P%' OR Name like 'Q%' ;


--	Delete all artists from tbl_Artist table with name starting with Q? 
DELETE FROM tbl_Artist WHERE Name LIKE 'Q%';


--	Truncate tbl_Artist table
TRUNCATE TABLE tbl_Artist ;

--	Insert all artists in tbl_Artist, from Artist table, whose name starts with B
INSERT INTO tbl_Artist
(
		ArtistId
		,Name
)
SELECT 
		ArtistId
		,Name
FROM Artist
WHere Name like 'B%';

--	Insert all albums in tbl_Album, from Album table, for all artists in tbl_Artist table
INSERT INTO tbl_Album
    SELECT *
      FROM Album 
     WHERE ArtistId IN 
	 (
	 SELECT ArtistId
	 FROM tbl_Artist );

--Insert all tracks in tbl_Track, from Track table, for all albums in tbl_Album
INSERT INTO tbl_Track
    SELECT *
      FROM Track
     WHERE AlbumId IN 
	 (
	 SELECT AlbumId
	 FROM tbl_Album );

--	Insert new artist using values, name is ‘Berliner Philharmoniker & Simon Rattle’?
INSERT INTO tbl_Artist
(
    ArtistId
	,Name
)
VALUES( 276, 'Berliner Philharmonik & Simon Rattle' );


--	Insert two new albums using values for new artist, include proper ArtistID1.?	
	
INSERT INTO tbl_Album
(
    AlbumId,
	Title,
	ArtistId

)
VALUES (339, 'Tchaikovsky: The Nutcracker' ,276)
,  ( 340, 'Mahler: Symphony No. 6', 276);




--Insert tracks for two new albums, use tracks from tbl_Track table with AlbumId?

INSERT INTO tbl_Track
(	TrackId
	,Name
	,AlbumId
	,MediaTypeId
	,GenreId
	,Composer
	,Milliseconds
	,Bytes
	,UnitPrice
)
    SELECT
	 TrackId
	,Name
	,AlbumId
	,MediaTypeId
	,GenreId
	,Composer
	,Milliseconds
	,Bytes
	,UnitPrice
     FROM Track
     WHERE AlbumId=339 or AlbumId=340





