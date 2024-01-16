select * 
from dbo.CovidDeaths$
--WHERE location = 'Ethiopia'
ORDER BY 1,2

--total cases vs total death
SELECT  location, population, (total_deaths/total_cases) * 100 as DeathPercentage
from dbo.CovidDeaths$

--total cases vs population
SELECT location, population, total_cases, (total_cases / population ) * 100 as InfectedPop
FROM dbo.CovidDeaths$
order by InfectedPop desc

--countries with highest infection rate compared to population
SELECT continent,  MAX(CAST(total_cases as int)) as TotalDeaths,MAX(CAST(total_cases as int) / population ) * 100 as InfectedPop
FROM dbo.CovidDeaths$
WHERE continent is not null
GROUP BY continent
order by InfectedPop desc