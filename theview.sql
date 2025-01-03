CREATE VIEW lessons_per_month AS
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

CREATE VIEW student_sibling_counts AS
WITH sibling_counts AS ( 
 -- for a specific student, count how many siblings to this student there are.
 -- -1 to not inlcude the specific student
SELECT sibgroup.student_id, COUNT(sibgroup2.student_id) - 1 AS sibling_count 
	FROM sibling_group sibgroup

	-- join to match rows where students with the same group number exists.
    JOIN sibling_group sibgroup2 ON sibgroup.group_number = sibgroup2.group_number
    GROUP BY sibgroup.student_id 
	),

-- find all students with no siblings and will then sets the count as 0.
students_no_siblings AS (SELECT nosibling.id AS student_id, 0 AS sibling_count 
    FROM student nosibling 
	-- checks if the student exists in the sibling_group table.
	WHERE NOT EXISTS (
    SELECT 1 FROM sibling_group sibgroup WHERE sibgroup.student_id = nosibling.id
	)),

-- combine the students with siblings with the students without siblings.
total_students_and_siblings AS (SELECT * FROM sibling_counts UNION ALL SELECT * FROM students_no_siblings
),

 -- table with sibling counts 0,1 and 2 to show in output.
total_sibling_counts AS (
    SELECT 0 AS sibling_count UNION ALL SELECT 1 UNION ALL SELECT 2)

 -- for each sibling count, it will count how many students have that count.
SELECT numofsib.sibling_count AS "No of Siblings", 
	COUNT(numofstud.student_id) AS "No of Students" 
	FROM total_sibling_counts numofsib
	LEFT JOIN total_students_and_siblings numofstud ON numofsib.sibling_count = numofstud.sibling_count 

GROUP BY numofsib.sibling_count
ORDER BY numofsib.sibling_count;


CREATE VIEW lessons_per_instructor AS 
WITH lessons_per_instructor AS (
-- finds the lessons that are under the current month and count them
 SELECT lessons.instructor_id, COUNT(*) AS total_lessons
    FROM lesson lessons
    WHERE (appointment_time IS NOT NULL OR scheduled_time IS NOT NULL)
      AND DATE_PART('year', 
      CASE WHEN appointment_time IS NOT NULL THEN appointment_time ELSE scheduled_time END) = DATE_PART('year', CURRENT_DATE)
      AND DATE_PART('month', 
      CASE WHEN appointment_time IS NOT NULL THEN appointment_time ELSE scheduled_time END) = DATE_PART('month', CURRENT_DATE)
	  
    GROUP BY lessons.instructor_id)
	-- creates copied tables, columns with the titles that are needed.
SELECT 
    instruct.id AS "Instructor Id",
    instruct.first_name AS "First Name",
    instruct.last_name AS "Last Name",
    perinstructor.total_lessons AS "No of Lessons"
FROM lessons_per_instructor perinstructor
-- join the tables to remove instructors with 2 or less lessons
JOIN instructor instruct
    ON perinstructor.instructor_id = instruct.id
WHERE perinstructor.total_lessons > 2

ORDER BY perinstructor.total_lessons DESC;

CREATE VIEW ensemble_available_seats AS
WITH ensemble_available AS (
    SELECT
        lessons.id AS lesson_id,
        lessons.scheduled_time::DATE AS day,
        lessons.genre,
        lessons.maximum_of_students,
	-- counts the number of booked seats and then calculates how many seats are left
        COUNT(bookedseats.id) AS booked_seats, (lessons.maximum_of_students - COUNT(bookedseats.id)) AS free_seats
    FROM lesson lessons
	-- join booking and lesson table to find matching lesson id on only ensembles for the count
    LEFT JOIN booking bookedseats ON lessons.id = bookedseats.lesson_id
    WHERE lessons.lesson_type = 'ENSEMBLE'
	-- choosing dates manually
        AND lessons.scheduled_time::DATE >= '2025-01-06'
         AND lessons.scheduled_time::DATE <= '2025-01-12'
		
    GROUP BY lessons.id, lessons.scheduled_time::DATE, lessons.genre, lessons.maximum_of_students)
	
SELECT
-- determine what free_seats is
    day AS "Day", genre AS "Genre",
   CASE WHEN free_seats BETWEEN 1 AND 2 THEN '1 or 2 Seats'
   		WHEN free_seats <= 0 THEN 'No Seats'
        ELSE 'Many Seats'
    	END AS "No of Free Seats"
FROM ensemble_available
WHERE genre IS NOT NULL

ORDER BY day, genre;

