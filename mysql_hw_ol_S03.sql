/*
 1. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений 
 в алфавитном порядке. [ORDER BY]
 2. Выведите количество мужчин старше 35 лет [COUNT].
 3. Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]
 * Выведите номер пользователя, который отправил больше всех заявок в друзья (таблица friend_requests) [LIMIT].
 ** Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].
 */


SELECT DISTINCT firstname
FROM vk.users
ORDER BY firstname;


SELECT COUNT(*)
FROM vk.profiles
WHERE gender = 'm'
    AND (YEAR(CURDATE()) - YEAR(birthday)) > 35;


SELECT status,
    COUNT(target_user_id)
FROM vk.friend_requests
GROUP BY status;


SELECT id, name
FROM vk.communities 
WHERE name LIKE '_____';