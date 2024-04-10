SELECT continent, location, date, total_cases, new_cases, total_deaths, population, new_deaths
FROM Covid_deaths
WHERE continent IS NOT NULL
ORDER by 2, 3

-- Likelyhood of dying from Covid subjected to date in each country -- 

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathRateEachday
From Covid_deaths
Where location = 'Vietnam'
and continent is not null 
order by 1,2

-- Percentage of population (country) infected by Covid -- 

Select Location, date, population, total_cases, (total_cases/population)*100 as InfectedRate
From Covid_deaths
Where location = 'France'
order by 1,2

-- Countriest with highest infected rate --

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid_deaths
Group by Location, Population
order by PercentPopulationInfected desc


 -- Continent with highest death count --
 
Select continent, MAX(CAST(total_deaths as signed)) as TotalDeathCount
From Covid_deaths 
Group by continent
order by continent 

-- Global Change by every 7 days -- 

SELECT date, SUM(new_cases) as overall_cases, SUM(new_deaths) as overall_deaths, (SUM(new_deaths)/SUM(new_cases))*100 as DeathPercentage
From Covid_deaths 
Where new_cases <> 0 AND date <> '2020-01-05'
Group by date
ORDER By Date 

-- Total population vs. vaccination -- 

SELECT dea.continent, dea.location, dea.date, vac.new_vaccinations, dea.population
From Covid_deaths dea
Join Covid_vac vac
	On dea.location = vac.location AND dea.date = vac.date 
Order by dea.location, dea.date

-- Cumulative vaccination per day --
SELECT DISTINCT(dea.date), dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, (SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER by dea.date))/2 as VaccinePerDay
From Covid_deaths dea
Join Covid_vac vac
	On dea.location = vac.location AND dea.date = vac.date 
Order by dea.location, dea.date

-- Cumulative vaccination percentage per day -- 
WITH vac_per AS (
	SELECT DISTINCT(dea.date), dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, (SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER by dea.date))/2 as VaccinePerDay
	From Covid_deaths dea
		Join Covid_vac vac
		On dea.location = vac.location AND dea.date = vac.date 
        Order by dea.location, dea.datea)






