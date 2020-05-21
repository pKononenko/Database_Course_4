

CREATE OR REPLACE PROCEDURE ADD_GAME_TO_CUSTOMER
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
