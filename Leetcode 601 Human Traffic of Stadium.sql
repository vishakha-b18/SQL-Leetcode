/* Question
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the primary key for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
No two rows will have the same visit_date, and as the id increases, the dates increase as well.
 

Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.

The query result format is in the following example.

 

Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+

Result table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
The rows with ids 2 and 3 are not included because we need at least three consecutive ids. */

------------------------------------------------------------------------------------------------------------

## Solution(Oracle)

WITH data AS 
(SELECT  
	id, 
	visit_date, 
    people 
from stadium 
where people>= 100),
data1 AS 
(SELECT 
	id, 
	visit_date, 
	people, 
	case when lead(id,1) over (order by id) = (id+1) and lead(id,2) over (order by id) = (id+2) then 1 else 0 end as checker,
	case when lag(id,1) over (order by id) = (id-1) and lag(id,2) over (order by id) = (id-2) then 1 else 0 end as checker1,
	case when lead(id,1) over (order by id) = (id+1) and lag(id,1) over (order by id) = (id-1) then 1 else 0 end as checker2 
from data),
data2 AS
(SELECT 
	id,
    visit_date, 
    people, 
	case when checker = 1 or checker1 = 1 or checker2 = 1 then 1 else 0 end as flag 
from data1)
Select 
	id,
    to_char(visit_date,'YYYY-MM-DD') as visit_date, 
    people 
from data2 
where flag = 1;