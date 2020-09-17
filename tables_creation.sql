
CREATE TABLE dim_grantee (
	grantee_id INT PRIMARY KEY NOT NULL,
	name varchar(300) NOT NULL
);

CREATE TABLE dim_granttopic (
	topic_id INT PRIMARY KEY NOT NULL,
	topic VARCHAR(100) NOT NULL
);

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
