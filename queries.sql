--DB UNIVERSITY - QUERIES  


----------------------------------- SELECT ------------------------------------------


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
WHERE TIMESTAMPDIFF(Year, `date_of_birth`, curdate()) > 30;


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
WHERE `level` = 'magistrale';


-- 7. How many departments does the university have? (12)
SELECT COUNT(*) AS `total_departments` 
FROM `departments`; 



-- 8. How many teachers do not have a phone number? (50)
SELECT COUNT(*) AS `number_teachers`
FROM `teachers` 
WHERE `phone` IS NULL;




---------------------------------- GROUP BY-----------------------------------------

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




----------------------------------- JOIN ------------------------------------------

--13 Select all students enrolled in the Economics degree course.
SELECT S.`name`AS 'name_student', S.`surname` AS 'surname_student'
FROM `students`AS S
JOIN `degrees` AS D ON  S.`degree_id` = D.`id`
WHERE D.`name`= 'Corso di Laurea in Economia';


--14 Select all degree courses in the department of Neuroscience.
SELECT DEP.`name` as `department`, DEG.`name` as `degree_course`      
FROM `degrees` AS DEG
JOIN `departments`AS DEP ON DEG.`department_id`= DEP.`id`
WHERE DEP.`name` = 'Dipartimento di Neuroscienze';


--15 Select all courses where Fulvio Amato teaches (id=44)
SELECT T.`id`, T.`name`, T.`surname`, C.`name`AS 'course'
FROM `courses` AS C
JOIN `course_teacher` AS CT ON CT.`course_id` = C.`id`
JOIN `teachers` AS T ON CT.`teacher_id` = T.`id`
WHERE T.`name`= 'Fulvio'
AND T.`surname`= 'Amato';


--16 Select all students with data on the degree course in which they are enrolled and the relevant department, in alphabetical order by surname and first name.
SELECT S.`surname`, S.`name`, DEP.`name` as `department`, DEG.`name` AS `degree_course`
FROM `students` AS S
JOIN `degrees`AS DEG ON S.`degree_id`= DEG.`id`
JOIN `departments` AS DEP ON DEG.`department_id` = DEP.`id`
ORDER BY S.`surname`, S.`name`;


--17 Select all degree courses with their respective courses and teachers.
SELECT D.`name`AS 'degree_course', C.`name`AS 'course', T.`name`AS 'name_teacher', T.`surname` AS 'surname_teacher'
FROM `degrees` AS D
JOIN `courses`AS C ON C.`degree_id` = D.`id`
JOIN `course_teacher` AS CT ON CT.`course_id` = C.`id`
JOIN `teachers` AS T on T.`id` = CT.`teacher_id`
ORDER BY D.`name`;
