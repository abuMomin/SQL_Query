1. how to use UNION on queries where LIMITs need to be used (in every
   queries). : [Hacker Rank Problem](https://www.hackerrank.com/challenges/weather-observation-station-5/problem?isFullScreen=true)

```sql
SELECT *
FROM ((SELECT CONCAT(CITY, ' ', CHAR_LENGTH(CITY))
       FROM STATION
       WHERE CHAR_LENGTH(CITY) =
             (SELECT MAX(CHAR_LENGTH(CITY)) from STATION)
       ORDER BY CITY LIMIT 1)
      UNION
      (SELECT CONCAT(CITY, ' ', CHAR_LENGTH(CITY))
       FROM STATION+
       WHERE CHAR_LENGTH(CITY) =
             (SELECT MIN(CHAR_LENGTH(CITY)) from STATION)
       ORDER BY CITY LIMIT 1)) AS CITY
```

2. How to capitalize the first letter of a String (Show all the name of Student and the First letter of the name has to be Capital).

```sql
SELECT CONCAT(UPPER(LEFT (student.name, 1)), RIGHT(student.name, (CHAR_LENGTH(student.name) - 1))) AS 'Name' FROM student;
```

```sql
SELECT CONCAT(UPPER(LEFT (name, 1)), LOWER(SUBSTRING(name, 2))) AS formatted_name FROM student;
```

3. 