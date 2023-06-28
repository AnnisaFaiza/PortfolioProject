SELECT *
FROM CovidDeaths
ORDER BY 3,4

--SELECT *
--FROM CovidVaccinations
--ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1,2

-- Total cases vs total deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE location LIKE '%Indonesia%'
ORDER BY 1,2

--Total cases vs Population
--Shows what percentage of population got covid

SELECT location, date, total_cases, population, (total_cases/population)*100 AS PopulationPercentage
FROM CovidDeaths
WHERE location LIKE '%Indonesia%'
ORDER BY 1,2

-- Country with highest infection rate compared to population

SELECT location, population,  MAX(total_cases) HighestInfectionCount, MAX((total_cases/population))*100 AS PopulationInfectedPercentage
FROM CovidDeaths
GROUP BY location, population
ORDER BY PopulationInfectedPercentage DESC

--Country with highest death count per population

SELECT location, MAX(CAST(total_deaths AS int)) TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY TotalDeathCount DESC

--PER CONTINENT

-- Continent with Highest death count per population

SELECT continent, MAX(CAST(total_deaths AS int)) TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- GLOBAL NUMBERS

SELECT SUM(new_cases) total_cases, SUM(cast(new_deaths AS INT)) total_deaths, SUM(cast(new_deaths AS INT)) /SUM(new_cases)*100 AS DeathPercentage
FROM CovidDeaths
--WHERE location LIKE '%Indonesia%'
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2


-- Looking at Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


--USING TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated


--CREATING VIEW TO STORE DATA FOR VISUALIZATIONS

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

CREATE VIEW GlobalDeathPopulation AS
SELECT SUM(new_cases) total_cases, SUM(cast(new_deaths AS INT)) total_deaths, SUM(cast(new_deaths AS INT)) /SUM(new_cases)*100 AS DeathPercentage
FROM CovidDeaths
--WHERE location LIKE '%Indonesia%'
WHERE continent IS NOT NULL
--GROUP BY date
--ORDER BY 1,2
