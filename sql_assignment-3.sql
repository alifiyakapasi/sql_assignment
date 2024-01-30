select * from employee1
select * from dept


-- 1. write a SQL query to find Employees who have the biggest salary in their Department
SELECT dept_id, MAX(salary) as Highest_Salary
FROM employee1 e
GROUP BY dept_id

select dept.dept_name, e.emp_name, max(salary) as total_salary
from employee1 e
join dept
on dept.dept_id=e.dept_id
group by dept.dept_name, e.emp_name;


-- 2. write a SQL query to find Departments that have less than 3 people in it
Select e.dept_id, d.dept_name,  count(*) as employee_no From employee1 e 
JOIN dept d ON e.dept_id=d.dept_id 
GROUP BY e.dept_id, d.dept_name 
HAVING COUNT(*) < 3;


-- 3. write a SQL query to find All Department along with the number of people there
select dept_id, count(*) as total_employee
from employee1
group by dept_id;

select dept.dept_name, dept.dept_id, count(*) as total_employee
from employee1 e
join dept
on dept.dept_id=e.dept_id
group by dept.dept_name, dept.dept_id;


-- 4. write a SQL query to find All Department along with the total salary there
SELECT dept_id, SUM(salary) as total_salary
FROM employee1 
GROUP BY dept_id;


select dept.dept_name, dept.dept_id, sum(salary) as total_salary
from employee1
join dept
on dept.dept_id=employee1.dept_id
group by dept.dept_name, dept.dept_id;