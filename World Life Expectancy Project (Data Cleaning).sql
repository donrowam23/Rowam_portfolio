#World Life Expectancy Project (Data Cleaning)

SELECT * 
FROM world_lifee_xpectancy
;

SELECT Country, Year, CONCAT(Country, Year),COUNT(CONCAT(Country, Year))
FROM world_lifee_xpectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

SELECT *
FROM (
SELECT Row_ID, 
CONCAT(Country, Year),
ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
FROM world_lifee_xpectancy
) AS Row_table
WHERE Row_Num > 1
;

DELETE FROM world_lifee_xpectancy
WHERE
	Row_ID IN (
SELECT Row_ID 
    FROM (
SELECT Row_ID, 
CONCAT(Country, Year),
ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
FROM world_lifee_xpectancy
) AS Row_table
WHERE Row_Num > 1
)
;
    

SELECT * 
FROM world_lifee_xpectancy
WHERE Status IS NULL
;

SELECT DISTINCT(Status)
FROM world_lifee_xpectancy
WHERE Status <> ''
;


SELECT DISTINCT(Country)
FROM world_lifee_xpectancy
WHERE Status = 'Developing';

UPDATE world_lifee_xpectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
		FROM world_lifee_xpectancy
		WHERE Status = 'Developing');
        
    UPDATE  world_lifee_xpectancy t1
    JOIN world_lifee_xpectancy t2
		ON t1.Country = t2.Country
	SET t1.Status = 'Developing'
    WHERE t1.Status = ''
    AND t2.Status <> ''
    AND t2.Status = 'Developing'
;
    
    
SELECT *
FROM world_lifee_xpectancy
WHERE Country =   'United States of America'
;

UPDATE world_lifee_xpectancy t1
JOIN world_lifee_xpectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
    WHERE t1.Status = ''
    AND t2.Status <> ''
    AND t2.Status = 'Developed'    
    ;
    
    
   SELECT * 
FROM world_lifee_xpectancy
#WHERE Status IS NULL
;


SELECT * 
FROM world_lifee_xpectancy 
WHERE 'Life expectancy' = ''
;
    
        
SELECT t1.Country, t1.Year, t1.`Life expectancy`,t2.Country, t2.Year, t2.`Life expectancy`
FROM world_lifee_xpectancy t1
JOIN world_lifee_xpectancy t2
	ON t1.Country = t2.Country 
    AND t1.Year = t2.Year - 1
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy`+ t3.`Life expectancy`)/2,1)
FROM world_lifee_xpectancy t1
JOIN world_lifee_xpectancy t2
	ON t1.Country = t2.Country 
    AND t1.Year = t2.Year - 1
JOIN world_lifee_xpectancy t3
	ON t1.Country = t3.Country 
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;


UPDATE world_lifee_xpectancy t1
JOIN world_lifee_xpectancy t2
	ON t1.Country = t2.Country 
    AND t1.Year = t2.Year - 1
JOIN world_lifee_xpectancy t3
	ON t1.Country = t3.Country 
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy`+ t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;


SELECT *
FROM world_lifee_xpectancy
#WHERE `Life expectancy` = ''
;