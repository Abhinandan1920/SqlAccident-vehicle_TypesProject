CREATE DATABASE accidents102;

use accidents102;

CREATE TABLE accident (
    Accident_Index VARCHAR(255) NOT NULL,
    Police_Force INT,
    Accident_Severity INT,
    Number_of_Vehicles INT,
    Number_of_Casualties INT,
    Date VARCHAR(255),
    Day_of_Week INT,
    Time VARCHAR(255),
    Road_Type INT,
    Speed_limit INT,
    Junction_Detail INT,
    Pedestrian_Crossing_Physical_Facilities INT,
    Light_Conditions INT,
    Weather_Conditions INT,
    Road_Surface_Conditions INT,
    Urban_or_Rural_Area INT,
    Did_Police_Officer_Attend_Scene_of_Accident INT,
    PRIMARY KEY (Accident_Index)
);

CREATE TABLE vehicles (
    Accident_Index VARCHAR(255),
    Vehicle_Type INT,
    Skidding_and_Overturning INT,
    Sex_of_Driver INT,
    Age_of_Driver INT
);

CREATE TABLE vehicle_types(
 vehicle_code INT,
 vehicle_type VARCHAR(10)
);

SELECT * FROM accident;

-- Query 1 Get all accidents that Occured on a specific date
SELECT * FROM accident WHERE DATE ='12-01-2015';

-- Query 2 List all Vehicles types involved in accidents

SELECT vehicle_Type from vehicle_types;

-- Query 3 Get the number of accidents for each severity level

SELECT Accident_severity,COUNT(*) as Number_of_accidents from accident
group by Accident_severity;

-- Query4 Get the number of accidents on each day of the week

SELECT Day_of_Week,COUNT(*) as Number_of_accidents from accident
group by Day_of_Week
order by Day_of_Week;

-- Query5 Get the number of accidents that occured in rural area

SELECT COUNT(*) as Number_of_accidents from accident
where Urban_or_Rural_Area=1;

-- Query6 Get the number of accidents where skidding and overturning (0,1)

SELECT COUNT(*) as Number_of_accidents from vehicles
where Skidding_and_Overturning =0;

-- Query7 Find the total number of accidents where a police officer attended the scene(1-yes,2-No)

SELECT count(*) as total_number from accident where Did_Police_Officer_Attend_Scene_of_Accident =2;

-- Query8 find the total number of casualities for each weather condition(Bad to Good 1 to 9)

SELECT Weather_Conditions,sum(Number_of_Casualties) as Number_of_Casualties from accident
group by Weather_Conditions
order by Weather_Conditions;

-- Query9 Find the vehicle type with the highest number of accidents
SELECT vt.vehicle_type, 
COUNT(v.Accident_Index) AS accident_count
FROM vehicles v
Join vehicle_types vt 
ON v.Vehicle_Type = vt.vehicle_code
GROUP BY vt.vehicle_type
ORDER BY accident_count DESC;

-- Query10 Find the average number of casualties per accident for each road type

SELECT Road_Type,sum(Number_of_casualties) as Number_of_casualties from accident
group by Road_Type
order by Road_Type;

-- Query11 Get the number of accident during different time of the day(morning,afternoon)
SELECT 
    CASE 
        WHEN Time BETWEEN '00:00' AND '06:00' THEN 'Night'
        WHEN Time BETWEEN '06:01' AND '12:00' THEN 'Morning'
        WHEN Time BETWEEN '12:01' AND '18:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS Time_of_Day,
    COUNT(*) AS Number_of_Accidents
FROM accident
GROUP BY Time_of_Day;