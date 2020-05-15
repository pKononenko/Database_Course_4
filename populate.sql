
-- INSERT section
-- INSERT IN GAME
INSERT INTO GAME
VALUES ('Minecraft');
INSERT INTO GAME
VALUES ('Call of Duty');
INSERT INTO GAME
VALUES ('Sims 4');

-- INSERT IN GENRE
INSERT INTO GENRE
VALUES ('General');
INSERT INTO GENRE
VALUES ('Arcade');
INSERT INTO GENRE
VALUES ('Shooter');
INSERT INTO GENRE
VALUES ('Simulator');

-- INSERT IN GAMEGENRE
INSERT INTO GAMEGENRE
VALUES ('Call of Duty', 'Shooter');
INSERT INTO GAMEGENRE
VALUES ('Minecraft', 'Arcade');
INSERT INTO GAMEGENRE
VALUES ('Sims 4', 'Simulator');

-- INSERT IN PUBLISHER
INSERT INTO PUBLISHER
VALUES ('Activision');
INSERT INTO PUBLISHER
VALUES ('Mojang');
INSERT INTO PUBLISHER
VALUES ('EA');

-- INSERT IN PLATFORM
INSERT INTO PLATFORM
VALUES ('PC');
INSERT INTO PLATFORM
VALUES ('PS3');
INSERT INTO PLATFORM
VALUES ('Xbox');

-- INSERT IN GAMEPUBLISHER
INSERT INTO GAMEPUBLISHER
VALUES ('Call of Duty', 'Activision', 2002);
INSERT INTO GAMEPUBLISHER
VALUES ('Minecraft', 'Mojang', 2010);
INSERT INTO GAMEPUBLISHER
VALUES ('Sims 4', 'EA', 2013);

-- INSERT IN GAMEPLATFORM
INSERT INTO GAMEPLATFORM
VALUES ('Call of Duty', 'Activision', 'PC');
INSERT INTO GAMEPLATFORM
VALUES ('Call of Duty', 'Activision', 'Xbox');
INSERT INTO GAMEPLATFORM
VALUES ('Minecraft', 'Mojang', 'PC');
INSERT INTO GAMEPLATFORM
VALUES ('Sims 4', 'EA', 'PC');

-- INSERT IN REGION
INSERT INTO REGION
VALUES ('Other');
INSERT INTO REGION
VALUES ('EU');
INSERT INTO REGION
VALUES ('NA');
INSERT INTO REGION
VALUES ('JP');

-- INSERT IN CUSTOMER
INSERT INTO CUSTOMER
VALUES (1, 'Bob');
INSERT INTO CUSTOMER
VALUES (2, 'Boba');
INSERT INTO CUSTOMER
VALUES (3, 'Boban');

-- INSERT IN COUNTRY
INSERT INTO COUNTRY
VALUES ('USA', 'NA');
INSERT INTO COUNTRY
VALUES ('Germany', 'EU');
INSERT INTO COUNTRY
VALUES ('Japan', 'JP');

-- INSERT IN ZIPCODE
INSERT INTO ZIPCODE
VALUES ('02840', 'USA');
INSERT INTO ZIPCODE
VALUES ('25992', 'Germany');
INSERT INTO ZIPCODE
VALUES ('031-1020', 'Japan');

-- INSERT IN CustomerZip
INSERT INTO CUSTOMERZIP
VALUES (1, '25992');
INSERT INTO CUSTOMERZIP
VALUES (2, '031-1020');
INSERT INTO CUSTOMERZIP
VALUES (3, '02840');

-- INSERT IN CUSTOMERGAME
INSERT INTO CUSTOMERGAME
VALUES (1, 'Call of Duty', 'Activision', 'PC', 'EU', 5.2);
INSERT INTO CUSTOMERGAME
VALUES (2, 'Call of Duty', 'Activision', 'PC', 'NA', 6.7);
INSERT INTO CUSTOMERGAME
VALUES (3, 'Sims 4', 'EA', 'PC', 'EU', 4.0);
