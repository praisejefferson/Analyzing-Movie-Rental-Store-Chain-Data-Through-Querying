USE SAKILA;


#1
SELECT TITLE, RATING, LENGTH
FROM FILM
WHERE RATING = 'PG'
AND LENGTH > '50';


#2
SELECT SUM(AMOUNT) AS TOTAL
FROM PAYMENT
WHERE PAYMENT_DATE >= '2006-01-01';


#3
SELECT * FROM ACTOR
WHERE LAST_NAME = 'HOPKINS';


#4
SELECT LAST_NAME, COUNT(LAST_NAME)
FROM ACTOR
GROUP BY LAST_NAME
HAVING COUNT(LAST_NAME) = 1;


#5
SELECT COUNT(DISTINCT LAST_NAME)
FROM ACTOR; 


#6
SELECT A.ACTOR_ID, 
A.FIRST_NAME, 
A.LAST_NAME, 
COUNT(F.ACTOR_ID) 
AS COUNT_ACTOR_ID
FROM FILM_ACTOR F
JOIN ACTOR A
ON F.ACTOR_ID = A.ACTOR_ID
GROUP BY A.ACTOR_ID, A.FIRST_NAME, A.LAST_NAME
ORDER BY COUNT_ACTOR_ID DESC
LIMIT 1; 


#7
SELECT R.RETURN_DATE
FROM FILM F
JOIN INVENTORY I
ON F.FILM_ID = I.FILM_ID
JOIN RENTAL R 
ON I.INVENTORY_ID = R.INVENTORY_ID
WHERE F.TITLE = 'Academy Dinosaur'
ORDER BY R.RETURN_DATE ASC
LIMIT 1;


#8
SELECT ROUND(AVG(LENGTH)) AS AVERAGE_LENGTH
FROM FILM; 


#9
SELECT D.NAME, ROUND(AVG(LENGTH)) AS AVERAGE_LENGTH
FROM FILM F
JOIN FILM_CATEGORY C 
ON C.FILM_ID = F.FILM_ID
JOIN CATEGORY D 
ON D.CATEGORY_ID = C.CATEGORY_ID
GROUP BY D.NAME;


#10
-- This query attempts to perform a "natural join" between the film and inventory tables. 
-- Possible reasons for an empty result set:
-- No Common Columns: The film and inventory tables might not have any columns with the same name. 
-- No Matching Data: Even if they have columns with the same name, there might be no matching data between the two tables.
-- Data Mismatch: There could be data type mismatches or formatting differences in the columns with the same name.


#11
SELECT SUM(AMOUNT) AS TOTAL_REVENUE
FROM PAYMENT; 


#12
SELECT DISTINCT C.LAST_NAME, C.FIRST_NAME
FROM CUSTOMER C
JOIN RENTAL R 
ON C.CUSTOMER_ID = R.CUSTOMER_ID
JOIN PAYMENT P 
ON R.RENTAL_ID = P.RENTAL_ID
JOIN INVENTORY I 
ON R.INVENTORY_ID = I.INVENTORY_ID
JOIN FILM_CATEGORY FC 
ON I.FILM_ID = FC.FILM_ID
JOIN CATEGORY CAT 
ON FC.CATEGORY_ID = CAT.CATEGORY_ID
WHERE CAT.NAME = 'Sci-Fi'
GROUP BY C.LAST_NAME, C.FIRST_NAME
HAVING COUNT(R.RENTAL_ID) > 2
ORDER BY C.LAST_NAME, C.FIRST_NAME; 


#13
SELECT C.CITY, SUM(P.AMOUNT) AS TOTAL_REVENUE
FROM CITY C
JOIN ADDRESS A 
ON C.CITY_ID = A.CITY_ID
JOIN CUSTOMER CU 
ON A.ADDRESS_ID = CU.ADDRESS_ID
JOIN PAYMENT P 
ON CU.CUSTOMER_ID = P.CUSTOMER_ID
GROUP BY C.CITY
ORDER BY TOTAL_REVENUE DESC
LIMIT 1; 


#14
SELECT CONCAT(A.FIRST_NAME, ' ', A.LAST_NAME) 
AS Actor_Name
FROM ACTOR A
WHERE A.FIRST_NAME = (
SELECT FIRST_NAME 
FROM ACTOR WHERE ACTOR_ID = 8)
AND A.ACTOR_ID <> 8
UNION
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) 
AS Customer_Name
FROM CUSTOMER C
WHERE C.FIRST_NAME = (SELECT FIRST_NAME 
FROM ACTOR
WHERE ACTOR_ID = 8); 


#15
SELECT COUNT(*) AS CategoryCount
FROM (
    SELECT FC.CATEGORY_ID, 
    AVG(F.REPLACEMENT_COST - F.RENTAL_RATE) 
    AS AvgDifference
    FROM FILM F
    JOIN FILM_CATEGORY FC 
    ON F.FILM_ID = FC.FILM_ID
    GROUP BY FC.CATEGORY_ID
    HAVING AvgDifference > 17
) AS CategoriesWithLargeAvgDifference;


