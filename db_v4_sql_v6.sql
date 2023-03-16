-- For details on the implementation of Foreign Keys in MariaDB
-- https://mariadb.com/kb/en/foreign-keys/

DROP SCHEMA IF EXISTS `BH_Metadata` ;

-- -----------------------------------------------------
-- Schema BH_Metadata
-- -----------------------------------------------------
CREATE SCHEMA `BH_Metadata` DEFAULT CHARACTER SET utf8 ;
USE `BH_Metadata` ;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Strain_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Strain_Type` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Strain_Type` (
  `Strain_Type` VARCHAR(40) NOT NULL PRIMARY KEY) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Strain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Strain` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Strain` (
  `Strain` VARCHAR(40) NOT NULL PRIMARY KEY,
  `Strain_Type` VARCHAR(40) NOT NULL,
  `Strain_MGI_ID` VARCHAR(40) NULL,

  CONSTRAINT `fk_Strain_Type`
    FOREIGN KEY (Strain_Type) REFERENCES Strain_Type (Strain_Type)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
  ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Sex`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Sex` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Sex` (
  `Sex` VARCHAR(1) NOT NULL PRIMARY KEY) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Experimental_Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Experimental_Group` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Experimental_Group` (
  `Experimental_Group` VARCHAR(40) NOT NULL PRIMARY KEY) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `mydb`.`Species`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Species` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Species` (
  `Species` VARCHAR(40) NOT NULL PRIMARY KEY) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Zygosity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Zygosity` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Zygosity` (
  `Zygosity` VARCHAR(50) NOT NULL PRIMARY KEY) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Dataset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Dataset` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Dataset` (
  `Dataset` VARCHAR(40) NOT NULL PRIMARY KEY,
  `Description` VARCHAR(200) NULL) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `mydb`.`Stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Stage` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Stage` (
  `Stage` VARCHAR(40) NOT NULL PRIMARY KEY,
  `Life_Phase` VARCHAR(40) NOT NULL

) ENGINE = Aria; 

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Biosample_Name`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `BH_Metadata`.`Biosample_Name` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Biosample_Name` (
  `Biosample_Name` VARCHAR(40) NOT NULL PRIMARY KEY
) ENGINE = Aria; 

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Biosample`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Biosample` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Biosample` (
  `Biosample` VARCHAR(40) NOT NULL PRIMARY KEY,
  `Sex` VARCHAR(1) NOT NULL,
  `Experimental_Group` VARCHAR(40) NOT NULL,
  `Dataset_Origin` VARCHAR(40) NULL,
  `RNASeq_Location` VARCHAR(200) NULL,
  `Treatment` VARCHAR(50) NULL,
  `Species` VARCHAR(40) NOT NULL,
  `Stage` VARCHAR(40) NOT NULL,
  `Biological` BOOLEAN  NOT NULL DEFAULT true,
  
  CONSTRAINT `fk_Biosample_Name`
  FOREIGN KEY (Biosample) REFERENCES Biosample_Name (Biosample_Name)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Sex`
  FOREIGN KEY (Sex) REFERENCES Sex (Sex)
  ON DELETE RESTRICT

  ON UPDATE CASCADE,

  CONSTRAINT `fk_Experimental_Group`
  FOREIGN KEY (Experimental_Group) REFERENCES Experimental_Group (Experimental_Group)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Dataset_Origin`
  FOREIGN KEY (Dataset_Origin) REFERENCES Dataset (Dataset)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Biosample_Species`
  FOREIGN KEY (Species) REFERENCES Species (Species)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Biosample_Stage`
  FOREIGN KEY (Stage) REFERENCES Stage (Stage)
  ON DELETE RESTRICT
  ON UPDATE CASCADE

  ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Gene` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Gene` (
  `Gene` VARCHAR(40) NOT NULL PRIMARY KEY,
  `Gene_MGI_ID` VARCHAR(40) NULL ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Has_Genotype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Has_Genotype` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Has_Genotype` (
  `Biosample` VARCHAR(40) NOT NULL,
  `Gene` VARCHAR(40) NOT NULL,
  `Zygosity` VARCHAR(50) NOT NULL,
  PRIMARY KEY (Biosample,Gene),

  CONSTRAINT `fk_Gene_Gene`
  FOREIGN KEY (Gene) REFERENCES Gene (Gene)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Biosample_Biosample`
  FOREIGN KEY (Biosample) REFERENCES Biosample (Biosample)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Has_Genotype_Zygosity1`
  FOREIGN KEY (`Zygosity`) REFERENCES  Zygosity (Zygosity)
  ON DELETE RESTRICT
  ON UPDATE CASCADE

  ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Dataset_interested_in_Gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Dataset_interested_in_Gene` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Dataset_interested_in_Gene` (
  `Dataset` VARCHAR(40) NOT NULL,
  `Gene` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Dataset`, `Gene`),

  CONSTRAINT `fk_Dataset_Dataset`
  FOREIGN KEY (Dataset) REFERENCES Dataset (Dataset)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Gene_Gene_1`
  FOREIGN KEY (Gene) REFERENCES Gene (Gene)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
  
  ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `mydb`.`Anatomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Anatomy` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Anatomy` (
  `Anatomy` VARCHAR(40) NOT NULL PRIMARY KEY ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Scanner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Scanner` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Scanner` (
  `Scanner` VARCHAR(40) NOT NULL PRIMARY KEY,
  `Brand` VARCHAR(40) NULL,
  `Year` INT NULL) ENGINE = Aria;


-- -----------------------------------------------------
-- Table `BH_Metadata`.`Protocol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Protocol` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Protocol` (
  `Protocol` VARCHAR(40) NOT NULL PRIMARY KEY,
  `Documentation` VARCHAR(200) NOT NULL) ENGINE = Aria;

INSERT INTO Protocol(Protocol) VALUES ('External');

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Biosample_Prepared`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Biosample_Prepared` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Biosample_Prepared` (
  `Biosample` VARCHAR(40) NOT NULL,
  `Protocol` VARCHAR(40) NOT NULL,
  `Start_Date` DATE NULL,
  `Finish_Date` DATE NULL,
  `Anatomy` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Biosample`, `Protocol`,`Anatomy`),

  CONSTRAINT `fk_Biosample_Biosample_1`
  FOREIGN KEY (Biosample) REFERENCES Biosample_Name (Biosample_Name)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Protocol`
  FOREIGN KEY (Protocol) REFERENCES Protocol (Protocol)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Biosample_Prepared_Anatomy`
  FOREIGN KEY (Anatomy) REFERENCES Anatomy (Anatomy)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
  
  ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `mydb`.`Availability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Availability` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Availability` (
  `Availability` VARCHAR(40) NOT NULL PRIMARY KEY )
ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Scan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Scan` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Scan` (
  `Scanner` VARCHAR(40) NOT NULL,
  `Biosample` VARCHAR(40) NOT NULL,
  -- If it is external it is not prepared here
  `Protocol` VARCHAR(40) NULL, 
  `Person` VARCHAR(40) NOT NULL,
  `FileLocation` VARCHAR(200) NOT NULL,
  `Availability` VARCHAR(40) NOT NULL DEFAULT 'Pending',
  `ShipmentID` VARCHAR(40) NULL,
  `ShipmentDate` DATE NULL,
  `Anatomy` VARCHAR(40) NOT NULL,
  `XRes_mm` DECIMAL(8) NULL,
  `YRes_mm` DECIMAL(8) NULL,
  `ZRes_mm` DECIMAL(8) NULL,

  -- suports internal and external
  PRIMARY KEY (`Biosample`, `Protocol`,`Anatomy`,`Scanner`),

  -- because of the externals it has to reference Biosample_Name. That is why that table was created.
  CONSTRAINT `fk_Scanner_has_Biosample_Prepared`
    FOREIGN KEY (`Biosample`) REFERENCES Biosample_Name(`Biosample_Name`),

  -- CONSTRAINT `constrain_samples_internal_externals`
  --   UNIQUE (`Biosample`, `Protocol`,`Anatomy`)
   
  CONSTRAINT `fk_Scanner`
    FOREIGN KEY (Scanner) REFERENCES Scanner(Name)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  CONSTRAINT `fk_Scan_Availability1`
    FOREIGN KEY (Availability) REFERENCES Availability (Availability)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
  
  ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `mydb`.`LMs_Set`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`LMs_Set` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`LMs_Set` (
  `LMs_Set` VARCHAR(30) NOT NULL PRIMARY KEY) ENGINE = Aria;

INSERT INTO LMs_Set VALUES ('Mandible');
INSERT INTO LMs_Set VALUES ('Cranium');
INSERT INTO LMs_Set VALUES ('Endocast');

-- -----------------------------------------------------
-- Table `BH_Metadata`.`LMs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Transformation` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Transformation` (
  `Transformation` VARCHAR(40) NOT NULL PRIMARY KEY
) ENGINE = Aria;

INSERT INTO Transformation VALUES ('NL');
INSERT INTO Transformation VALUES ('Affine');
INSERT INTO Transformation VALUES ('Rigid');
INSERT INTO Transformation VALUES ('Procrustes');

-- -----------------------------------------------------
-- Table `BH_Metadata`.`LMs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`LMs` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`LMs` (
  -- Surrogate key, if not it is 5 fields plus the transformation
  ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

  -- Data of the source LMs. However, it has to be copied for the derived LMs anyway
  `Scanner` VARCHAR(40) NOT NULL,
  `Biosample` VARCHAR(40) NOT NULL,
  `Protocol` VARCHAR(40) NOT NULL,
  `Anatomy` VARCHAR(40) NOT NULL,
  `LMs_Set` VARCHAR(40) NOT NULL,

  -- The file locations are unique for double checking and try to avoid errors when inserting
  `File_Location` VARCHAR(300) NOT NULL UNIQUE,
  `Author` VARCHAR(40) NULL,

  -- 1 to N relation when one entry is the 
  `XFM_Location` VARCHAR(300) NULL UNIQUE,
  `Pipeline_stage` VARCHAR(40) NULL,
  `Source_LM` INT NULL,
  
  CONSTRAINT `fk_Scan`
  FOREIGN KEY (`Biosample`, `Protocol`,`Anatomy`,`Scanner`) REFERENCES Scan(`Biosample`, `Protocol`,`Anatomy`,`Scanner`),

  CONSTRAINT `fk_LMs_LMs_Set`
  FOREIGN KEY (LMs_Set) REFERENCES LMs_Set (LMs_Set)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Source_LM`
  FOREIGN KEY (Source_LM) REFERENCES LMs (ID)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Transformation`
  FOREIGN KEY (Pipeline_stage) REFERENCES Transformation (Transformation)
  ON DELETE RESTRICT
  ON UPDATE CASCADE

  ) ENGINE = Aria;

-- If it is the source LM, it can not have XFM, Stage or Source_LM. If it is derived, the 3 fields 
ALTER TABLE `BH_Metadata`.`LMs`
ADD CONSTRAINT `check_pipeline` CHECK ( ((LMs.XFM_Location IS NULL) AND (LMs.Pipeline_stage IS NULL) AND (LMs.Source_LM IS NULL)) OR  ((LMs.XFM_Location IS NOT NULL) AND (LMs.Pipeline_stage IS NOT NULL) AND (LMs.Source_LM IS NOT NULL)) );

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Quantification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Quantification` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Quantification` (
  `Name` VARCHAR(50) NOT NULL PRIMARY KEY,
  `Objective` VARCHAR(500) NOT NULL,
  `Parameters` VARCHAR(500) NOT NULL,
  `Documentation` VARCHAR(500) NULL) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `BH_Metadata`.`Quantification_with_LMs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Quantification_with_LMs` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Quantification_with_LMs` (
  `LMs_ID` INT NOT NULL,
  `Quantification_Name` VARCHAR(50) NOT NULL,
  `LMsType` VARCHAR(45) NULL,

  PRIMARY KEY (`LMs_ID`, `Quantification_Name`),
  
  CONSTRAINT `fk_LMs_ID`
  FOREIGN KEY (LMs_ID) REFERENCES LMs(ID),

  CONSTRAINT `fk_LMs_ID_Scan`
  FOREIGN KEY (LMs_ID) REFERENCES LMs(ID_Scan)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,

  CONSTRAINT `fk_Quantification`
  FOREIGN KEY (Quantification_Name) REFERENCES Quantification(Name)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
  
  ) ENGINE = Aria;


-- -----------------------------------------------------
-- Table `mydb`.`Participant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Participant` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Participant` (
  `Dataset` VARCHAR(40) NOT NULL,
  `Biosample` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Dataset`, `Biosample`),

  CONSTRAINT `fk_Dataset_has_Biosample_Dataset_1`
    FOREIGN KEY (`Dataset`) REFERENCES Dataset (Dataset)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Dataset_has_Biosample_Biosample_2`
    FOREIGN KEY (Biosample) REFERENCES Biosample(Biosample)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    ) ENGINE = Aria;

-- -----------------------------------------------------
-- Table `mydb`.`Biosample_Strain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BH_Metadata`.`Biosample_Strain` ;

CREATE TABLE IF NOT EXISTS `BH_Metadata`.`Biosample_Strain` (
  `Biosample` VARCHAR(40) NOT NULL,
  `Strain` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Biosample`, `Strain`),

  CONSTRAINT `fk_Biosample_has_Strain_Biosample1`
    FOREIGN KEY (Biosample) REFERENCES Biosample (Biosample)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Biosample_has_Strain_Strain1`
    FOREIGN KEY (Strain) REFERENCES Strain (Strain)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) ENGINE = Aria;

