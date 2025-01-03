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

