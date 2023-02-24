DROP TABLE IF EXISTS album_track CASCADE;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS track;


CREATE TABLE album(
    ID serial PRIMARY KEY,
    title text NOT NULL,
    Artists varchar(250) NOT NULL,
    Gender text NOT NULL,
    label varchar(250) NOT NULL,
    Genre varchar(250) NOT NULL,
    release_date DATE NOT NULL
);

INSERT INTO album(title, Artists, Gender, label, Genre, release_date)
VALUES
('The Highlights', 'The weeknd', 'Male','Universal Republic Records','R&B/Soul · Music','2021-02-05'),
('StarBoy', 'The weeknd', 'Male', 'Universal Republic Records','R&B/Soul · Music', '2016-11-25'),
('After Hours', 'The weeknd', 'Male','XO · Republic Records','R&B/Soul · Music','2020-03-20'),
('The Days/Nights', 'Avicii', 'Male','Universal Music AB','Dance · Music', '2014-01-01'),
('Native(Gold Edition)', 'OneRepublic', 'Male','Mosley · Interscope','Pop', '2013-03-22'),
('Evolve', 'Imagine Dragons', 'Male','Kid Ina Korner · Interscope','Alternative · Music','2017-06-23'),
('The Marshall Mathers LP2', 'Eminem', 'Male', 'Aftermath','Hip Hop/Rap', '2013-01-01'),
('Recovery(Deluxe Edition)', 'Eminem', 'Male','Aftermath','Hip Hop/Rap','2010-06-21'),
('StarBoy', 'The weeknd', 'Male', 'Universal Republic Records','R&B/Soul · Music', '2016-11-25'),
('Issa Album','21 savage', 'Male', 'Slaughter Gang, LLC · Epic Records','Hip Hop/Rap · Music','2017-07-07');

CREATE TABLE track(
    ID serial PRIMARY KEY,
    title text NOT NULL,
    Artists varchar(250) NOT NULL,
    length  TIME NOT NULL,
    date_released DATE NOT NULL,
    Youtube_link varchar(250) NOT NULL
);

INSERT INTO track ( title, Artists, length , date_released, Youtube_link)
VALUES
('blinding lights', 'The weeknd', '00:4:22', '2020-01-21', 'https://www.youtube.com/watch?v=4NRXx6U8ABQ'),
('After Hours', 'The weeknd', '00:6:01', '2020-02-18', 'https://www.youtube.com/watch?v=ygTZZpVkmKg'),
('Not Afraid', 'Eminem', '00:4:18', '2010-06-4', 'https://www.youtube.com/watch?v=j5-yKhDd64s'),
('Bank Account','21 savage', '00:3:40', '2017-07-06', 'https://www.youtube.com/watch?v=sV2t3tW_JTQ'),
('Reminder', 'The weeknd', '00:3:50', '2017-02-16', 'https://www.youtube.com/watch?v=JZjAg6fK-BQ'),
('False Alarm', 'The weeknd', '00:5:45', '2016-09-13', 'https://www.youtube.com/watch?v=CW5oGRx9CLM'),
('The Nights', 'Avicii', '00:3:10', '2014-02-15', 'https://www.youtube.com/watch?v=UtF6Jej8yb4'),
('Rap God', 'Eminem', '00:6:09', '2013-11-27', 'https://www.youtube.com/watch?v=XbGs_qK2PQA'),
('Counting Stars', 'OneRepublic', '00:4:43', '2013-05-31', 'https://www.youtube.com/watch?v=hT_nvWreIhg'),
('Believer', 'Imagine Dragons', '00:3:36', '2017-03-07', 'https://www.youtube.com/watch?v=7wtfhZwyrcc');


CREATE TABLE album_track (
    ID serial PRIMARY KEY,
    album_ID integer REFERENCES album(ID),
    track_ID integer REFERENCES track(ID)
);

INSERT INTO album_track(album_ID, track_ID)
VALUES
(1, 1),
(2, 5),
(2, 6),
(3, 2),
(4, 7),
(5, 9),
(6, 10),
(7, 8),
(8, 3),
(9, 6),
(9, 5),
(10, 4);
--i want to see the three tables join together with the student_course in middle.

SELECT A.title, A.Artists, A.Gender, A.label, A.Genre, A.release_date, A_T.album_ID, A_T.track_ID, T.title, T.Artists, T.length , T.date_released, T.Youtube_link
FROM album AS A
INNER JOIN album_track AS A_T
ON A.ID = A_T.album_ID
INNER JOIN track AS T 
ON A_T.track_ID = T.ID;

-- I  WANT TO see the albums and the tracks that belong to that album.
--This SQL query retrieves the album title, album artist, and track title for each track in the "album", "album_track", and "track" tables 
--by joining them based on their IDs, and sorting the results in ascending order by album title.

SELECT album.title AS album_title, album.artists AS album_artist, track.title AS track_title
FROM album
JOIN album_track ON album.ID = album_track.album_ID
JOIN track ON album_track.track_ID = track.ID
ORDER BY album_title;

--I WANT to see the album or albums that each track belongs to
--This SQL query retrieves the track title and album title for each track in the "track", "album_track", and "album" tables 
--by joining them based on their IDs, and sorting the results in ascending order by album title and track title within each album group.

SELECT track.title AS track_title, album.title AS album_title
FROM track
INNER JOIN album_track ON track.id = album_track.track_id
INNER JOIN album ON album_track.album_id = album.id
ORDER BY album_title, track_title;


--i want to see the number of songs an album has.
--This SQL query retrieves the number of songs in each album from the "album", 
--"album_track", and "track" tables by joining them based on their IDs, 
--grouping the results by album title, and counting the number of tracks in each album.

SELECT album.title, COUNT(track.ID) AS num_songs
FROM album
JOIN album_track ON album.ID = album_track.album_ID
JOIN track ON album_track.track_ID = track.ID
GROUP BY album.title;

--Write a query to see how many albums a particular track is included on.
--This SQL query retrieves the number of albums that include the "Blinding Lights" track from the "track" and "album_track" tables, 
--and filters the results to only include tracks with the title "Blinding Lights".

SELECT track.title, COUNT(*) AS num_albums
FROM track
INNER JOIN album_track ON track.ID = album_track.track_ID
GROUP BY track.title
HAVING track.title = 'blinding lights';
