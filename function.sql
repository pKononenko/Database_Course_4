-- Якщо тип не заміняється
/*DROP VIEW GAMEDATA;
DROP TYPE publisher_platform_row_table;
DROP TYPE publisher_platform_row;*/


-- Трохи перероблене VIEW з 3ЛР
CREATE OR REPLACE VIEW
GAMEDATA
AS
    SELECT
        GAMEPLATFORM.game_name,
        GAMEPLATFORM.publisher,
        GAMEPLATFORM.platform,
        CUSTOMERGAME.region,
        SUM(CUSTOMERGAME.price) AS SALES
    FROM 
        GAMEPLATFORM
    JOIN
        CUSTOMERGAME 
        ON
            CUSTOMERGAME.game_name = GAMEPLATFORM.game_name
            AND CUSTOMERGAME.publisher = GAMEPLATFORM.publisher
            AND CUSTOMERGAME.platform = GAMEPLATFORM.platform
    GROUP BY GAMEPLATFORM.game_name, GAMEPLATFORM.publisher, GAMEPLATFORM.platform, CUSTOMERGAME.region
    ORDER BY SALES DESC;


-- Створюємо об'єкт рядку майбутньої таблиці
-- (<platform_on_sales: varchar>, <platform_region_sales: decimal>)
CREATE OR REPLACE TYPE publisher_platform_row
IS 
OBJECT(
    publisher_on_sales VARCHAR(75),
    platform_on_sales VARCHAR(50),
    region VARCHAR(5),
    sales_on_sales DECIMAL(5,2));

/

-- Створюємо тип, який є таблицею, рядки якої
-- Мають тип platform_region_row
CREATE OR REPLACE TYPE publisher_platform_row_table
IS 
TABLE OF publisher_platform_row;
    
/

-- Створення pipeline функції яка визначає
-- Скільки заробив певний PUBLISHER за ігри
-- На певній platform в різних регіонах
CREATE OR REPLACE FUNCTION CALC_PUBLISHER_PLATFORM_SALES(
    publisher_param PUBLISHER.publisher%TYPE,
    platform_param PLATFORM.platform%TYPE
)
RETURN publisher_platform_row_table
PIPELINED
IS
    -- Курсор, у якому міститимуться результати запиту
    CURSOR publisher_sales_cursor 
    IS
    SELECT
        GAMEDATA.publisher AS publisher,
        GAMEDATA.platform AS platform,
        GAMEDATA.region AS sales_region,
        SUM(GAMEDATA.SALES) AS PUBLISHER_REGION_SALES
    FROM
        GAMEDATA
    WHERE
        GAMEDATA.publisher = publisher_param
        AND GAMEDATA.platform = platform_param
    GROUP BY GAMEDATA.publisher, GAMEDATA.platform, GAMEDATA.region
    ORDER BY PUBLISHER_REGION_SALES DESC;

BEGIN
    
    FOR publisher_platform_iter IN publisher_sales_cursor
    LOOP
        pipe row
        (
            publisher_platform_row
            (
                publisher_platform_iter.publisher,
                publisher_platform_iter.platform,
                publisher_platform_iter.sales_region,
                publisher_platform_iter.publisher_region_sales
            )    
        );
    END LOOP;

END;
