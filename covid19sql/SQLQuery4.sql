SELECT * 
FROM Covid19projects..covid_deaths
order by 3,4;

-- SELECT * 
-- FROM Covid19projects..covid_vac
-- order by 3,4; Where continent is not null 

Select Location, date, total_cases, new_cases, total_deaths, population
From Covid19projects..covid_deaths
order by 1,2;


Select Location, date, total_cases,total_deaths, (total_deaths * 100.0/ NULLIF(total_cases, 0)) as DeathPercentage
From Covid19projects..covid_deaths
WHERE Location = 'Germany'
order by Location;

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Covid19projects..covid_deaths
--Where location like '%states%'
order by 1,2;

-- top 5 countries with highest infection count
Select TOP 5 WITH TIES Location,  MAX(total_cases) as HighestInfectedcount
From Covid19projects..covid_deaths
Where continent is not null 
Group by location
order by HighestInfectedcount DESC;

-- top 5 countries with highest vaccination count
Select TOP 5 WITH TIES Location,  MAX(cast(total_vaccinations as Bigint)) as HighestVaccination
From Covid19projects..covid_vac
Where continent is not null 
Group by location
order by HighestVaccination DESC;

-- top 5 countries with highest death count
Select TOP 5 WITH TIES Location,  MAX(total_deaths) as HighestDeath
From Covid19projects..covid_deaths
Where continent is not null 
Group by location
order by HighestDeath DESC;

--Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as HighestInfectedrate,  MAX((total_cases/population))*100 as PercentPopulationInfected
From Covid19projects..covid_deaths
--WHERE Location like 'Bang%'
Group by location, population
order by PercentPopulationInfected DESC;

-- Countries with Highest Death Count per Population
Select Location, Population, MAX(total_deaths) as HighestDeathrate,  MAX((total_deaths/population))*100 as PercentPopulationDeath
From Covid19projects..covid_deaths
--WHERE Location like 'Bang%'
Group by location, population
order by PercentPopulationDeath DESC;

-- Highest absolute death count (total numbers).

Select Location, MAX(total_deaths) as TotalDeathcount
From Covid19projects..covid_deaths
-- WHERE Location like 'Bang%'
Where continent is not null 
Group by location
order by TotalDeathcount DESC;

-- Showing contintents with the highest death count 

Select Continent, MAX(total_deaths) as HighestDeathcount
From Covid19projects..covid_deaths
Where continent is not null 
Group by continent
order by HighestDeathcount DESC;

Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
From Covid19projects..covid_deaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2;


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,
SUM(convert(int, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) AS RollingPeopleVaccinated
--,(RollingPeopleVaccinated/dea.population)*100 As RollingPerpopulation
FROM Covid19projects..covid_deaths dea
JOIN Covid19projects..covid_vac vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null
ORDER by 2,3;

With PopVsVac (Continent, Location, Date, Population,New_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,
SUM(convert(int, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) AS RollingPeopleVaccinated
--,(RollingPeopleVaccinated/dea.population)*100 As RollingPerpopulation
FROM Covid19projects..covid_deaths dea
JOIN Covid19projects..covid_vac vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null
--ORDER by 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100 RollingPerPopulation
FROM PopVsVac;

