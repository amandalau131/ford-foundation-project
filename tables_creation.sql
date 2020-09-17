-- Creation of the grantee table
CREATE TABLE dim_grantee (
	grantee_id INT PRIMARY KEY NOT NULL,
	name varchar(300) NOT NULL
);

-- Creation of the grant topic table 
CREATE TABLE dim_granttopic (
	topic_id INT PRIMARY KEY NOT NULL,
	topic VARCHAR(100) NOT NULL
);

-- Creation of the grants table
CREATE TABLE fact_grants (
	grant_id INT PRIMARY KEY NOT NULL,
	description TEXT,
	amount NUMERIC NOT NULL,
	region VARCHAR(100),
	start_date INT REFERENCES dim_date (date_id),
	end_date INT REFERENCES dim_date (date_id),
	topic_id INT REFERENCES dim_granttopic (topic_id),
	grantee_id INT REFERENCES dim_grantee (grantee_id)
);

-- Creation of the date table which the code was sourced from a Medium article - link in README
CREATE TABLE dim_date
(
  date_id                  INT PRIMARY KEY NOT NULL,
  date_actual              DATE NOT NULL,
  epoch                    BIGINT NOT NULL,
  day_suffix               VARCHAR(4) NOT NULL,
  day_name                 VARCHAR(9) NOT NULL,
  day_of_week              INT NOT NULL,
  day_of_month             INT NOT NULL,
  day_of_quarter           INT NOT NULL,
  day_of_year              INT NOT NULL,
  week_of_month            INT NOT NULL,
  week_of_year             INT NOT NULL,
  week_of_year_iso         CHAR(10) NOT NULL,
  month_actual             INT NOT NULL,
  month_name               VARCHAR(9) NOT NULL,
  month_name_abbreviated   CHAR(3) NOT NULL,
  quarter_actual           INT NOT NULL,
  quarter_name             VARCHAR(9) NOT NULL,
  year_actual              INT NOT NULL,
  first_day_of_week        DATE NOT NULL,
  last_day_of_week         DATE NOT NULL,
  first_day_of_month       DATE NOT NULL,
  last_day_of_month        DATE NOT NULL,
  first_day_of_quarter     DATE NOT NULL,
  last_day_of_quarter      DATE NOT NULL,
  first_day_of_year        DATE NOT NULL,
  last_day_of_year         DATE NOT NULL,
  mmyyyy                   CHAR(6) NOT NULL,
  mmddyyyy                 CHAR(10) NOT NULL,
  weekend_indr             BOOLEAN NOT NULL
);
