-- Data Cleaning Project
-- 1. remove duplicates
-- 2. standardize data 
-- 3. null vales or blank vales
-- 4. remove any columns 

-- Creating a copy of the original table to preserve the raw data and avoid making direct changes
SELECT * 
FROM layoffs;

CREATE TABLE layoffs_stagging
LIKE layoffs;

SELECT * 
FROM layoflayoffs_staggingfs_stagging;

INSERT layoffs_stagging
SELECT *
FROM layoffs;


-- ---------------------------------------------------------------------------------------------------------------------
-- REMOVE DUPLICATES

SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company,industry, total_laid_off, percentage_laid_off,`date` ) AS row_num
FROM layoffs_stagging;


-- Note : i have now numbered all the duplicates as 2
-- Insight: i use ROW_NUMBER() OVER(PARTITION BY) because 


WITH dupilicates_CTE AS 
(
SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company,industry,location,
 total_laid_off, percentage_laid_off,`date`
 ,stage, country, funds_raised_millions ) AS row_num
FROM layoffs_stagging
)
SELECT * 
FROM dupilicates_CTE
WHERE row_num > 1;


-- Note: All the duplicates have retured because their labled as # 2 which is greater then 1
-- Insight : i use CTE 


CREATE TABLE `layoffs_stagging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Note : i created a new table ,then added `row_num` column to the `layoffs_stagging2` to count all the duplicates as 2 ad be able to delete all duplicates


SELECT *
FROM layoffs_stagging2;

INSERT INTO layoffs_stagging2
SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company,industry,location,
 total_laid_off, percentage_laid_off,`date`
 ,stage, country, funds_raised_millions ) AS row_num
FROM layoffs_stagging;


DELETE
FROM layoffs_stagging2
WHERE row_num >1;


-- Note: All Duplicates have now been deleted
-- Insight: I used ROW_NUMBER() OVER( PARTITION BY ) 



-- -----------------------------------------------------------------------------------------------------------------------------------


-- standarize data

SELECT *
FROM layoffs_stagging2;

SELECT company, TRIM(company)
FROM layoffs_stagging2;

UPDATE layoffs_stagging2
SET company = TRIM(company);
	
-- Note: The company name column had companies names all over the row mix-matched instead of uniformly correct
-- Insight: I use TRIM() to 


SELECT *
FROM layoffs_stagging2
WHERE industry like 'crypto%';

UPDATE layoffs_stagging2
SET industry = 'Crypto'
WHERE industry like 'crypto%';

-- Note : Not all `crypto` was spelled the same so i updated them all to match

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_stagging2
order by 1;

UPDATE layoffs_stagging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%' ;

-- Note: Now the single '.' is deleted from the end of 'United States' and all look uniforlly the same
-- Insight: I use TRIM(TRAILING) for removing the '.' at the end of 'United States'


SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_stagging2;

UPDATE layoffs_stagging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_stagging2
MODIFY COLUMN `date` DATE;

-- Note : i changed the `date` column from text to date format so ill have better query resuts
-- Insight: I use str_to_date() to turn the date into correct Month date and year format


-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove any Nulls

SELECT * 
FROM layoffs_stagging2;


SELECT * 
FROM layoffs_stagging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *  
FROM layoffs_stagging2
WHERE industry IS NULL
OR industry = '';

-- Note: Im looking for Null and Blank spaces


SELECT * 
FROM layoffs_stagging2
WHERE company LIKE '%airb%' ;

SELECT t2.industry, t3.industry
FROM layoffs_stagging2 t2
Join layoffs_stagging2 t3
	ON t2.company =t3.company
WHERE t2.industry IS NULL 
AND t3.industry IS NOT NULL;    
 
-- Insight : I self joined on the table with itself to fill null industry spaces with accurate data from maktching industry rows


UPDATE layoffs_stagging2 t2
JOIN layoffs_stagging2 t3
	ON t2.company =t3.company
SET t2.industry = t3.industry
WHERE t2.industry IS NULL 
AND t3.industry IS NOT NULL;    
 
 -- Note : All Null spaces have now been updated with matching information 
 
 
UPDATE layoffs_stagging2
SET industry = NULL 
WHERE industry = ''; 
 
 -- Note: Im setting all the remaing industry blank spaces to null psaces 
 
 
 SELECT *
 FROM layoffs_stagging2
 WHERE industry IS NULL ;
 
 SELECT * 
FROM layoffs_stagging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



DELETE 
FROM layoffs_stagging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Note: Any remaining null spaces that i dont have data for is now deleted from the table 


 SELECT * 
FROM layoffs_stagging2;

ALTER TABLE layoffs_stagging2
DROP COLUMN row_num;

-- Note: i deleted the `row_num` column  because their is no onger any duplicates
-- Insight: Drop column to drop the `row_num` i created for thr table 




































