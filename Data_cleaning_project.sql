--            Data Cleaning Project

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
FROM layoflayoffs_stagging;

-- Inserting all records into the staging table
INSERT layoffs_stagging
SELECT *
FROM layoffs;



-- SQL Logic Summary: Created a staging table (layoffs_stagging) to preserve the original dataset.
--      Used ROW_NUMBER() with PARTITION BY on relevant columns to detect duplicates.
--      Inserted records with row numbers into a new table (layoffs_stagging2).
--      Deleted all rows with row_num > 1, keeping only one record per duplicate group.

-- Insights for Stakeholders: Data accuracy improved: All duplicate layoff records have been systematically removed, ensuring accurate headcount analysis.
--     More reliable reporting: Clean data prevents inflated figures that could mislead trend or impact assessments.




-- ---------------------------------------------------------------------------------------------------------------------
-- Duplicate Records Removal

SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY company,industry, total_laid_off, percentage_laid_off,`date` ) AS row_num
FROM layoffs_stagging;


-- Note : Identifying duplicate rows based on all relevant columns


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


-- Insight : i use CTE to Select duplicate records 
-- Note: All the duplicates have retured because their labled as # 2 


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

-- Note : Creating a new table with an additional 'row_num' column to manage duplicates



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


-- SQL Logic Summary: Created a staging table (layoffs_stagging) to preserve the original dataset.
--       Used ROW_NUMBER() with PARTITION BY on relevant columns to detect duplicates.
--       Inserted records with row numbers into a new table (layoffs_stagging2).
--       Deleted all rows with row_num > 1, keeping only one record per duplicate group.

-- Insights for Stakeholders:Data accuracy improved: All duplicate layoff records have been systematically removed, ensuring accurate headcount analysis.
--       More reliable reporting: Clean data prevents inflated figures that could mislead trend or impact assessments.





-- -----------------------------------------------------------------------------------------------------------------------------------


-- standarize data

SELECT *
FROM layoffs_stagging2;

SELECT company, TRIM(company)
FROM layoffs_stagging2;

UPDATE layoffs_stagging2
SET company = TRIM(company);
	
-- Note: Removing leading and trailing spaces from company names


SELECT *
FROM layoffs_stagging2
WHERE industry like 'crypto%';

UPDATE layoffs_stagging2
SET industry = 'Crypto'
WHERE industry like 'crypto%';

-- Note :Standardizing industry names (e.g., various forms of "crypto")

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_stagging2
order by 1;

UPDATE layoffs_stagging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%' ;

-- Note: Standardizing country names (removing trailing punctuation)


SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_stagging2;

UPDATE layoffs_stagging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_stagging2
MODIFY COLUMN `date` DATE;

-- Note :  Converting date from string to proper DATE format
-- Note: Changing the data type of the date column to DATE
-- Insight:Used TRIM() and STR_TO_DATE() functions to clean and normalize text fields and properly format dates for improved querying and consistency.



-- SQL Logic Summary: Trimmed leading/trailing spaces in the company field.
--      Standardized inconsistent industry labels like "crypto" → "Crypto".
--      Removed punctuation from country names (e.g., "United States.").
--      Converted date column from text to SQL DATE format for proper time-based analysis.
-- Insights for Stakeholders: Improved consistency across company, industry, and location fields ensures cleaner segmentation and filtering.
--      Time-series readiness: Standard date format allows for chronological insights and trend analysis.
--      Better grouping for analysis: Standardized labels improve dashboards and category-based KPIs.




-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove any Nulls

SELECT * 
FROM layoffs_stagging2;


SELECT * 
FROM layoffs_stagging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Note: Identifying rows where both key layoff fields are NULL

SELECT *  
FROM layoffs_stagging2
WHERE industry IS NULL
OR industry = '';

-- Note: Finding rows with missing or blank industry values


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
 
 -- Note : Filling missing industry values using self-join logic
 -- Insight: Used self-joins to intelligently populate missing industry values. Removed rows that provided no meaningful data.
 
 
UPDATE layoffs_stagging2
SET industry = NULL 
WHERE industry = ''; 
 
 -- Note: Converting empty strings in industry to NULL for consistency
 
 
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

-- Note: Deleting rows with completely missing layoff data 


-- SQL Logic Summary: Identified rows where key fields (total_laid_off, percentage_laid_off, industry) were null or blank.
--       Used a self-join to fill missing industry data based on the company name.
--       Removed rows with missing values that had no useful layoff information.
--       Cleaned empty strings in the industry column by converting them to null for consistency.
-- Insights for Stakeholders: Enhanced data quality: Critical gaps in the dataset were filled or removed to ensure integrity in business reporting.
--       Intelligent data recovery: Missing values were replaced using related data instead of being discarded, minimizing information loss.
--       Prepared for modeling & analytics: Clean dataset supports reliable analysis of layoff trends by industry, geography, and company.

-- ---------------------------------------------------------------------------------------------

-- Final Cleanup


SELECT * 
FROM layoffs_stagging2;

ALTER TABLE layoffs_stagging2
DROP COLUMN row_num;

-- Note: Dropping the row_num column now that duplicates have been removed
-- Insight: Cleaned up intermediate columns after completing deduplication.


-- SQL Logic Summary: Removed the helper column row_num after deduplication was completed.

-- Insights for Stakeholders: Lean dataset: Final table is optimized and free of technical helper columns, ready for visualization or further analysis.
--        Professional-grade preprocessing: Ensures the dataset is suitable for stakeholder dashboards or predictive modeling.











































