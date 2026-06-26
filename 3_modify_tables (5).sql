/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM 'C:\Users\ushab\sql\company_dim (2).csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Users\ushab\sql\skills_dim (1).csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Users\ushab\sql\job_postings_fact (2).csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Users\ushab\sql\skills_job_dim (2).csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- NOTE: This has been updated from the video to fix issues with encoding

COPY company_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


SELECT * FROM job_postings_fact
where extract(month from job_posted_date)= 1
limit 10

create table january_job as 
SELECT * from job_postings_fact
where extract(month from job_posted_date) = 1

SELECT 
count(job_id) as numbers_of_job,
CASE
when job_location = 'Anywhere' then 'Remote'
when job_location = 'New York, NY' then 'local'
else 'onsite'
end as job_category
From job_postings_fact
where job_title_short = 'Data Analyst'
group by job_category

SELECT *
FROM (
    SELECT * from job_postings_fact
    where extract(month from job_posted_date) = 2
    AND job_title_short = 'Data Analyst'
) as feb_jobs

SELECT company_id, job_no_degree_mention
From job_postings_fact
where job_no_degree_mention = true

SELECT company_id ,Count(*)
from job_postings_fact
GROUP BY company_id

SELECT name From company_dim

SELECT job_id,skill_id
FROM skills_job_dim as skills_to_job