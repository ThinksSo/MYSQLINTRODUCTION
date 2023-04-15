/* Урок 1. Установка СУБД, подключение к БД, просмотр и создание таблиц
 
 1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. 
 Необходимые поля таблицы: product_name (название товара), manufacturer (производитель), product_count (количество), price (цена). 
 Заполните БД произвольными данными.
 2. Напишите SELECT-запрос, который выводит название товара, производителя и цену для товаров, количество которых превышает 2
 3. Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”
 
 4.* С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
 4.1.* Товары, в которых есть упоминание "Iphone"
 4.2.* Товары, в которых есть упоминание "Samsung"
 4.3.* Товары, в названии которых есть ЦИФРЫ
 4.4.* Товары, в названии которых есть ЦИФРА "8"
 */
-- 1.Создайте таблицу с мобильными телефонами, используя графический интерфейс.
CREATE TABLE `oltestdb`.`mobile_phones` (
    `idmobile_phones` INT NOT NULL AUTO_INCREMENT,
    `product_name` VARCHAR(45) NOT NULL,
    `manufacturer` VARCHAR(45) NOT NULL,
    `product_count` INT NULL,
    `price` DECIMAL(10, 2) NULL,
    PRIMARY KEY (`idmobile_phones`));

/* 2.Напишите SELECT - запрос, который выводит название товара,
 производителя и цену для товаров, количество которых превышает 2 */
SELECT product_name,
    manufacturer,
    price
FROM oltestdb.mobile_phones
WHERE product_count > 2;

-- 3.Выведите SELECT - запросом весь ассортимент товаров марки “ Samsung ”
SELECT product_name
FROM oltestdb.mobile_phones
WHERE manufacturer = 'Samsung';

-- 4.1.* Товары, в которых есть упоминание "Iphone"
SELECT product_name
FROM oltestdb.mobile_phones
WHERE product_name LIKE '%IPhone%';

-- 4.2.* Товары, в которых есть упоминание "Samsung"
SELECT product_name
FROM oltestdb.mobile_phones
WHERE product_name LIKE '%Samsung%';

-- 4.3.* Товары, в названии которых есть ЦИФРЫ
SELECT product_name
FROM oltestdb.mobile_phones
WHERE product_name REGEXP '[0-9]';

-- 4.4.* Товары, в названии которых есть ЦИФРА "8"
SELECT product_name
FROM oltestdb.mobile_phones
WHERE product_name REGEXP '[8]';