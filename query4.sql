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
