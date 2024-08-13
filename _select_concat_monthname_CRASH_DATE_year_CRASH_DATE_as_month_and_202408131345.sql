INSERT INTO `select  
	concat(monthname(CRASH_DATE),' ',year(CRASH_DATE)) 	as month_and_year
	,count(*) 											as accidents_per_month
	,(select count(*) from accidents)			as total_accidents
	,round((count(*) / (select count(*) from accidents)), 3) * 100	as accidents_per_month_in_percent
from accidents
group by 1
order by 4 desc` (month_and_year,accidents_per_month,total_accidents,accidents_per_month_in_percent) VALUES
	 ('January 2020',14287,74881,19.100),
	 ('February 2020',13684,74881,18.300),
	 ('March 2020',11057,74881,14.800),
	 ('July 2020',9225,74881,12.300),
	 ('August 2020',8747,74881,11.700),
	 ('June 2020',7616,74881,10.200),
	 ('May 2020',6149,74881,8.200),
	 ('April 2020',4116,74881,5.500);
