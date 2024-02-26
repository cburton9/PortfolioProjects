# World Life Expectancy Project ( Data Cleaning )

SELECT * 
FROM world_life_expectancy
;



# Identifying any duplicates in the data using a CONCAT on Country and Year to create our own unique column
SELECT  Country, Year, CONCAT(Country, year ), COUNT(CONCAT(Country, year ))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, year )
HAVING COUNT(CONCAT(Country, year )) > 1
;

# Identifying the row_ID that these duplicates belong to, Using ROW_Number and and an Partition By
SELECT *
FROM ( 
	SELECT ROW_ID, 
	CONCAT(Country, year ),
	ROW_NUMBER() OVER ( PARTITION BY CONCAT(Country, year ) ORDER BY  CONCAT(Country, year )) as Row_num
	FROM world_life_expectancy
    ) AS row_table
WHERE row_num > 1
;

# Deleting the duplicates using the query above that 
DELETE FROM world_life_expectancy
WHERE
	Row_ID IN (
	SELECT Row_ID
FROM ( 
	SELECT ROW_ID, 
	CONCAT(Country, year ),
	ROW_NUMBER() OVER ( PARTITION BY CONCAT(Country, year ) ORDER BY  CONCAT(Country, year )) as Row_num
	FROM world_life_expectancy
    ) AS row_table
WHERE row_num > 1
)
;

#Identify missing data in the Status column
SELECT * 
FROM world_life_expectancy
WHERE Status = ''
;

# Checking to see if each country had something that was populated
SELECT  DISTINCT (Status) 
FROM world_life_expectancy
WHERE Status <> ''
;

#Identify which countrys status is "Developing" Vs "Developed"
SELECT DISTINCT( Country)
FROM world_life_expectancy
WHERE Status = 'Developing';


# Updating the table where countries' status that are blank to equal the countries that are already populate with the phrase "Developing"
UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country  IN (SELECT  DISTINCT (Status) 
								FROM world_life_expectancy
								WHERE Status = 'Developing');


# Made a work around to do the same purpose the query above was suppose to do
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.Status = 'Developing'
WHERE  t1.Status =''
AND  t2.Status <> ''
AND  t2.Status = 'Developing'
;

# Identifying what status the U.S.A was
SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America';



#Now updating the U.S.A Status to "developed" using the same query for "developing"
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.Status = 'Developed'
WHERE  t1.Status =''
AND  t2.Status <> ''
AND  t2.Status = 'Developed'
;

# Idenfitying the Blanks in the column " Life expectancy"
SELECT * 
FROM world_life_expectancy
#WHERE `Life expectancy` = ''
;

# Taking the AVG of the Next year and previous year to populate the blank columns
SELECT t1.Country, t1.Year, t1.`Life expectancy` ,
t2.Country, t2.Year, t2.`Life expectancy` ,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/ 2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy   t2
	ON t1.Country = t2.Country
	AND t1.Year = t2.Year-1
JOIN world_life_expectancy   t3
	ON t1.Country = t3.Country
	AND t1.Year = t3.Year+ 1 
WHERE t1.`Life expectancy` = ''
;

# Updating the blanks in the "Life expectancy" to be populate with the AVG amount using part of the query above
UPDATE world_life_expectancy t1
JOIN world_life_expectancy   t2
	ON t1.Country = t2.Country
	AND t1.Year = t2.Year-1
JOIN world_life_expectancy   t3
	ON t1.Country = t3.Country
	AND t1.Year = t3.Year+ 1 
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/ 2,1)
WHERE t1.`Life expectancy`=''
;


SELECT *
FROM world_life_expectancy
#WHERE `Life expectancy` = ''
