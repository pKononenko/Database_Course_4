
-- Продемонструємо роботу функцій та процедур
SET DEFINE ON;
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.enable;
END;

-- Додамо ще трохи даних для демонстрації
-- INSERT INTO GAME
INSERT INTO GAME
VALUES ('World of Warcraft');
INSERT INTO GAME
VALUES ('Super Mario');

-- INSERT INTO GENRE
INSERT INTO GENRE
VALUES ('RPG');

-- INSERT INTO PLATFORMS
INSERT INTO PLATFORM
VALUES ('Nintendo');

-- INSERT IN GAMEGENRE
INSERT INTO GAMEGENRE
VALUES ('World of Warcraft', 'RPG');
INSERT INTO GAMEGENRE
VALUES ('Super Mario', 'Arcade');

-- INSERT IN PUBLISHER
INSERT INTO PUBLISHER
VALUES ('Nintendo');
INSERT INTO PUBLISHER
VALUES ('Blizzard');

-- INSERT IN GAMEPUBLISHER
INSERT INTO GAMEPUBLISHER
VALUES ('World of Warcraft', 'Blizzard', 2004);
INSERT INTO GAMEPUBLISHER
VALUES ('Super Mario', 'Nintendo', 1990);

-- INSERT IN GAMEPLATFORM
INSERT INTO GAMEPLATFORM
VALUES ('World of Warcraft', 'Blizzard', 'PC');
INSERT INTO GAMEPLATFORM
VALUES ('Super Mario', 'Nintendo', 'Nintendo');

-- INSERT IN CUSTOMER
INSERT INTO CUSTOMER
VALUES (4, 'Bobchenko');

-- INSERT IN COUNTRY
INSERT INTO COUNTRY
VALUES ('London', 'EU');

-- INSERT IN ZIPCODE
INSERT INTO ZIPCODE
VALUES ('27890', 'London');

-- INSERT IN CustomerZip
INSERT INTO CUSTOMERZIP
VALUES (4, '27890');

DECLARE
    -- Курсор для демонстрації CUSTOMERGAME
    CURSOR customergame_data
    IS
        SELECT * FROM CUSTOMERGAME;
        
    -- Курсор для демонстрації VIEW
    CURSOR view_data
    IS
        SELECT * FROM GAMEDATA;
        
    -- Курсор для демонстрації функції
    /*CURSOR sales_data_func
    IS
        SELECT * FROM TABLE(calc_publisher_platform_sales('Activision', 'PC'));*/
        
BEGIN
    
    -- Перевірка процедури
    DBMS_OUTPUT.put_line('Для перевірки процедури, спробуємо додати 3 записи, 1 з яких робочий.');
    DBMS_OUTPUT.put_line('Інші записи будь оброблені, але не додані , адже не буде існувати такої гри або покупця.');
    DBMS_OUTPUT.put_line('Для початку, виведемо CUSTOMERGAME до додавання та CUSTOMERGAME після:');
    
    FOR cust_iter IN customergame_data
    LOOP
        DBMS_OUTPUT.put_line(cust_iter.cust_id||' '||cust_iter.game_name||' '||cust_iter.publisher||' '||cust_iter.platform||' '||cust_iter.region||' '||cust_iter.price);
    END LOOP;
    
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line('Додамо існуючу гру існуючому customer:');
    ADD_GAME_TO_CUSTOMER(4, 'Super Mario', 'Nintendo', 'Nintendo', 'EU', 4.6);
    
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line('Додамо неіснуючу гру існуючому customer, а потім навпаки');
    ADD_GAME_TO_CUSTOMER(4, 'Super Mario 200', 'Nintendo', 'Nintendo', 'EU', 4.6);
    ADD_GAME_TO_CUSTOMER(45, 'Super Mario', 'Nintendo', 'Nintendo', 'EU', 4.6);
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line('CUSTOMERGAME після доданого запису');
    
    FOR cust_iter IN customergame_data
    LOOP
        DBMS_OUTPUT.put_line(cust_iter.cust_id||' '||cust_iter.game_name||' '||cust_iter.publisher||' '||cust_iter.platform||' '||cust_iter.region||' '||cust_iter.price);
    END LOOP;
    
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line('');
    
    
    -- Перевірка функції
    DBMS_OUTPUT.put_line('Для перевірки функції, спробуємо вивести VIEW, а потім результати обчислень функції.');
    DBMS_OUTPUT.put_line('Функція повинна повернути таблицю, в якій знаходится publisher та прибуток від продажу');
    DBMS_OUTPUT.put_line('Ігр певної platform в різних region.');
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line('Виведемо VIEW:');
    
    FOR view_iter IN view_data
    LOOP
        DBMS_OUTPUT.put_line(view_iter.game_name||' '||view_iter.publisher||' '||view_iter.platform||' '||view_iter.region||' '||view_iter.sales);
    END LOOP;
    
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line('Виведемо результат функції для Activision PC:');
    
    -- Замість курсору, для наглядності, додамо subquery з викликом функції
    -- Та конвертації її результату в таблицю
    FOR func_iterator IN (SELECT * FROM TABLE(calc_publisher_platform_sales('Activision', 'PC')))
    LOOP
        DBMS_OUTPUT.put_line(func_iterator.publisher_on_sales||' '||func_iterator.platform_on_sales||' '||func_iterator.region||' '||func_iterator.sales_on_sales);
    END LOOP;
    
    -- Видалення доданого покупця за для багаторазового
    -- Використання коду
    DELETE FROM CUSTOMERGAME WHERE cust_id = 4;
    
END;
