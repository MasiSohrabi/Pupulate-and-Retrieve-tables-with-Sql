USE Chinook
GO

--?Write a query to find a shortest track in tbl_Track table, using derived table
SELECT *
FROM
(
SELECT
rownum = ROW_NUMBER()
OVER
(
ORDER BY
Milliseconds 
)
,TrackId
,Name
,AlbumId
,Milliseconds
,Bytes
,UnitPrice
FROM tbl_Track
) AS D
WHERE rownum <= 1;
GO

--?	Write yet another query to find a shortest track for all artists in tbl_Track table, ?using CTE
WITH C AS
(
SELECT
rownum = ROW_NUMBER()
OVER
(
PARTITION BY AR.ArtistId
ORDER BY
T.Milliseconds 
)
,Ar.ArtistId
,AR.Name as artist
,T.TrackId
,T.Name  as track
,T.AlbumId
,T.Milliseconds
,T.Bytes
,T.UnitPrice
FROM tbl_Track  AS T
INNER JOIN tbl_Album AS A ON
A.AlbumId=T.AlbumId
INNER JOIN tbl_Artist As AR ON 
Ar.ArtistId=A.ArtistId
) 
SELECT *
FROM C
WHERE rownum=1;

--?	New query should list all artists and number of their albums from tbl_Artist, using ?grouping

SELECT AR.ArtistId
	  ,AR.Name AS ARTIST
      ,COUNT(A.AlbumId)  AS NumebrOfAlbum
FROM tbl_Album as A
INNER JOIN tbl_Artist As AR ON 
Ar.ArtistId=A.ArtistId
Group by AR.ArtistId
		,AR.Name

--	List all artists, number of tracks, minimum, maximum and total size (in bytes) of? 
--tracks for all of their albums. Use tbl_Artist (for artist name) and tbl_Track table
SELECT   AR.ArtistId
        ,A.AlbumId
		,AR.Name AS Artist
		,COUNT(T.trackId) AS NumberOfTrack
		,Min(Bytes) AS MIN
		,Max(Bytes) AS MAX
		--,sum(Bytes)
FROM tbl_Track  AS T
INNER JOIN tbl_Album AS A ON
A.AlbumId=T.AlbumId
INNER JOIN tbl_Artist As AR ON 
Ar.ArtistId=A.ArtistId
Group by AR.ArtistId
		 ,A.AlbumId
		 ,AR.Name