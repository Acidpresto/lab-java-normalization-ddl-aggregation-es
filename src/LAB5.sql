USE EXERCICES;

##EXERCICE_1
CREATE TABLE authors(
author_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
author_name VARCHAR(255) NOT NULL
);

CREATE TABLE books(
book_id INT NOT NULL AUTO_INCREMENT,
title VARCHAR (255) NOT NULL,
word_count INT NOT NULL ,
views INT NOT NULL,
author_id VARCHAR(255) NOT NULL,
PRIMARY KEY (book_id),
FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

INSERT INTO authors (author_name)VALUES
('Maria Charlotte'),
('Juan Perez' ),
('Gemma Alcocer' );


INSERT INTO books (title, word_count, views, author_id)VALUES
('Best Paint Colors', 	814,	14,1),
('Small Space Decorating Tips',1146,221,2),
('Hot Accessories',986,	105,1),
('Mixing Textures',765,	22,1),
('Kitchen Refresh',1242,307,2),
('Homemade Art Hacks',1002,193,1),
('Refinishing Wood Floors',1571,7542,3);

##EXERCICE_2

DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS aircrafts;

CREATE TABLE customers(
customer_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
customer_name VARCHAR(255) NOT NULL ,
customer_status VARCHAR(255) NOT NULL,
total_customer_milage INT NOT NULL
);

CREATE TABLE aircrafts(
aircraft_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
aircraft VARCHAR(255) NOT NULL,
total_seats INT NOT NULL
);

CREATE TABLE flights(
flight_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
flight_name VARCHAR(255)NOT NULL,
aircraft_id INT NOT NULL ,
flight_mileage INT NOT NULL,
FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id)
);

CREATE TABLE bookings(
customer_id INT NOT NULL,
flight_id INT NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
FOREIGN KEY (flight_id) REFERENCES flights (flight_id)
);

INSERT INTO customers (customer_name, customer_status, total_customer_milage) VALUES
('Agustine Riviera', 'Silver', 115235),
('Alaina Sepulvida', 'None', 6008),
('Tom Jones', 'Gold', 205767),
('Sam Rio', 'None', 2653),
('Jessica James', 'Silver', 127656),
('Ana Janco', 'Silver', 136773),
('Jennifer Cortez', 'Gold', 300582),
('Christian Janco', 'Silver', 14642);

INSERT INTO aircrafts (aircraft, total_seats) VALUES
('Boeing 747', 400),
('Airbus A330', 236),
('Boeing 777', 264);

INSERT INTO flights (flight_name, aircraft_id, flight_mileage) VALUES
('DL143', 1, 135),
('DL122', 2, 4370),
('DL53', 3, 2078),
('DL222', 3, 1765),
('DL37', 1, 531);

INSERT INTO bookings (customer_id, flight_id)
SELECT
c.customer_id,
f.flight_id
FROM (
SELECT 'Agustine Riviera' AS customer_name, 'DL143' AS flight_name UNION ALL
SELECT 'Agustine Riviera', 'DL122' UNION ALL
SELECT 'Alaina Sepulvida', 'DL122' UNION ALL
SELECT 'Tom Jones', 'DL122' UNION ALL
SELECT 'Tom Jones', 'DL53' UNION ALL
SELECT 'Sam Rio', 'DL143' UNION ALL
SELECT 'Tom Jones', 'DL222' UNION ALL
SELECT 'Jessica James', 'DL143' UNION ALL
SELECT 'Ana Janco', 'DL222' UNION ALL
SELECT 'Jennifer Cortez', 'DL222' UNION ALL
SELECT 'Jessica James', 'DL122' UNION ALL
SELECT 'Sam Rio', 'DL37' UNION ALL
SELECT 'Christian Janco', 'DL222'
) AS data
JOIN customers c ON data.customer_name = c.customer_name
JOIN flights f ON data.flight_name = f.flight_name;
#EXERCICE 3
#1
SELECT COUNT(flight_id)
FROM flights;
#2
SELECT AVG(flight_mileage)
FROM flights;
#3
SELECT AVG(total_seats)
FROM aircrafts;
#4
SELECT customer_status, AVG(total_customer_milage) AS average_mileage
FROM customers
GROUP BY customer_status;
#5
SELECT customer_status, MAX(total_customer_milage)
FROM customers
GROUP BY customer_status;
#6
SELECT COUNT(aircraft)  AS Boeing_flights
FROM aircrafts
WHERE aircraft LIKE '%Boeing%';
#7
SELECT flight_name
FROM flights
WHERE flight_mileage BETWEEN 300 AND  2000
GROUP BY flight_name;
#8
SELECT customer_status,AVG(flight_mileage) AS average_mileage
FROM flights a
JOIN bookings b ON a.flight_id = b.flight_id
JOIN customers c ON b.customer_id = c.customer_id
GROUP BY customer_status;
#9
SELECT a.aircraft, COUNT(*) AS Gold_preference
FROM bookings b
JOIN flights c ON b.flight_id = c.flight_id
JOIN aircrafts a ON a.aircraft_id = c.aircraft_id
JOIN customers d ON b.customer_id = d.customer_id
WHERE d.customer_status = 'Gold'
GROUP BY a.aircraft
LIMIT 1
;
