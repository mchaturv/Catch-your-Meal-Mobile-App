-- MySQL Script generated by MySQL Workbench
-- Thu Feb 27 17:35:52 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CatchYourMeal
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CatchYourMeal
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CatchYourMeal` DEFAULT CHARACTER SET utf8 ;
USE `CatchYourMeal` ;

-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Address` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Address` (
  `AddressId` INT NOT NULL,
  `SuiteNo` VARCHAR(255) NULL,
  `ApartmentNumber` VARCHAR(32) NOT NULL,
  `StreetName` VARCHAR(40) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `City` VARCHAR(45) NOT NULL,
  `Province` VARCHAR(45) NULL,
  `Zip` VARCHAR(6) NOT NULL,
  `Country` VARCHAR(45) NULL,
  PRIMARY KEY (`AddressId`));


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Category` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Category` (
  `CategoryId` INT NOT NULL,
  `CategoryName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CategoryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Cuisine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Cuisine` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Cuisine` (
  `cuisine_id` INT NOT NULL,
  `cuisine_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cuisine_id`));


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Food`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Food` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Food` (
  `FoodId` INT NOT NULL,
  `FoodName` VARCHAR(45) NOT NULL,
  `FoodDescription` VARCHAR(45) NOT NULL,
  `FoodPrice` INT NOT NULL,
  PRIMARY KEY (`FoodId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Food_Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Food_Category` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Food_Category` (
  `FoodId` INT NOT NULL,
  `CategoryId` INT NOT NULL,
  INDEX `CategoryId_idx` (`CategoryId` ASC) VISIBLE,
  CONSTRAINT `FoodId`
    FOREIGN KEY (`FoodId`)
    REFERENCES `CatchYourMeal`.`Food` (`FoodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CategoryId`
    FOREIGN KEY (`CategoryId`)
    REFERENCES `CatchYourMeal`.`Category` (`CategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Food_Ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Food_Ingredients` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Food_Ingredients` (
  `IngredientId` INT NOT NULL,
  `FoodId` INT NOT NULL,
  `Quantity` INT NOT NULL,
  INDEX `IngredientId_idx` (`IngredientId` ASC) VISIBLE,
  INDEX `FoodId_idx` (`FoodId` ASC) VISIBLE,
  CONSTRAINT `IngredientId`
    FOREIGN KEY (`IngredientId`)
    REFERENCES `CatchYourMeal`.`Ingredients` (`IngredientsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FoodId`
    FOREIGN KEY (`FoodId`)
    REFERENCES `CatchYourMeal`.`Food` (`FoodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Food_cuisine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Food_cuisine` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Food_cuisine` (
  `cuisineId` INT NOT NULL,
  `foodId` INT NOT NULL,
  INDEX `foodId_idx` (`foodId` ASC) VISIBLE,
  CONSTRAINT `cuisineId`
    FOREIGN KEY (`cuisineId`)
    REFERENCES `CatchYourMeal`.`Cuisine` (`cuisine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `foodId`
    FOREIGN KEY (`foodId`)
    REFERENCES `CatchYourMeal`.`Food` (`FoodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Ingredients` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Ingredients` (
  `IngredientsId` INT NOT NULL,
  `IndgredientName` VARCHAR(45) NOT NULL,
  `IngredientType` VARCHAR(45) NOT NULL,
  `IngredientPricePerUnit` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IngredientsId`),
  UNIQUE INDEX `IngredientsId_UNIQUE` (`IngredientsId` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Meal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Meal` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Meal` (
  `MealId` INT NOT NULL,
  `MealName` VARCHAR(45) NOT NULL,
  `MealDescription` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MealId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Meal_Food`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Meal_Food` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Meal_Food` (
  `MealID` INT NOT NULL,
  `FoodID` INT NOT NULL,
  `quantity` INT NULL,
  INDEX `MealId_idx` (`MealID` ASC) VISIBLE,
  INDEX `FoodId_idx` (`FoodID` ASC) VISIBLE,
  CONSTRAINT `MealId`
    FOREIGN KEY (`MealID`)
    REFERENCES `CatchYourMeal`.`Meal` (`MealId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FoodId`
    FOREIGN KEY (`FoodID`)
    REFERENCES `CatchYourMeal`.`Food` (`FoodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Order` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Order` (
  `orderId` INT NOT NULL,
  `userId` VARCHAR(40) NOT NULL,
  `price` FLOAT NOT NULL,
  `orderDateandTime` DATETIME NOT NULL,
  `orderStatus` VARCHAR(45) NOT NULL,
  `orderComments` VARCHAR(45) NOT NULL,
  `DeliveryDateandTime` DATETIME NOT NULL,
  PRIMARY KEY (`orderId`, `userId`),
  INDEX `userId_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `userId`
    FOREIGN KEY (`userId`)
    REFERENCES `CatchYourMeal`.`user` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`OrderDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`OrderDetails` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`OrderDetails` (
  `orderId` INT NOT NULL,
  `mealId` INT NOT NULL,
  `foodId` INT NOT NULL,
  `Quantity` FLOAT NULL,
  INDEX `orderId_idx` (`orderId` ASC) VISIBLE,
  INDEX `mealId_idx` (`mealId` ASC) VISIBLE,
  INDEX `foodId_idx` (`foodId` ASC) VISIBLE,
  CONSTRAINT `orderId`
    FOREIGN KEY (`orderId`)
    REFERENCES `CatchYourMeal`.`Order` (`orderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mealId`
    FOREIGN KEY (`mealId`)
    REFERENCES `CatchYourMeal`.`Meal` (`MealId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `foodId`
    FOREIGN KEY (`foodId`)
    REFERENCES `CatchYourMeal`.`Food` (`FoodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`Users_Favourite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`Users_Favourite` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`Users_Favourite` (
  `userId` VARCHAR(45) NOT NULL,
  `mealId` INT NOT NULL,
  INDEX `userId_idx` (`userId` ASC) VISIBLE,
  INDEX `mealId_idx` (`mealId` ASC) VISIBLE,
  CONSTRAINT `userId`
    FOREIGN KEY (`userId`)
    REFERENCES `CatchYourMeal`.`user` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mealId`
    FOREIGN KEY (`mealId`)
    REFERENCES `CatchYourMeal`.`Meal` (`MealId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `CatchYourMeal`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CatchYourMeal`.`user` ;

CREATE TABLE IF NOT EXISTS `CatchYourMeal`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `phone` VARCHAR(45) NULL,
  `savedAddress1` INT NULL,
  `savedAddress2` INT NULL,
  INDEX `savedAddressId_idx` (`savedAddress1` ASC) VISIBLE,
  INDEX `savedAddressId2_idx` (`savedAddress2` ASC) VISIBLE,
  PRIMARY KEY (`username`),
  CONSTRAINT `savedAddressId1`
    FOREIGN KEY (`savedAddress1`)
    REFERENCES `CatchYourMeal`.`Address` (`AddressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `savedAddressId2`
    FOREIGN KEY (`savedAddress2`)
    REFERENCES `CatchYourMeal`.`Address` (`AddressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
