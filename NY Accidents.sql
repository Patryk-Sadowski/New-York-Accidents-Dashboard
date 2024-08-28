/* Compare the percentage of total accidents by month. Do you notice any seasonal patterns? */

select  
	concat(monthname(CRASH_DATE),' ',year(CRASH_DATE)) 			as month_and_year
	,count(*) 								as accidents_per_month
	,(select count(*) from accidents)					as total_accidents
	,round((count(*) / (select count(*) from accidents)), 3) * 100	 	as accidents_per_month_in_percent
from accidents
group by 1
order by 4 desc

/* Determine the frequency of accidents by day of the week and time of day. When are accidents most likely to occur based on this data? */

-- Number of accidents in 3 variants: day and hour, day,  hour only
select 
	 distinct dayname(CRASH_DATE) 						as day_of_week
	,CRASH_TIME 								as hours
	,count(*) over (partition by dayname(CRASH_DATE), CRASH_TIME) 		as nr_of_accidents
	,count(*) over (partition by dayname(CRASH_DATE)) 			as nr_of_accidents_per_day
	,count(*) over (partition by CRASH_TIME ) 				as nr_of_accidents_per_hour
from accidents 
order by 3 desc

/* On which street in particular were the most accidents reported? What percentage of all reported accidents is that?*/

select 
	ON_STREET_NAME  											  
	,count(*) 								as nr_of_accidents
	,round((count(*) / (select count(*) from accidents)), 3) *100 		as accidents_per_street_percent
from accidents 
group by 1
order by 3 desc

/* What was the most common contributing factor to crashes in this sample (based on Vehicle 1)? What about fatal crashes?*/

select
	 CONTRIBUTING_FACTOR_VEHICLE_1 		as casue_of_accident
	,count(*)				as nr_of_accidents
	,NUMBER_OF_PERSONS_KILLED 
from accidents
group by 1, 3
order by 2 desc

/* Number of victims by district, divided into injured and killed */

select
	BOROUGH   
	,case
		when NUMBER_OF_PEDESTRIANS_INJURED <> 0 then 'Pedestrian Injured'
		when NUMBER_OF_PEDESTRIANS_KILLED <> 0 then 'Pedestrian Killed'
		when NUMBER_OF_CYCLIST_INJURED <> 0 then 'Cyclist Injured'
		when NUMBER_OF_CYCLIST_KILLED <> 0 then 'Cyclist Killed'
		when NUMBER_OF_MOTORIST_INJURED <> 0 then 'Motorist Injured'
		when NUMBER_OF_MOTORIST_KILLED <> 0 then 'Motorist Killed'
		else 'No victim'
	end as type_of_victim
	,count(*)  as nr_of_victim
from accidents 
group by 1, 2
