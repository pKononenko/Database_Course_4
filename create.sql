-- DROP section

-- DROP TABLE GAME CASCADE CONSTRAINTS;
-- DROP TABLE GENRE CASCADE CONSTRAINTS;
-- DROP TABLE PLATFORM CASCADE CONSTRAINTS;
-- DROP TABLE PUBLISHER CASCADE CONSTRAINTS;
-- DROP TABLE REGION CASCADE CONSTRAINTS;

-- DROP TABLE GAMEGENRE CASCADE CONSTRAINTS;
-- DROP TABLE GAMEPUBLISHER CASCADE CONSTRAINTS;
-- DROP TABLE GAMEPLATFORM CASCADE CONSTRAINTS;
-- DROP TABLE COUNTRY CASCADE CONSTRAINTS;
-- DROP TABLE ZIPCODE CASCADE CONSTRAINTS;
-- DROP TABLE CUSTOMERZIP CASCADE CONSTRAINTS;
-- DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
-- DROP TABLE CUSTOMERGAME CASCADE CONSTRAINTS;

-- CREATE and ALTER section

CREATE TABLE game (
    game_name VARCHAR2(150) NOT NULL
);

ALTER TABLE game ADD CONSTRAINT game_pk PRIMARY KEY ( game_name );

CREATE TABLE genre (
    genre VARCHAR2(50) NOT NULL
);

ALTER TABLE genre ADD CONSTRAINT genre_pk PRIMARY KEY ( genre );

CREATE TABLE platform (
    platform VARCHAR2(50) NOT NULL
);

ALTER TABLE platform ADD CONSTRAINT platform_pk PRIMARY KEY ( platform );

CREATE TABLE publisher (
    publisher VARCHAR2(75) NOT NULL
);

ALTER TABLE publisher ADD CONSTRAINT publisher_pk PRIMARY KEY ( publisher );

CREATE TABLE region (
    region VARCHAR2(5) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( region );

CREATE TABLE gamegenre (
    game_name  VARCHAR2(150) NOT NULL,
    genre      VARCHAR2(50) NOT NULL
);

ALTER TABLE gamegenre ADD CONSTRAINT gamegenre_pk PRIMARY KEY ( game_name,
                                                                genre );

CREATE TABLE gamepublisher (
    game_name        VARCHAR2(150) NOT NULL,
    publisher        VARCHAR2(75) NOT NULL,
    year_of_release  INTEGER
);

ALTER TABLE gamepublisher ADD CONSTRAINT gamepublisher_pk PRIMARY KEY ( game_name,
                                                                        publisher );

CREATE TABLE gameplatform (
    game_name  VARCHAR2(150) NOT NULL,
    publisher  VARCHAR2(75) NOT NULL,
    platform   VARCHAR2(50) NOT NULL
);

ALTER TABLE gameplatform
    ADD CONSTRAINT gameplatform_pk PRIMARY KEY ( game_name,
                                                 publisher,
                                                 platform );

CREATE TABLE country (
    country  VARCHAR2(50) NOT NULL,
    region   VARCHAR2(5) NOT NULL
);

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( country );

CREATE TABLE customer (
    cust_id  INTEGER NOT NULL,
    name     VARCHAR2(50)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cust_id );

CREATE TABLE zipcode (
    zip_code  VARCHAR2(20) NOT NULL,
    country   VARCHAR2(50) NOT NULL
);

ALTER TABLE zipcode ADD CONSTRAINT zipcode_pk PRIMARY KEY ( zip_code );


CREATE TABLE customerzip (
    cust_id   INTEGER NOT NULL,
    zip_code  VARCHAR2(20) NOT NULL
);

ALTER TABLE customerzip ADD CONSTRAINT customerzip_pk PRIMARY KEY ( zip_code,
                                                                    cust_id );

CREATE TABLE customergame (
    cust_id    INTEGER NOT NULL,
    game_name  VARCHAR2(150) NOT NULL,
    publisher  VARCHAR2(75) NOT NULL,
    platform   VARCHAR2(50) NOT NULL,
    region     VARCHAR2(5) NOT NULL,
    price      DECIMAL(5, 2)
);

ALTER TABLE customergame
    ADD CONSTRAINT customergame_pk PRIMARY KEY ( game_name,
                                                 publisher,
                                                 platform,
                                                 cust_id );

ALTER TABLE country
    ADD CONSTRAINT country_region_fk FOREIGN KEY ( region )
        REFERENCES region ( region );

ALTER TABLE customergame
    ADD CONSTRAINT customergame_customer_fk FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

ALTER TABLE customergame
    ADD CONSTRAINT customergame_gameplatform_fk FOREIGN KEY ( game_name,
                                                              publisher,
                                                              platform )
        REFERENCES gameplatform ( game_name,
                                  publisher,
                                  platform );

ALTER TABLE customergame
    ADD CONSTRAINT customergame_region_fk FOREIGN KEY ( region )
        REFERENCES region ( region );

ALTER TABLE customerzip
    ADD CONSTRAINT customerzip_customer_fk FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

ALTER TABLE customerzip
    ADD CONSTRAINT customerzip_zipcode_fk FOREIGN KEY ( zip_code )
        REFERENCES zipcode ( zip_code );

ALTER TABLE gamegenre
    ADD CONSTRAINT gamegenre_game_fk FOREIGN KEY ( game_name )
        REFERENCES game ( game_name );

ALTER TABLE gamegenre
    ADD CONSTRAINT gamegenre_genre_fk FOREIGN KEY ( genre )
        REFERENCES genre ( genre );

ALTER TABLE gameplatform
    ADD CONSTRAINT gameplatform_gamepublisher_fk FOREIGN KEY ( game_name,
                                                               publisher )
        REFERENCES gamepublisher ( game_name,
                                   publisher );

ALTER TABLE gameplatform
    ADD CONSTRAINT gameplatform_platform_fk FOREIGN KEY ( platform )
        REFERENCES platform ( platform );

ALTER TABLE gamepublisher
    ADD CONSTRAINT gamepublisher_game_fk FOREIGN KEY ( game_name )
        REFERENCES game ( game_name );

ALTER TABLE gamepublisher
    ADD CONSTRAINT gamepublisher_publisher_fk FOREIGN KEY ( publisher )
        REFERENCES publisher ( publisher );

ALTER TABLE zipcode
    ADD CONSTRAINT zipcode_country_fk FOREIGN KEY ( country )
        REFERENCES country ( country );
