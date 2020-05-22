-- Створимо пакет, який міститиме в собі необхідні нам
-- типи, процедури та функції
-- функції та типи в пакеті будуть трохи переписані
-- з дотриманням структурного стилю, а не об'єктного
CREATE OR REPLACE PACKAGE GAMEDATA_MANIPULATE_PACKAGE
IS
    -- Тип майбутнього рядка таблиці
    -- Вже не як об'єкт, а як запис
    TYPE publisher_platform_row
    IS 
    RECORD(
        publisher_on_sales VARCHAR(75),
        platform_on_sales VARCHAR(50),
        region VARCHAR(5),
        sales_on_sales DECIMAL(5,2));    

    -- Тип таблиці, яка складається з
    -- рядків типу publisher_platform_row
    TYPE publisher_platform_row_table
    IS 
    TABLE OF publisher_platform_row;

    -- Прототип процедури
    PROCEDURE ADD_GAME_TO_CUSTOMER
    (
        cust_id_proc IN CUSTOMER.CUST_ID%TYPE,
        game_name_proc IN GAME.GAME_NAME%TYPE,
        publisher_proc IN PUBLISHER.publisher%TYPE,
        platform_proc IN PLATFORM.platform%TYPE,
        region_proc IN REGION.region%TYPE,
        price_proc IN CUSTOMERGAME.price%TYPE
    );

    -- Прототип функції, який переписано
    -- Структурному стилі
    FUNCTION CALC_PUBLISHER_PLATFORM_SALES(
    publisher_param PUBLISHER.publisher%TYPE,
    platform_param PLATFORM.platform%TYPE
    )
    RETURN publisher_platform_row_table
    PIPELINED;

END GAMEDATA_MANIPULATE_PACKAGE;
 
/

-- Додамо реалізації в пакет
CREATE OR REPLACE PACKAGE BODY GAMEDATA_MANIPULATE_PACKAGE
IS
    -- Додамо реалізацію процедури замість її прототипу в пакет
    PROCEDURE ADD_GAME_TO_CUSTOMER
    (
        cust_id_proc IN CUSTOMER.CUST_ID%TYPE,
        game_name_proc IN GAME.GAME_NAME%TYPE,
        publisher_proc IN PUBLISHER.publisher%TYPE,
        platform_proc IN PLATFORM.platform%TYPE,
        region_proc IN REGION.region%TYPE,
        price_proc IN CUSTOMERGAME.price%TYPE
    )
    IS
        cust_id_current CUSTOMER.CUST_ID%TYPE;
        game_name_current GAME.GAME_NAME%TYPE;
        publisher_current PUBLISHER.publisher%TYPE;
        platform_current PLATFORM.platform%TYPE;
    BEGIN
        
        SELECT
            CUSTOMER.CUST_ID
        INTO
            cust_id_current
        FROM
            CUSTOMER
        WHERE
            CUSTOMER.cust_id = cust_id_proc;
            
        SELECT
            GAMEPLATFORM.GAME_NAME,
            GAMEPLATFORM.PUBLISHER,
            GAMEPLATFORM.PLATFORM
        INTO
            game_name_current,
            publisher_current,
            platform_current
        FROM 
            GAMEPLATFORM
        WHERE
            TRIM(GAMEPLATFORM.GAME_NAME) = TRIM(game_name_proc)
            AND TRIM(GAMEPLATFORM.PUBLISHER) = TRIM(publisher_proc)
            AND TRIM(GAMEPLATFORM.PLATFORM) = TRIM(platform_proc);    
            
        INSERT INTO CUSTOMERGAME
        VALUES
        (
            cust_id_proc,
            game_name_proc,
            publisher_proc,
            platform_proc,
            region_proc,
            price_proc
        );
        
        DBMS_OUTPUT.put_line('Data inserted! Check CUSTOMERGAME table');
        
    EXCEPTION
        
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No user with id: '||cust_id_proc||' or game with name: '||game_name_proc||'; publisher: '||publisher_proc||'; platform: '||platform_proc||' was found.');
        
    END;


    -- Додамо реалізацію функції до замість прототипу в пакет
    FUNCTION CALC_PUBLISHER_PLATFORM_SALES(
        publisher_param PUBLISHER.publisher%TYPE,
        platform_param PLATFORM.platform%TYPE
    )
    RETURN publisher_platform_row_table
    PIPELINED
    IS
    BEGIN
        
        FOR publisher_platform_iter IN
        (
            SELECT
                GAMEDATA.publisher,
                GAMEDATA.platform,
                GAMEDATA.region,
                SUM(GAMEDATA.SALES) AS PUBLISHER_REGION_SALES
            FROM
                GAMEDATA
            WHERE
                GAMEDATA.publisher = publisher_param
                AND GAMEDATA.platform = platform_param
            GROUP BY GAMEDATA.publisher, GAMEDATA.platform, GAMEDATA.region  
        )                        
        LOOP
            pipe row(publisher_platform_iter);
        END LOOP;
    
    END;

END GAMEDATA_MANIPULATE_PACKAGE;
