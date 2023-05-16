/*
 Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы
 1. Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk. 
 Пользователь задается по id. Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users.
 Функция должна возвращать номер пользователя.
 2. Предыдущую задачу решить с помощью процедуры и обернуть используемые команды в транзакцию внутри процедуры.
 3.* Написать триггер, который проверяет новое появляющееся сообщество. 
 Длина названия сообщества (поле name) должна быть не менее 5 символов. 
 Если требование не выполнено, то выбрасывать исключение с пояснением.
 */


USE VK;
ALTER TABLE `vk`.`profiles` DROP FOREIGN KEY `profiles_ibfk_2`;
ALTER TABLE `vk`.`profiles` DROP INDEX `photo_id`;
ALTER TABLE `vk`.`profiles`
ADD CONSTRAINT `profiles_ibfk_2` FOREIGN KEY () REFERENCES `vk`.`media` ();


-- Task 1.

USE `vk`;
DROP function IF EXISTS `vk`.`del_users_data`;
DELIMITER 
USE `vk` CREATE DEFINER = `root` @`localhost` FUNCTION `del_users_data`(del_user_id BIGINT) 
RETURNS bigint 
DETERMINISTIC 

BEGIN
    -- ver.1
    /* DELETE friend_requests, likes, media, messages, users_communities, profiles FROM users  
    JOIN friend_requests ON users.id=friend_requests.initiator_user_id OR users.id=friend_requests.target_user_id  
    JOIN likes ON users.id=likes.user_id  
    JOIN media ON users.id=media.user_id 
    JOIN messages ON users.id=messages.from_user_id 
    INNER JOIN users_communities ON users.id = users_communities.user_id 
    JOIN profiles ON users.id=profiles.user_id 
    WHERE users.id = del_user_id;
    */
    -- ver 2.
    DELETE FROM friend_requests WHERE initiator_user_id = del_user_id;
    DELETE FROM friend_requests WHERE target_user_id = del_user_id;
    DELETE FROM likes WHERE user_id = del_user_id;
    DELETE FROM media WHERE user_id = del_user_id;
    DELETE FROM messages WHERE from_user_id = del_user_id;
    DELETE FROM users_communities WHERE user_id = del_user_id;
    DELETE FROM profiles WHERE user_id = del_user_id;
    DELETE FROM users WHERE id = del_user_id;
RETURN del_user_id;
END DELIMITER;

SELECT del_users_data (10);

-- Task 2.

USE `vk`;
DROP procedure IF EXISTS `del_users_data`;
DELIMITER 
USE `vk` CREATE PROCEDURE del_users_data (del_user_id BIGINT) 
BEGIN 
    START TRANSACTION;
        DELETE FROM friend_requests WHERE initiator_user_id = del_user_id;
        DELETE FROM friend_requests WHERE target_user_id = del_user_id;
        DELETE FROM likes WHERE user_id = del_user_id;
        DELETE FROM media WHERE user_id = del_user_id;
        DELETE FROM messages WHERE from_user_id = del_user_id;
        DELETE FROM users_communities WHERE user_id = del_user_id;
        DELETE FROM profiles WHERE user_id = del_user_id;
        DELETE FROM users WHERE id = del_user_id;
    COMMIT;
END 
DELIMITER;


CALL del_users_data (8);
