-- Exploratory Data Anaysis


select *
from layoffs_staging2;



select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;


select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;

select country, sum(total_laid_off)
from layoffs_staging2
group by country 
order by 2 desc;


select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`) 
order by 2 desc;


select company, sum(percentage_laid_off)
from layoffs_staging2
group by company
order by 1 desc;

select SUBSTRING(`date`,6,2) as `month`
from layoffs_staging2;


with rolling_total as
(
select SUBSTRING(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off
,sum(total_off) over(order by `month`) as rolling_total
from rolling_total;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select company, year(`date`),  sum(total_laid_off)
from layoffs_staging2
group by company, year( `date`)
order by 3 desc;



with company_year (company, years, total_laid_off) as
(
select company, year(`date`),  sum(total_laid_off)
from layoffs_staging2
group by company, year( `date`)
)
select *, dense_rank() over (partition by years order by total_laid_off desc) as Ranking
from company_year 
order by ranking asc
;








