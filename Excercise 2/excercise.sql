/* Question 1*/
SELECT a.Title as AlbumName, art.Name as ArtistName
FROM albums as a
    JOIN artists as art
    ON a.AlbumId = art.ArtistId
    ORDER BY art.name;

/* Question 2 */
SELECT artists.Name as ArtistName, COUNT(albums.ArtistId) as AlbumCount, albums.Title as AlbumName
FROM artists
JOIN albums
ON (artists.ArtistId = albums.ArtistId)
GROUP BY albums.Title
HAVING AlbumCount >= 1
ORDER BY albums.Title DESC;

/* Question 3*/
SELECT artists.Name as ArtistName FROM artists
WHERE artists.ArtistId NOT IN (SELECT albums.ArtistId FROM albums);

/* Question 4*/
SELECT artists.Name as ArtistName, COUNT(albums.ArtistId) as NoOfAlbums
FROM artists
JOIN albums
ON (artists.ArtistId = albums.ArtistId)
GROUP BY artists.Name
ORDER BY NoOfAlbums DESC, artists.Name ASC;

/* Question 5 */
SELECT artists.Name as ArtistName, COUNT(albums.ArtistId) as NoOfAlbums
FROM artists
JOIN albums
ON (artists.ArtistId = albums.ArtistId)
GROUP BY artists.Name
HAVING NoOfAlbums > 10
ORDER BY NoOfAlbums DESC, artists.Name ASC;

/* Question 6 */
SELECT artists.Name as ArtistName, COUNT(albums.ArtistId) as NoOfAlbums
FROM artists
JOIN albums
ON (artists.ArtistId = albums.ArtistId)
GROUP BY artists.Name
ORDER BY NoOfAlbums DESC
LIMIT 3;

/* Question 7 */
SELECT artists.Name as ArtistName, albums.Title As Title ,tracks.TrackId as TrackID
FROM artists
JOIN tracks
JOIN albums
WHERE artists.Name = 'Santana'
ORDER BY TrackID;

/* Question 8*/
SELECT employees.EmployeeId as 'Employee ID',
    (SELECT employees.FirstName || employees.LastName) AS 'Empyloyee Name',
    employees.Title AS 'Empyloyee Title',
    employees.ReportsTo AS 'Manager ID',
    i.FirstName as 'Manager Name',
    i.Title as 'Manager Title'
    FROM employees
    INNER JOIN employees AS i ON i.EmployeeId = employees.ReportsTo;

/* Question 9 */
CREATE VIEW top_employees
AS
SELECT employees.EmployeeId as emp_id,
(SELECT employees.FirstName || employees.LastName) AS 'Empyloyee Name',
COUNT(customers.CustomerId) as cust_count
FROM employees
JOIN customers
ON employees.EmployeeId = customers.SupportRepId
GROUP BY employees.FirstName
LIMIT 3;

SELECT * FROM top_employees;
DROP VIEW top_employees;

/* Question 10 */
CREATE TRIGGER trg_media_types
    BEFORE INSERT ON media_types
    BEGIN
        SELECT CASE
            WHEN NEW.Name NOT LIKE '%MP3%' THEN
            RAISE (ABORT, 'MP3 CAN NOT BE INSERTED')
        END;
    END;

/* Question 11 */

CREATE TABLE tracks_audit_log (
    operation varchar(80),
    datetime date,
    username varchar(80),
    old_value varchar(80),
    new_value varchar(80)
);

CREATE TRIGGER tracks_audit
AFTER INSERT ON tracks
BEGIN
    INSERT INTO tracks_audit_log (operation, datetime, username, old_value, new_value)
    VALUES ('insert',DATE('now'),'admin',OLD.Title,NEW.Title);
END;

CREATE TRIGGER tracks_audit_update
AFTER UPDATE ON tracks
BEGIN
    INSERT INTO tracks_audit_log (operation, datetime, username, old_value, new_value)
    VALUES ('insert',DATE('now'),'admin',OLD.Title,NEW.Title);
END;
