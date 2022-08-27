use covid_report;
select * from Covid_Vaccinations;
select * from covid_deaths;
select * from covid_report..covid_deaths order by 3;


---Looking for total cases vs total death (and their Percentage)---

select location, cast(date as date) Date, total_cases, total_deaths,
(total_deaths / total_cases)*100 Death_percentage, population from covid_deaths
where location = 'india'
order by 1,2; 




---People who got affected by covid in India

---Created View
create view case1 as
select location, cast(date as date) Date, total_cases, total_deaths,
cast( (total_cases / population)*100 as decimal(5,3) ) Contracted_to_covid
,population from covid_deaths
where location = 'india'; 

---View

select * from case1 order by 1,2;



---Looking for countries with highest infection rate compared to population

select location, population, max(total_cases) Highest_case_perCountry, 
cast( max( total_cases/ population ) * 100 as decimal(4,2) ) Infected_population 
from covid_deaths
group by location, population 
order by Infected_population desc;




---Highest death count amoung all the countries

select location, max(cast(total_deaths as int)) death_cases from Covid_Deaths
where continent is not null
group by location 
order by death_cases desc;





--- Highest death count continent wise

select location, max(cast(total_deaths as int)) Total_deaths from covid_deaths
where continent is null
group by location 
order by total_deaths desc; 




----Global covid deaths
select  sum(new_cases) Total_cases, sum(cast(new_deaths as int)) Total_deaths,
sum(cast(new_deaths as int))/sum(new_cases) *100 as Death_percentage from covid_deaths
where continent is not null
order by 1,2;





/* Looking at total population vs vaccinations*/

/* Inserted into a temp table*/

select * into #temp from(
--- query
select a.continent, a.location, a.date, a.population, b.new_vaccinations,
sum(convert(bigint, b.new_vaccinations))  over(partition by a.location order 
by a.location, a.date) Total_vaccination
from covid_deaths a join covid_vaccinations b
on a.location = b.location and 
a.date = b.date where a.continent is not null)

 as s;
