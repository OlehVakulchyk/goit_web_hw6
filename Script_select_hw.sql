-- 1. Знайти 5 студентів із найбільшим середнім балом з усіх предметів.

SELECT s.fullname, ROUND(AVG(g.grade), 2) as avg_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
GROUP BY s.id 
ORDER BY avg_grade DESC
LIMIT 5;

-- 2. Знайти студента із найвищим середнім балом з певного предмета.

SELECT d.name, s.fullname, ROUND(AVG(g.grade), 2) as avg_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN disciplines d ON d.id = g.discipline_id 
WHERE d.id = 5
GROUP BY s.id
ORDER BY avg_grade DESC
LIMIT 1;

-- 3. Знайти середній бал у групах з певного предмета.

SELECT gr.name, d.name, ROUND(AVG(g.grade), 2) as avg_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN disciplines d ON d.id = g.discipline_id
LEFT JOIN [groups] gr ON gr.id = s.group_id 
WHERE d.id = 1
GROUP BY gr.id
ORDER BY avg_grade DESC;

-- 4. Знайти середній бал на потоці (по всій таблиці оцінок).

SELECT ROUND(AVG(g.grade), 2) as avg_grade, COUNT(grade) as count_grade
FROM grades g

-- 5. Знайти які курси читає певний викладач.

SELECT t.fullname as name, d.name as discipline
FROM teachers t
LEFT JOIN disciplines d ON d.teacher_id = t.id
WHERE t.id = 1

-- 6. Знайти список студентів у певній групі.

SELECT s.fullname as name
FROM students s
LEFT JOIN groups gr ON gr.id = s.group_id
WHERE gr.id = 1
ORDER BY name

-- 7. Знайти оцінки студентів у окремій групі з певного предмета.

SELECT gr.name as [group], d.name as discipline, s.fullname as name,
       g.grade as grade, g.date_of as date
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN groups gr ON gr.id = s.group_id
LEFT JOIN disciplines d ON d.id = g.discipline_id
WHERE gr.id = 3 AND d.id = 1
ORDER BY date

-- 8. Знайти середній бал, який ставить певний викладач зі своїх предметів.

SELECT t.fullname as name, ROUND(AVG(g.grade), 2) as avg_grade,
       COUNT(g.grade) as [count] 
FROM grades g
LEFT JOIN disciplines d ON d.id = g.discipline_id
LEFT JOIN teachers t ON t.id = d.teacher_id
WHERE t.id = 5

-- 9. Знайти список курсів, які відвідує студент.

SELECT d.name as discipline
FROM disciplines d
JOIN grades g ON g.discipline_id = d.id 
JOIN students s ON s.id = g.student_id
WHERE s.id = 4
GROUP BY discipline
ORDER BY discipline

-- 10. Список курсів, які певному студенту читає певний викладач.

SELECT d.name as discipline
FROM disciplines d
JOIN grades g ON g.discipline_id = d.id
JOIN students s ON s.id = g.student_id
JOIN teachers t ON t.id = d.teacher_id
WHERE s.id = 4 AND t.id = 1
GROUP BY discipline
ORDER BY discipline

-- 11. Середній бал, який певний викладач ставить певному студентові.

SELECT t.fullname as teacher, s.fullname as student,
       ROUND(AVG(g.grade), 2) as avg_grade, COUNT(g.grade) as count_grade
FROM grades g
JOIN disciplines d ON d.id = g.discipline_id
JOIN teachers t ON t.id = d.teacher_id
JOIN students s ON s.id = g.student_id
WHERE s.id = 13 AND t.id = 1

-- 12. Оцінки студентів у певній групі з певного предмета на останньому занятті.

SELECT gr.name as [group], d.name as discipline, s.fullname as student,  g.grade as grade, g.date_of as date
FROM grades g
JOIN disciplines d ON d.id = g.discipline_id
JOIN students s ON s.id = g.student_id
JOIN groups gr ON gr.id = s.group_id
WHERE d.id = 3 AND gr.id = 2  
     AND  date = (SELECT MAX(g.date_of) FROM grades g
     JOIN disciplines d ON d.id = g.discipline_id
     JOIN  students s ON s.id = g.student_id
     JOIN groups gr ON gr.id = s.group_id
     WHERE d.id = 3 AND gr.id = 2)
