# World Life Expectancy Project ( Exploratory Data Analysis )

SELECT * 
FROM world_life_expectancy
;

# Each Countries Highest and Lowest Life Expectancy, and increased over 15 years
# Noticed there was zeros in the function filter the data to remove the zeros 
SELECT country, 
MAX(`Life expectancy`) AS Highest_Life_Expectancy , 
MIN(`Life expectancy` ) AS Lowest_Life_Expectancy,
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy` ) , 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy` )  <> 0
AND MAX(`Life expectancy`)  <> 0
ORDER BY Life_Increase_15_Years ASC
;

# Taking the average life expectancy for all countries each year 
SELECT Year,  ROUND(AVG(`Life expectancy`),1) AS AVERAGE_Life_Expectancy
FROM world_life_expectancy
WHERE `Life expectancy`   <> 0
AND `Life expectancy`  <> 0
GROUP BY year 
ORDER BY year DESC
;

#Taking the correlation on the GDP vs life expectancy
SELECT Country,  
ROUND(AVG(`Life expectancy`),1) AS Life_Expectancy ,
ROUND( AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expectancy > 0 
AND GDP > 0
ORDER BY GDP DESC
;

SELECT 
SUM(CASE WHEN 	 GDP >=1500 THEN  1 ELSE 0 END) High_GDP_Count,
ROUND(AVG(CASE WHEN 	 GDP >=1500 THEN  `Life expectancy` ELSE NULL END),1)High_GDP_Life_expectancy,
SUM(CASE WHEN 	 GDP <=1500 THEN  1 ELSE 0 END) Low_GDP_Count,
ROUND(AVG(CASE WHEN 	 GDP <=1500 THEN  `Life expectancy` ELSE NULL END),1)Low_GDP_Life_expectancy
FROM world_life_expectancy
;


# What is the Status on Developed Vs Developing, depending on their life expectancy
SELECT 
Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

# How many countries are developing, How many countries have developing 
SELECT 
Status, 
ROUND(AVG(`Life expectancy`),1),
COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;

#Each Countries BMI Vs Life Expectancy

SELECT Country,  
ROUND(AVG(`Life expectancy`),1) AS Life_Expectancy ,
ROUND( AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expectancy > 0 
AND BMI > 0
ORDER BY BMI DESC
;

# Using a Rolling Total to compare the correlation between Adult Mortality and Life expectancy

SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER (PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;

