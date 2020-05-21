
SET DEFINE ON;
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.ENABLE;
END;

/

-- Реалізація тригеру
-- ЗАВДАННЯ: При додаванні нового запису Game
-- вказує цій грі жанр "General"

CREATE OR REPLACE TRIGGER game_general_genre_insert
AFTER INSERT
    ON GAME
FOR EACH ROW
DECLARE
    game_name_inserted GAME.game_name%TYPE;
BEGIN
    game_name_inserted := :new.game_name;

    INSERT INTO GAMEGENRE(game_name, genre)
    VALUES(game_name_inserted, 'General');
END;

/

-- Додатковий тригер, який перевіряє, чи
-- є гра в таблиці Game

CREATE OR REPLACE TRIGGER check_trigger
BEFORE INSERT 
    ON GAME
FOR EACH ROW
DECLARE 
    counter INTEGER := 0;
BEGIN
    SELECT COUNT(*) INTO counter FROM GAME WHERE game_name = :new.game_name;
    IF counter > 0 THEN
        dbms_output.put_line('Game '||:new.game_name||' is exists!');
    END IF;
END;
