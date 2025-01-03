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
