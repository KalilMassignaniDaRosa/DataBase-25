CREATE DATABASE REALESTATE;

USE REALESTATE;

CREATE TABLE IF NOT EXISTS  `PROPERTY`(
	`ID` INT NOT NULL AUTO_INCREMENT,
    `NAME` CHAR(50) NOT NULL,
    `DESCRIPTION` TINYTEXT NOT NULL ,
    `N_ROOMS` INT NOT NULL,
    `SALE_VALUE` FLOAT NOT NULL,
    PRIMARY KEY `PK_PROPERTY` (`ID`)
);

SELECT * FROM `PROPERTY`;

INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Edificio Novelo', 'Um belo prédio', 5, 500000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Edificio Verde', 'Um prédio sustentável com energia solar', 4, 450000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Residencial Sol Nascente', 'Condomínio com área de lazer completa', 3, 350000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Casa do Lago', 'Linda casa à beira do lago', 6, 750000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Apartamento Central', 'Apartamento moderno no centro da cidade', 2, 300000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Chácara dos Sonhos', 'Chácara com amplo espaço verde', 5, 600000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Edificio Jardim', 'Prédio com vista para o parque', 4, 550000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Casa da Praia', 'Casa de veraneio a poucos passos da praia', 3, 400000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Loft Urbano', 'Loft moderno em área revitalizada', 1, 250000);
INSERT INTO PROPERTY (NAME, DESCRIPTION, N_ROOMS, SALE_VALUE) VALUES ('Mansão dos Ventos', 'Luxuosa mansão com piscina e jardim', 8, 2000000);

SELECT * FROM PROPERTY;

SELECT * FROM PROPERTY WHERE SALE_VALUE < 500000 AND N_ROOMS > 2;

SELECT * FROM PROPERTY WHERE  N_ROOMS > 5;

-- % indica que tem coisas antes e depois
SELECT * FROM PROPERTY WHERE SALE_VALUE >= 500000 AND NAME LIKE '%Edificio%';
