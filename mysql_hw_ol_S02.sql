/*
 Создать БД vk, исполнив скрипт _vk_db_creation.sql (в материалах к уроку)
 Написать скрипт, добавляющий в созданную БД vk 2-3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE)
 Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)
 4.* Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = true). При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = false (или 0) (ALTER TABLE + UPDATE)
 5.* Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE)
 */

USE vk;
DROP TABLE IF EXISTS news_types;
CREATE TABLE news_types(
    id SERIAL,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS user_news;
CREATE TABLE user_news (
    id SERIAL,
    news_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (news_type_id) REFERENCES news_types(id)
);

ALTER TABLE `vk`.`profiles`
ADD COLUMN `profession` VARCHAR(55) NULL
AFTER `birthday`;


USE vk;
INSERT INTO `users` (firstname, lastname)
VALUES ('Мел', 'Гибсон'),
    ('Джулия', 'Ормонд'),
    ('Адриано', 'Челентано'),
    ('Николас', 'Кейдж'),
    ('Дэвид', 'Боуи'),
    ('Элвис', 'Прэсли'),
    ('Алексей', 'Толстой'),
    ('Валерий', 'Харламов'),
    ('Джим', 'Кэрри'),
    ('Кевин', 'Костнер'),
    ('Владимир', 'Высоцкий'),
    ('Настасья', 'Кински'),
    ('Бриджит', 'Фонда'),
    ('Марат', 'Сафин'),
    ('Вольфанг Амадей', 'Моцарт'),
    ('Антон', 'Чехов'),
    ('Юлия', 'Началова');


USE vk;
INSERT INTO `profiles` (user_id, profession, birthday)
VALUES (1, 'актер', "1956-01-03"),
    (2, 'актриса', "1965-01-04"),
    (3, 'певец', "1938-01-06"),
    (4, 'актер', "1964-01-07"),
    (5, 'певец', "1947-01-08"),
    (6, 'певец', "1935-01-08"),
    (7, 'писатель', "1883-01-10"),
    (8, 'хоккеист', "1948-01-14"),
    (9, 'актер', "1962-01-17"),
    (10, 'актер', "1955-01-18"),
    (11, 'певец', "1938-01-25"),
    (12, 'актриса', "1961-01-24"),
    (13, 'актриса', "1964-01-27"),
    (14, 'теннисист', "1980-01-27"),
    (15, 'композитор', "1756-01-27"),
    (16, 'писатель', "1860-01-29"),
    (17, 'певица', "1981-01-31");

    
-- 5.* Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE)
USE vk;
DELETE FROM messages
WHERE created_at < CURDATE();