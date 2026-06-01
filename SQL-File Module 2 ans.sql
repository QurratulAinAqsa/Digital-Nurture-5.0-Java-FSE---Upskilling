CREATE DATABASE CommunityEventPortal;
USE CommunityEventPortal;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL
);

CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    city VARCHAR(100) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    status ENUM('upcoming','completed','cancelled'),
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES Users(user_id)
);

CREATE TABLE Sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    title VARCHAR(200) NOT NULL,
    speaker_name VARCHAR(100) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    registration_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Resources (
    resource_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    resource_type ENUM('pdf','image','link'),
    resource_url VARCHAR(255) NOT NULL,
    uploaded_at DATETIME NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);


SELECT u.full_name,e.title,e.city,e.start_date
FROM Users u
JOIN Registrations r ON u.user_id=r.user_id
JOIN Events e ON r.event_id=e.event_id
WHERE e.status='upcoming'
AND u.city=e.city
ORDER BY e.start_date;


SELECT e.title,
AVG(f.rating) AS avg_rating,
COUNT(f.feedback_id) AS total_feedback
FROM Events e
JOIN Feedback f ON e.event_id=f.event_id
GROUP BY e.event_id
HAVING COUNT(f.feedback_id)>=10
ORDER BY avg_rating DESC;


SELECT *
FROM Users
WHERE user_id NOT IN (
SELECT DISTINCT user_id
FROM Registrations
WHERE registration_date >= CURDATE()-INTERVAL 90 DAY
);


SELECT e.title,
COUNT(*) AS session_count
FROM Sessions s
JOIN Events e ON s.event_id=e.event_id
WHERE TIME(s.start_time) BETWEEN '10:00:00' AND '12:00:00'
GROUP BY e.title;

SELECT u.city,
COUNT(DISTINCT r.registration_id) AS registrations
FROM Users u
JOIN Registrations r ON u.user_id=r.user_id
GROUP BY u.city
ORDER BY registrations DESC
LIMIT 5;

SELECT e.title,
COUNT(r.resource_id) AS total_resources
FROM Events e
LEFT JOIN Resources r
ON e.event_id=r.event_id
GROUP BY e.title;

SELECT u.full_name,
e.title,
f.rating,
f.comments
FROM Feedback f
JOIN Users u ON f.user_id=u.user_id
JOIN Events e ON f.event_id=e.event_id
WHERE f.rating < 3;

SELECT e.title,
COUNT(s.session_id) AS total_sessions
FROM Events e
LEFT JOIN Sessions s
ON e.event_id=s.event_id
WHERE e.status='upcoming'
GROUP BY e.title;

SELECT u.full_name,
e.status,
COUNT(e.event_id) AS total_events
FROM Users u
JOIN Events e
ON u.user_id=e.organizer_id
GROUP BY u.full_name,e.status;

SELECT e.title
FROM Events e
JOIN Registrations r
ON e.event_id=r.event_id
LEFT JOIN Feedback f
ON e.event_id=f.event_id
WHERE f.feedback_id IS NULL
GROUP BY e.title;

SELECT registration_date,
COUNT(*) AS users_count
FROM Users
WHERE registration_date >= CURDATE()-INTERVAL 7 DAY
GROUP BY registration_date;

SELECT e.title,
COUNT(s.session_id) AS total_sessions
FROM Events e
JOIN Sessions s
ON e.event_id=s.event_id
GROUP BY e.title
ORDER BY total_sessions DESC
LIMIT 1;

SELECT e.city,
AVG(f.rating) AS avg_rating
FROM Events e
JOIN Feedback f
ON e.event_id=f.event_id
GROUP BY e.city;

SELECT e.title,
COUNT(r.registration_id) AS registrations
FROM Events e
JOIN Registrations r
ON e.event_id=r.event_id
GROUP BY e.title
ORDER BY registrations DESC
LIMIT 3;

SELECT s1.event_id,
s1.title,
s2.title
FROM Sessions s1
JOIN Sessions s2
ON s1.event_id=s2.event_id
AND s1.session_id <> s2.session_id
AND s1.start_time < s2.end_time
AND s1.end_time > s2.start_time;

SELECT *
FROM Users
WHERE registration_date >= CURDATE()-INTERVAL 30 DAY
AND user_id NOT IN
(
SELECT user_id
FROM Registrations
);

SELECT speaker_name,
COUNT(*) AS sessions_handled
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(*) > 1;

SELECT e.title
FROM Events e
LEFT JOIN Resources r
ON e.event_id=r.event_id
WHERE r.resource_id IS NULL;

SELECT e.title,
COUNT(DISTINCT r.registration_id) AS registrations,
AVG(f.rating) AS avg_rating
FROM Events e
LEFT JOIN Registrations r
ON e.event_id=r.event_id
LEFT JOIN Feedback f
ON e.event_id=f.event_id
WHERE e.status='completed'
GROUP BY e.title;

SELECT u.full_name,
COUNT(DISTINCT r.event_id) AS attended_events,
COUNT(DISTINCT f.feedback_id) AS feedback_count
FROM Users u
LEFT JOIN Registrations r
ON u.user_id=r.user_id
LEFT JOIN Feedback f
ON u.user_id=f.user_id
GROUP BY u.full_name;


SELECT u.full_name,
COUNT(f.feedback_id) AS total_feedback
FROM Users u
JOIN Feedback f
ON u.user_id=f.user_id
GROUP BY u.full_name
ORDER BY total_feedback DESC
LIMIT 5;

SELECT user_id,
event_id,
COUNT(*) AS duplicates
FROM Registrations
GROUP BY user_id,event_id
HAVING COUNT(*) > 1;

SELECT DATE_FORMAT(
registration_date,
'%Y-%m'
) AS month,
COUNT(*) AS registrations
FROM Registrations
WHERE registration_date >=
CURDATE()-INTERVAL 12 MONTH
GROUP BY month
ORDER BY month;

SELECT e.title,
AVG(
TIMESTAMPDIFF(
MINUTE,
s.start_time,
s.end_time
)
) AS avg_duration
FROM Events e
JOIN Sessions s
ON e.event_id=s.event_id
GROUP BY e.title;

SELECT e.title
FROM Events e
LEFT JOIN Sessions s
ON e.event_id=s.event_id
WHERE s.session_id IS NULL;