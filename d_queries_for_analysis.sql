-- Overall total funding and total number of grants made from 2013 - 2020
select 
	count(*) as total_grants,
	sum(amount) as total_funding
from fact_grants fgrants
inner join dim_date ddate
on fgrants.start_date = ddate.date_id
where fiscal_year >= 2013 and fiscal_year <= 2020;
 
-- Total funding per year from 2013 - 2020
select 
	fiscal_year ,
	sum(amount) as total_funding
from fact_grants fgrants
inner join dim_date ddate
on fgrants.start_date = ddate.date_id
where fiscal_year >= 2013 and fiscal_year <= 2020
group by fiscal_year
order by fiscal_year;
 
-- Top 25 grantees of the largest grants that were made from 2013 - 2020
select 
	dgrantee.name as grantee,
	fgrants.amount as grant_amount,
	fgrants.description as grant_description
from fact_grants fgrants
inner join dim_date ddate
	on fgrants.start_date = ddate.date_id
inner join dim_grantee dgrantee
	on  fgrants.grantee_id = dgrantee.grantee_id
where fiscal_year >= 2013 and fiscal_year <= 2020
order by fgrants.amount desc
limit 25;

-- Top 25 grantees that received the most number grants from 2013 - 2020
-- as some grantees would receive multiple grants 
select 
	dgrantee.name as grantee,
	count(dgrantee.name) as total_grants_given,
	sum(fgrants.amount) as total_funding
from fact_grants fgrants
inner join dim_date ddate
	on fgrants.start_date = ddate.date_id
inner join dim_grantee dgrantee
	on  fgrants.grantee_id = dgrantee.grantee_id
where fiscal_year >= 2013 and fiscal_year <= 2020
group by grantee
order by total_grants_given desc
limit 25;

-- Total funding, number of grants, and average grant amount by region from 2013- 2020
select 
	sub.region, 
	count(sub.amount) as number_of_grants,
	sum(sub.amount) as total_funding_region,
	round(sub.average_funding,2) as average_funding
from (
	select 
		fgrants.region,
		fgrants.amount,
		avg(fgrants.amount) over (partition by fgrants.region) as average_funding
	from fact_grants fgrants
	inner join dim_date ddate
		on fgrants.start_date = ddate.date_id
	inner join dim_grantee dgrantee
		on  fgrants.grantee_id = dgrantee.grantee_id
	where fiscal_year >= 2013 and fiscal_year <= 2020
) sub
group by sub.region,sub.average_funding
order by total_funding_region asc;
 
-- Total funding, number of grants, and average grant amount by topic (social cause) from 2013- 2020
select 
	sub2.topic,
	count(sub2.amount) as number_of_grants,
	sum(sub2.amount) as total_funding_topic,
	round(sub2.average_funding,2) as average_funding
from (
	select 
		dtopic.topic,
		fgrants.amount,
		avg(fgrants.amount) over (partition by dtopic.topic) as average_funding
	from fact_grants fgrants
	inner join dim_date ddate
		on fgrants.start_date = ddate.date_id
	inner join dim_granttopic dtopic
		on  fgrants.topic_id = dtopic.topic_id
	where fiscal_year >= 2013 and fiscal_year <= 2020
) sub2
group by sub2.topic,sub2.average_funding
order by total_funding_topic asc;
 
-- Number of grants made by grant size 2013-2020
select 
	sub3.amount_range as grant_size,
	count(sub3.amount_range) as number_of_grants
from (
	select 
	fgrants.amount,
	case 
		when fgrants.amount between 0 and 999 then 'under $1K'
		when fgrants.amount between 1000 and 5000 then '$1K - $5K'
		when fgrants.amount between 5001 and 10000 then '$5K - $10K'
		when fgrants.amount between 10001 and 25000 then '$10K - $25K'
		when fgrants.amount between 25001 and 50000 then '$25K - $50K'
		when fgrants.amount between 50001 and 100000 then '$50K - $100K'
		when fgrants.amount between 100001 and 250000 then '$100K - $250K'
		when fgrants.amount between 250001 and 500000 then '$250K - $500K'
		when fgrants.amount between 500001 and 1000000 then '$500K - $1M'
		when fgrants.amount between 1000001 and 5000000 THEN '$1M - $5M'
		when fgrants.amount between 5000001 and 10000000 THEN '$5M - $10M'
		when fgrants.amount between 10000001 and 25000000 THEN '$5M - $10M'
		when fgrants.amount between 25000001 and 50000000 THEN '$10M - $50M'
		when fgrants.amount between 50000001 and 100000000 THEN '$50M - $100M'
		else '$100M +'
	end as amount_range
	from fact_grants fgrants
	inner join dim_date ddate
		on fgrants.start_date = ddate.date_id
	inner join dim_grantee dgrantee
		on  fgrants.grantee_id = dgrantee.grantee_id
	where fiscal_year >= 2013 and fiscal_year <= 2020
) sub3
group by grant_size;
 
-- Overall total funding and total number of grants made in 2020
select 
	count(*) as total_grants,
	sum(amount) as total_funding,
	(round((sum(amount)/600000000),2)*100) as percentage_of_total_funding_goal
from fact_grants fgrants
inner join dim_date ddate
on fgrants.start_date = ddate.date_id
where fiscal_year = 2020;
 
-- Funding by quarter in 2020
select 
	'Q'||ddate.quarter_actual as FY_2020_Quarter,
	sum(amount) as "Total Funding"
from fact_grants fgrants
inner join dim_date ddate
on fgrants.start_date = ddate.date_id
where fiscal_year = 2020 
group by FY_2020_Quarter;

-- Top 25 grantees of the largest grants made in 2020 along with topic and description associated with the grant
select 
	dgrantee.name as grantee,
	fgrants.amount as grant_amount,
	dtopic.topic,
	fgrants.description as grant_description
from fact_grants fgrants
inner join dim_date ddate
	on fgrants.start_date = ddate.date_id
inner join dim_grantee dgrantee
	on  fgrants.grantee_id = dgrantee.grantee_id
inner join dim_granttopic dtopic
	On fgrants.topic_id = dtopic.topic_id
where fiscal_year = 2020
order by fgrants.amount desc
limit 25;

-- Funding made by region and funding per topic per region in 2020
select
	sub.region,
	sub.topic,
	sub.funding_topic,
	sum(sub.funding_topic) over (partition by sub.region) as funding_region,
	row_number () over (partition by sub.region order by sub.funding_topic) as rank_funding_topic
from (
	select 
		fgrants.region,
		dtopic.topic,
		sum(fgrants.amount) as funding_topic
	from fact_grants fgrants
	inner join dim_date ddate
		on fgrants.start_date = ddate.date_id
	inner join dim_granttopic dtopic
		on  fgrants.topic_id = dtopic.topic_id
	where fiscal_year = 2020 
	group by fgrants.region,dtopic.topic
) sub;

