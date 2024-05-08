-- Part 1 -- Creating Database
CREATE DATABASE FoodserviceDB;

USE FoodserviceDB;
--Creating Schema
CREATE SCHEMA Foodservice;
GO

ALTER TABLE Foodservice.Ratings
ADD CONSTRAINT FK_Ratings_Consumers FOREIGN KEY (Consumer_id) REFERENCES Foodservice.Consumers(Consumer_id);

ALTER TABLE Foodservice.Ratings
ADD CONSTRAINT FK_Ratings_Restaurant FOREIGN KEY (Restaurant_id) REFERENCES Foodservice.Restaurant(Restaurant_id);

ALTER TABLE Foodservice.Restaurant_Cuisines
ADD CONSTRAINT FK_Restaurant_Cuisines_Restaurant FOREIGN KEY (Restaurant_id) REFERENCES Foodservice.Restaurant(Restaurant_id);

-- Part 2 --
-- Retrieving all restaurants with a Medium range price, an open area, and serving Mexican food--

SELECT r.*
FROM Foodservice.Restaurant r
INNER JOIN Foodservice.Restaurant_Cuisines rc ON r.Restaurant_id = rc.Restaurant_id
WHERE r.Price = 'Medium' 
  AND r.Area = 'Open' 
  AND rc.Cuisine = 'Mexican';

--Total Number of Restaurants with Overall Rating 1 Serving Mexican or Italian Food

-- For Mexican Food --
SELECT COUNT(DISTINCT r.Restaurant_id) AS Mexican_Restaurants_Overall_Rating_1
FROM Foodservice.Restaurant r
INNER JOIN Foodservice.Ratings ra ON r.Restaurant_id = ra.Restaurant_id
INNER JOIN Foodservice.Restaurant_Cuisines rc ON r.Restaurant_id = rc.Restaurant_id
WHERE ra.Overall_Rating = 1
  AND rc.Cuisine = 'Mexican';

-- For Italian Food --
SELECT COUNT(DISTINCT r.Restaurant_id) AS Italian_Restaurants_Overall_Rating_1
FROM Foodservice.Restaurant r
INNER JOIN Foodservice.Ratings ra ON r.Restaurant_id = ra.Restaurant_id
INNER JOIN Foodservice.Restaurant_Cuisines rc ON r.Restaurant_id = rc.Restaurant_id
WHERE ra.Overall_Rating = 1
  AND rc.Cuisine = 'Italian';



--calculate the average age of consumers who have given a 0 rating to the 'Service_rating' column --

SELECT ROUND(AVG(c.Age), 2) AS Average_Age
FROM Foodservice.Consumers c
INNER JOIN Foodservice.Ratings r ON c.Consumer_id = r.Consumer_id
WHERE r.Service_Rating = 0;


--query that returns the restaurants ranked by the youngest consumer --
SELECT r.Name AS Restaurant_Name, r.Restaurant_id, ra.Food_Rating
FROM Foodservice.Restaurant r
INNER JOIN Foodservice.Ratings ra ON r.Restaurant_id = ra.Restaurant_id
INNER JOIN (
    SELECT Consumer_id, MIN(Age) AS Min_Age
    FROM Foodservice.Consumers
    GROUP BY Consumer_id
) AS youngest ON ra.Consumer_id = youngest.Consumer_id
INNER JOIN Foodservice.Consumers c ON ra.Consumer_id = c.Consumer_id AND c.Age = youngest.Min_Age
ORDER BY ra.Food_Rating DESC;


-- Update Service_rating to '2' for restaurants with parking available --

CREATE PROCEDURE UpdateServiceRating
AS
BEGIN
    UPDATE ra
    SET ra.Service_Rating = 2
    FROM Foodservice.Ratings ra
    INNER JOIN Foodservice.Restaurant r ON ra.Restaurant_id = r.Restaurant_id
    WHERE r.Parking IN ('yes', 'public');
END;

--Testing Stored Procedure
EXEC UpdateServiceRating;
SELECT * FROM Foodservice.Ratings;


--Query 1: List of Restaurants with Most Ratings:--

SELECT r.Restaurant_id, r.Name, COUNT(*) AS Total_Ratings
FROM Foodservice.Restaurant r
INNER JOIN Foodservice.Ratings ra ON r.Restaurant_id = ra.Restaurant_id
GROUP BY r.Restaurant_id, r.Name
ORDER BY Total_Ratings DESC;


--Query 2: Average Age of Consumers who Rated Mexican Restaurants:--

SELECT ROUND(AVG(c.Age), 2) AS Avg_Age_Mexican_Restaurants
FROM Foodservice.Consumers c
WHERE EXISTS (
    SELECT 1
    FROM Foodservice.Ratings ra
    INNER JOIN Foodservice.Restaurant_Cuisines rc ON ra.Restaurant_id = rc.Restaurant_id
    WHERE ra.Consumer_id = c.Consumer_id
      AND rc.Cuisine = 'Mexican'
);


-- Query 3: Restaurants with Zero Ratings:--

SELECT r.Restaurant_id, r.Name
FROM Foodservice.Restaurant r
INNER JOIN Foodservice.Ratings ra ON r.Restaurant_id = ra.Restaurant_id
WHERE ra.Overall_Rating = 0;


-- Query 4: Average Overall Rating for Each City:--

SELECT r.City, ROUND(AVG(ra.Overall_Rating), 2) AS Avg_Overall_Rating
FROM Foodservice.Restaurant r
INNER JOIN Foodservice.Ratings ra ON r.Restaurant_id = ra.Restaurant_id
GROUP BY r.City
HAVING AVG(ra.Overall_Rating) >= 1
ORDER BY Avg_Overall_Rating DESC;
