--DB UNIVERSITY - QUERIES  


-- SELECT

-- 1. Select all students born in 1990 (160)
SELECT * 
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990;


-- 2. Select all courses worth more than 10 credits (479)
SELECT * 
FROM `courses`
WHERE `cfu` > 10;


-- 3. Select all students over 30 years old
SELECT *
FROM `students`
WHERE DATEDIFF(CURDATE(), `date_of_birth`) > 30;


-- 4. Select all courses from the first semester of the first year of any degree program (286)
SELECT * 
FROM `courses` 
WHERE `year` = 1 
AND `period` = 'I semestre';


-- 5. Select all exam sessions that take place in the afternoon (after 2 PM) on 20th June 2020 (21)
SELECT * 
FROM `exams` 
WHERE `date` = '2020-06-20' 
AND HOUR(`hour`) >= '14:00:00';


-- 6. Select all master's degree courses (38)
SELECT * 
FROM `degrees` 
WHERE `level` LIKE 'magistrale%';


-- 7. How many departments does the university have? (12)
SELECT COUNT(*) AS `total_departments` 
FROM `departments`; 



-- 8. How many teachers do not have a phone number? (50)
SELECT * 
FROM `teachers` 
WHERE `phone` IS NULL;





-- GROUP BY

-- 9. Count how many enrolled students there have been each year.
SELECT COUNT(*) as `total_enrollments`, 
YEAR(`enrolment_date`) as `year` 
FROM `students` 
GROUP BY `year`;



-- 10. Count the teachers who have their office in the same building.
SELECT COUNT(*) as `teachers`, `office_address` 
FROM `teachers` 
GROUP BY `office_address`;



-- 11. Calculate the average grade for each exam session.
SELECT `exam_id` as `exam_session` , ROUND(AVG(`vote`)) AS `average` 
FROM `exam_student` 
GROUP BY `exam_session`;


-- 12. Count how many degree programs are there for each department.
SELECT COUNT(*) AS `degree_courses`, `department_id` AS `department` 
FROM `degrees` 
GROUP BY `department_id`;


