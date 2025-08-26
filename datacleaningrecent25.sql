-- Data Cleaning Recent

SELECT *
FROM layoff;

-- 1. Removing duplicates if any
-- 2. Standarized the data
-- 3. Removing null values
-- 4. Removing unnecesary rows and columns

-- I want to create a table exactly like layoff. As I don't want to change the raw data.
CREATE TABLE layoffs_staging
LIKE layoff;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoff;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date` ) As row_num
FROM layoffs_staging;

-- as I don't see any duplicates but for reassure I want to check if there are any duplicates

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised ) As row_num
FROM layoffs_staging
) 
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Here I got two company "Beyond Meat" and "Cazoo". And now I want to make sure is it really duplicate or not.
-- I got BEyond meat is duplicate one time 
-- Same for the other company

SELECT *
FROM layoffs_staging
WHERE company = 'Beyond Meat';

SELECT *
FROM layoffs_staging
WHERE company = 'Cazoo';

-- So I decided to remove the duplicates 
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised ) As row_num
FROM layoffs_staging
) 
DELETE
FROM duplicate_cte
WHERE row_num > 1; -- it is not working then let's create another staging table


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `date_added` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_staging2;


INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised ) As row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num >1;

DELETE
FROM layoffs_staging2
WHERE row_num >1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- finally we removed the duplicate company

-- 2. Standarized the data

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT *
FROM layoffs_staging2;

SELECT DISTINCT industry
FROM layoffs_staging2;-- everything seems ok but an empty value will clean it later stage

SELECT DISTINCT country
FROM layoffs_staging2; -- everything seems fine but an empty value huh

SELECT `date`
FROM layoffs_staging2;-- it is in text format but I want it as a date format 

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
OR percentage_laid_off = ''; -- want to delete where it's empty 

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''; -- just two company that don't have specific industry I just want to delete it

SELECT *
FROM layoffs_staging2
WHERE company = 'Appsmith';


SELECT *
FROM layoffs_staging2
WHERE company like 'Eye%';

SELECT distinct industry
FROM layoffs_staging2
WHERE industry = '';

DELETE
FROM layoffs_staging2
WHERE industry = '';

SELECT DISTINCT country
FROM layoffs_staging2
WHERE country = 'Israel';

DELETE
FROM layoffs_staging2
WHERE country = 'Israel'; 

SELECT DISTINCT country
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2;

SELECT total_laid_off, REPLACE(total_laid_off, '.0', '') AS new_value
FROM layoffs_staging2 
WHERE total_laid_off LIKE '%.0';

UPDATE layoffs_staging2 
SET total_laid_off = REPLACE(total_laid_off, '.0', '') 
WHERE total_laid_off LIKE '%.0';

SELECT funds_raised, REPLACE(funds_raised, '$', '') AS new_value
FROM layoffs_staging2
WHERE funds_raised LIKE '$%';

UPDATE layoffs_staging2 
SET funds_raised = REPLACE(funds_raised, '$', '') 
WHERE funds_raised LIKE '$%';

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT total_laid_off, 
       CAST(total_laid_off AS UNSIGNED INTEGER) AS converted_value
FROM layoffs_staging2 
WHERE total_laid_off IS NOT NULL AND total_laid_off != ''
LIMIT 10;

UPDATE layoffs_staging2 
SET total_laid_off = NULL 
WHERE total_laid_off = '' OR total_laid_off NOT REGEXP '^[0-9]+$';

ALTER TABLE layoffs_staging2 
MODIFY COLUMN total_laid_off INT;



