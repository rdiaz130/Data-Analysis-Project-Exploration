-- Data Cleaning


 select *
 from layoffs;
 
 -- 1. Remove Duplicates 
 -- 2. Standardize the Data
 -- 3. Null Values or Blank Values
 -- 4. Remove any colums 
  
 
 Create Table layoffs_staging 
 like layoffs;
 
 select *
 from layoffs_staging; 
 
 insert layoffs_staging
 select *
 from layoffs;
 
 
  select *,
  row_number() over(
  partition by company, industry, total_laid_off, percentage_laid_off, 'date' ) as row_num
 from layoffs_staging;
 
 
with duplicate_cte as
(
select *,
  row_number() over(
  partition by company, location,
  industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
 from layoffs_staging
 )
 select *
 from duplicate_cte
 where row_num > 1;
 
 
with duplicate_cte as
(
select *,
  row_number() over(
  partition by company, location,
  industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
 from layoffs_staging
 )
delete
 from duplicate_cte
 where row_num > 1;
 
 

 
 
 
 
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 select *
 from layoffs_staging2
 where row_num > 1;
 
 
 insert into layoffs_staging2
 select *,
  row_number() over(
  partition by company, location,
  industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
 from layoffs_staging;
 
 
-- Standarzing Data

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);
 
 select *
from layoffs_staging2
where industry like 'crypto%' ;

update layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%' ;

select distinct country
from layoffs_staging2
order by 1;

select * 
from layoffs_staging2
where country like 'United States%'
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;


update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
STR_TO_DATE ( `date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = STR_TO_DATE ( `date`, '%m/%d/%Y');


alter table layoffs_staging2
modify column `date` date;




select * 
from layoffs_staging2
where total_laid_off is null;

select *
from layoffs_staging2
where industry is null
or industry = ' ';


select *
from layoffs_staging2
where company like 'Bally%';




select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;



delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;



-- Exploratory Data Analysis





select *
from layoffs_staging2;




