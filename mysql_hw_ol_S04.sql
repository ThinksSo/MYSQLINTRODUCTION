/* Урок 4. SQL – работа с несколькими таблицами
 1. Подсчитать количество групп, в которые вступил каждый пользователь.
 2. Подсчитать количество пользователей в каждом сообществе.
 3. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
 4* Подсчитать общее количество лайков, которые получили пользователи младше 18 лет..
 5* Определить кто больше поставил лайков (всего): мужчины или женщины.
 */

 
USE VK;

SELECT lastname AS member,
    COUNT(*) AS users_groups
FROM users
    JOIN users_communities on users.id = users_communities.user_id
GROUP BY users.id
ORDER BY COUNT(*) DESC;


SELECT communities.name,
    count(*)
FROM users_communities
    JOIN communities ON users_communities.community_id = communities.id
GROUP BY communities.id;


SELECT from_user_id,
    COUNT(*) as send
FROM messages
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY send DESC
limit 1;


SELECT COUNT(*) as 'Likes'
FROM profiles
WHERE (YEAR(NOW()) - YEAR(birthday)) < 18;