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

-- SELECT * FROM GAMEDATA;
