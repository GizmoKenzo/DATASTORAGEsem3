SELECT 
	-- extracting year and month.
    DATE_PART('year', 
	CASE WHEN appointment_time IS NOT NULL THEN appointment_time ELSE scheduled_time END
    ) AS year,                             
	
    DATE_PART('month', 
        CASE WHEN appointment_time IS NOT NULL THEN appointment_time ELSE scheduled_time END
    ) AS month,
	-- Counting total lessons in every type of lesson where there is a timestamp.
	COUNT(*) AS total_lessons,            
    SUM(CASE WHEN lesson_type = 'INDIVIDUAL' THEN 1 ELSE 0 END) AS individual, 
    SUM(CASE WHEN lesson_type = 'GROUP' THEN 1 ELSE 0 END) AS group,          
    SUM(CASE WHEN lesson_type = 'ENSEMBLE' THEN 1 ELSE 0 END) AS ensemble      
FROM lesson
WHERE appointment_time IS NOT NULL OR scheduled_time IS NOT NULL 

	--Group the results of the sums by year and month.
GROUP BY 
    DATE_PART('year', 
        CASE WHEN appointment_time IS NOT NULL THEN appointment_time ELSE scheduled_time END),
    DATE_PART('month', 
        CASE WHEN appointment_time IS NOT NULL THEN appointment_time ELSE scheduled_time END)
ORDER BY year, month;                     
