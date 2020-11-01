/* Question
Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

The column id is continuous increment.
 

Mary wants to change seats for the adjacent students.
 

Can you write a SQL query to output the result for Mary?
 

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
For the sample input, the output is:
 

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
Note:
If the number of students is odd, there is no need to change the last one's seat. */

------------------------------------------------------------------------------------------------------------

## Solution(Oracle)

WITH data AS 
(Select 
    id,
    student,
    lead(student,1) over (order by id) as student_lead,lag(student,1) over (order by id) as student_lag 
from seat),
data1 AS 
(Select 
    id,
    student,
    case when MOD(id, 2) = 0 then student_lag when MOD(id, 2) != 0 then student_lead end as value 
 from data)
select 
    id,
    case when value is not null then value when value is null then student end as student 
from data1;

