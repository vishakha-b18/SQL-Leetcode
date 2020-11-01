/* Question
Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
 */

------------------------------------------------------------------------------------------------------------

## Solution(Oracle)

select 
	distinct(t.ConsecutiveNums) 
from 
	(select 
		case when LEAD(l.num, 1, 0)  over (order by l.id) = l.num 
			and LAG(l.num, 1, 0)  over (order by l.id) = l.num then l.num end as ConsecutiveNums 
	from Logs l) t 
    where t.ConsecutiveNums is not null;