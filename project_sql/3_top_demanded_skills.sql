/* 
Question: What are the most in demand skills for data analyst?
- Join job posting to inner join table similar to query 2
- Identify the top 5 in demand skills
- Focus on all job postings
Why? Retreving the top 5 skills in demand for data analyst in market provide insights into most valuable skills for job seeker
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5