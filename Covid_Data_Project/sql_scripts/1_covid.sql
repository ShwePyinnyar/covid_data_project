-- checking
select * from covid_deaths;

-- Preparing the data to convert them to correct type.
SET SQL_SAFE_UPDATES = 0;
UPDATE covid_deaths
SET
    total_cases = NULLIF(total_cases, ''),
    new_cases = NULLIF(new_cases, ''),
    new_cases_smoothed = NULLIF(new_cases_smoothed, ''),
    total_deaths = NULLIF(total_deaths, ''),
    new_deaths = NULLIF(new_deaths, ''),
    new_deaths_smoothed = NULLIF(new_deaths_smoothed, ''),
    total_cases_per_million = NULLIF(total_cases_per_million, ''),
    new_cases_per_million = NULLIF(new_cases_per_million, ''),
    new_cases_smoothed_per_million = NULLIF(new_cases_smoothed_per_million, ''),
    total_deaths_per_million = NULLIF(total_deaths_per_million, ''),
    new_deaths_per_million = NULLIF(new_deaths_per_million, ''),
    new_deaths_smoothed_per_million = NULLIF(new_deaths_smoothed_per_million, ''),
    reproduction_rate = NULLIF(reproduction_rate, ''),
    icu_patients = NULLIF(icu_patients, ''),
    icu_patients_per_million = NULLIF(icu_patients_per_million, ''),
    hosp_patients = NULLIF(hosp_patients, ''),
    hosp_patients_per_million = NULLIF(hosp_patients_per_million, ''),
    weekly_icu_admissions = NULLIF(weekly_icu_admissions, ''),
    weekly_icu_admissions_per_million = NULLIF(weekly_icu_admissions_per_million, ''),
    weekly_hosp_admissions = NULLIF(weekly_hosp_admissions, ''),
    weekly_hosp_admissions_per_million = NULLIF(weekly_hosp_admissions_per_million, '');

    
SET SQL_SAFE_UPDATES = 1;

-- Converting them to correct type
ALTER TABLE covid_deaths
MODIFY population INT,
MODIFY date DATETIME,
MODIFY total_cases INT,
MODIFY new_cases INT,
MODIFY new_cases_smoothed DOUBLE,
MODIFY total_deaths INT,
MODIFY new_deaths INT,
MODIFY new_deaths_smoothed DOUBLE,
MODIFY total_cases_per_million DOUBLE,
MODIFY new_cases_per_million DOUBLE,
MODIFY new_cases_smoothed_per_million DOUBLE,
MODIFY total_deaths_per_million DOUBLE,
MODIFY new_deaths_per_million DOUBLE,
MODIFY new_deaths_smoothed_per_million DOUBLE,
MODIFY reproduction_rate DOUBLE,
MODIFY icu_patients INT,
MODIFY icu_patients_per_million DOUBLE,
MODIFY hosp_patients INT,
MODIFY hosp_patients_per_million DOUBLE,
MODIFY weekly_icu_admissions INT,
MODIFY weekly_icu_admissions_per_million DOUBLE,
MODIFY weekly_hosp_admissions INT,
MODIFY weekly_hosp_admissions_per_million DOUBLE;

select icu_patients
from covid_deaths
where icu_patients is not null;

-- Percentage of people infected per country. Sorted by highest total case.
select location, population,max(total_cases) as total, max(total_cases)/population*100 as infection_perc
from covid_deaths
where continent is not null
group by location, population
order by  total desc,infection_perc desc;

-- Total deaths by continent
select continent, max(total_deaths) as deaths
from covid_deaths
where continent <> "world"
group by continent
order by deaths desc;

select location, max(total_deaths) as deaths
from covid_deaths
where continent is null and location <> "world"
group by location
order by deaths desc;

-- Total deaths by country
select location, max(total_deaths) as deaths
from covid_deaths
where continent is not null
group by location
order by deaths desc;

-- Death Percentage for the infected per country
select location, max(total_cases) as infected_num, max(total_deaths) as death_num, max(total_deaths)/max(total_cases)*100 as death_perc
from covid_deaths
where continent is not null
group by location
order by death_num desc;

-- New infected and death trend over time
select date, sum(new_cases) as daily_case, sum(new_deaths) as daily_death, sum(new_deaths)/sum(new_cases) *100 as daily_death_perc
from covid_deaths
group by date
order by date;

-- Total infected and death trend over time
select date, sum(total_cases) as daily_case, sum(total_deaths) as daily_death, sum(total_deaths)/sum(total_cases) *100 as daily_death_perc
from covid_deaths
where continent is not null
group by date
order by date;

-- combination
select * from covid_deaths;

-- --------------------------------------- to use later
-- from covid_deaths d
-- join covid_vaccinations v
-- on d.location = v.location and d.date=v.date and d.loc_code=v.loc_code;
-- ---------------------------------------

select * from covid_vaccinations;

-- correcting covid_vaccinations data types
    SET SQL_SAFE_UPDATES = 0;
UPDATE covid_vaccinations
SET
    new_tests = NULLIF(new_tests, ''),
    total_tests = NULLIF(total_tests, ''),
    total_tests_per_thousand = NULLIF(total_tests_per_thousand, ''),
    new_tests_per_thousand = NULLIF(new_tests_per_thousand, ''),
    new_tests_smoothed = NULLIF(new_tests_smoothed, ''),
    new_tests_smoothed_per_thousand = NULLIF(new_tests_smoothed_per_thousand, ''),
    positive_rate = NULLIF(positive_rate, ''),
    tests_per_case = NULLIF(tests_per_case, ''),
    total_vaccinations = NULLIF(total_vaccinations, ''),
    people_vaccinated = NULLIF(people_vaccinated, ''),
    people_fully_vaccinated = NULLIF(people_fully_vaccinated, ''),
    new_vaccinations = NULLIF(new_vaccinations, ''),
    new_vaccinations_smoothed = NULLIF(new_vaccinations_smoothed, ''),
    total_vaccinations_per_hundred = NULLIF(total_vaccinations_per_hundred, ''),
    people_vaccinated_per_hundred = NULLIF(people_vaccinated_per_hundred, ''),
    people_fully_vaccinated_per_hundred = NULLIF(people_fully_vaccinated_per_hundred, ''),
    new_vaccinations_smoothed_per_million = NULLIF(new_vaccinations_smoothed_per_million, ''),
    extreme_poverty = NULLIF(extreme_poverty, ''),
    female_smokers = NULLIF(female_smokers, ''),
    male_smokers = NULLIF(male_smokers, '');
    

    ALTER TABLE covid_vaccinations

MODIFY ï»¿iso_code text,
MODIFY continent text,
MODIFY location text,

MODIFY new_tests BIGINT,
MODIFY total_tests BIGINT,
MODIFY total_tests_per_thousand DOUBLE,
MODIFY new_tests_per_thousand DOUBLE,
MODIFY new_tests_smoothed DOUBLE,
MODIFY new_tests_smoothed_per_thousand DOUBLE,
MODIFY positive_rate DOUBLE,
MODIFY tests_per_case DOUBLE,

MODIFY total_vaccinations BIGINT,
MODIFY people_vaccinated BIGINT,
MODIFY people_fully_vaccinated BIGINT,
MODIFY new_vaccinations BIGINT,
MODIFY new_vaccinations_smoothed DOUBLE,

MODIFY total_vaccinations_per_hundred DOUBLE,
MODIFY people_vaccinated_per_hundred DOUBLE,
MODIFY people_fully_vaccinated_per_hundred DOUBLE,
MODIFY new_vaccinations_smoothed_per_million DOUBLE,

MODIFY extreme_poverty DOUBLE,
MODIFY female_smokers DOUBLE,
MODIFY male_smokers DOUBLE;
SET SQL_SAFE_UPDATES = 1;

select *
from covid_vaccinations;


-- Percentage of people who vaccinate per country
-- This has too many missing data
select v.location, d.population, v.people_vaccinated, v.people_vaccinated/d.population as vac_perc
from covid_deaths d
join covid_vaccinations v
on d.loc_code = v.loc_code and d.date=v.date
where v.continent is not null
group by location;

   
-- Creating indexes to reduce run time
-- Modifying types as it was too big to be indexed
ALTER TABLE covid_deaths
MODIFY loc_code VARCHAR(10);
ALTER TABLE covid_vaccinations
MODIFY loc_code VARCHAR(10);

CREATE INDEX idx_deaths_code_date
ON covid_deaths (loc_code, date);

DESCRIBE covid_vaccinations;

CREATE INDEX idx_vax_code_date
ON covid_vaccinations (loc_code, date);

-- to check the correlation between infection, death and handwashing facilities
select d.location, max(d.total_cases) as infected, max(d.total_deaths) as deaths, max(v.handwashing_facilities) as handwashing_places
from covid_deaths d
join covid_vaccinations v
on d.location = v.location and d.date = v.date
where v.continent is not null
group by d.location;

-- to create view
create view disease_data as
select continent, location, population,max(total_cases) as infected, max(total_deaths) as deaths
from covid_deaths
where continent is not null
group by continent, location, population
order by location;

-- to practice rolling total 
-- daily rolling total of infected per country
create view daily_infection as
select location, date, coalesce(new_cases,0) as newly_infected, coalesce(sum(new_cases) over (partition by location order by date rows between unbounded preceding and current row),0) as rolling_total_infected
from covid_deaths
where continent is not null;

create view daily_dead as
select location, date, coalesce(new_deaths,0) as new_dead, coalesce(sum(new_deaths) over (partition by location order by date rows between unbounded preceding and current row),0) as rolling_total_dead
from covid_deaths
where continent is not null;
 












