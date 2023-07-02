-- Rename value for better Understanding

--Rename Experience Level
SELECT DISTINCT(experience_level)
FROM ds_salaries

SELECT experience_level, 
CASE WHEN experience_level = 'SE' THEN 'Senior Level'
	 WHEN experience_level = 'EN' THEN 'Entry Level'
	 WHEN experience_level = 'MI' THEN 'Mid/Intermediate Level'
	 WHEN experience_level = 'EX' THEN 'Excecutive Level'
	 ELSE experience_level
	 END
FROM ds_salaries

UPDATE ds_salaries
SET experience_level = CASE WHEN experience_level = 'SE' THEN 'Senior Level'
	 WHEN experience_level = 'EN' THEN 'Entry Level'
	 WHEN experience_level = 'MI' THEN 'Mid/Intermediate Level'
	 WHEN experience_level = 'EX' THEN 'Excecutive Level'
	 ELSE experience_level
	 END

--Rename Employment Type

SELECT DISTINCT(employment_type)
FROM ds_salaries

SELECT employment_type, 
CASE WHEN employment_type = 'CT' THEN 'Contractor'
	 WHEN employment_type = 'FL' THEN 'Freelance'
	 WHEN employment_type = 'PT' THEN 'Part-time'
	 WHEN employment_type = 'FT' THEN 'Full-time'
	 ELSE employment_type
	 END
FROM ds_salaries

UPDATE ds_salaries
SET employment_type = CASE WHEN employment_type = 'CT' THEN 'Contractor'
	 WHEN employment_type = 'FL' THEN 'Freelance'
	 WHEN employment_type = 'PT' THEN 'Part-time'
	 WHEN employment_type = 'FT' THEN 'Full-time'
	 ELSE employment_type
	 END
FROM ds_salaries

SELECT DISTINCT(company_size)
FROM ds_salaries

SELECT company_size, 
	CASE WHEN company_size = 'S' THEN 'Small'
		 WHEN company_size = 'M' THEN 'Medium'
		 WHEN company_size = 'L' THEN 'Large'
		 ELSE company_size
		 END
FROM ds_salaries

UPDATE ds_salaries
SET company_size = 	CASE WHEN company_size = 'S' THEN 'Small'
		 WHEN company_size = 'M' THEN 'Medium'
		 WHEN company_size = 'L' THEN 'Large'
		 ELSE company_size
		 END



-- GROUPING JOB TITLE

SELECT DISTINCT(job_title)
FROM ds_salaries

SELECT job_title, 
CASE WHEN job_title = 'Data Engineer' 
			OR job_title = 'Data Analyst'
			OR job_title = 'Analytics Engineer'
			OR job_title = 'BI Data Analyst'
			OR job_title = 'Business Data Analyst'
			OR job_title = 'BI Developer'
			OR job_title = 'BI Analyst'
			OR job_title = 'Business Intelligence Engineer'
			OR job_title = 'BI Data Engineer'
			OR job_title = 'Power BI Developer' THEN 'Data Engineer'
ELSE job_title END
FROM ds_salaries

SELECT job_title, 
	CASE WHEN job_title IN ('Data Engineer' , 'Data Analyst','Analytics Engineer','BI Data Analyst','Business Data Analyst','BI Developer','BI Analyst','Business Intelligence Engineer','BI Data Engineer','Power BI Developer') THEN 'Data Engineering'
		 WHEN job_title IN ('Data Scientist', 'Applied Scientist', 'Research Scientist', '3D Computer Vision Researcher', 'Deep Learning Researcher', 'AI/Computer Vision Engineer') THEN 'Data Scientist'
		 WHEN job_title IN ('Machine Learning Engineer', 'ML Engineer', 'Lead Machine Learning Engineer', 'Principal Machine Learning Engineer') THEN 'Machine Learning'
		 WHEN job_title IN ('Data Architect', 'Big Data Architect', 'Cloud Data Architect', 'Principal Data Architect') THEN 'Data Architecture'
		 WHEN job_title IN ('Data Science Manager', 'Director of Data Science', 'Head of Data Science', 'Data Scientist Lead', 'Head of Machine Learning', 'Manager Data Management', 'Data Analytics Manager') THEN 'Management'
	ELSE 'Other' END AS Group_Job_Title
FROM ds_salaries

ALTER TABLE ds_salaries
ADD Group_Job_Title Nvarchar (255);

UPDATE ds_salaries
SET Group_Job_Title = 	CASE WHEN job_title IN ('Data Engineer' , 'Data Analyst','Analytics Engineer','BI Data Analyst','Business Data Analyst','BI Developer','BI Analyst','Business Intelligence Engineer','BI Data Engineer','Power BI Developer') THEN 'Data Engineering'
		 WHEN job_title IN ('Data Scientist', 'Applied Scientist', 'Research Scientist', '3D Computer Vision Researcher', 'Deep Learning Researcher', 'AI/Computer Vision Engineer') THEN 'Data Scientist'
		 WHEN job_title IN ('Machine Learning Engineer', 'ML Engineer', 'Lead Machine Learning Engineer', 'Principal Machine Learning Engineer') THEN 'Machine Learning'
		 WHEN job_title IN ('Data Architect', 'Big Data Architect', 'Cloud Data Architect', 'Principal Data Architect') THEN 'Data Architecture'
		 WHEN job_title IN ('Data Science Manager', 'Director of Data Science', 'Head of Data Science', 'Data Scientist Lead', 'Head of Machine Learning', 'Manager Data Management', 'Data Analytics Manager') THEN 'Management'
	ELSE 'Other' END

SELECT DISTINCT(Group_job_title), COUNT(Group_job_title)
FROM ds_salaries
GROUP BY Group_job_title