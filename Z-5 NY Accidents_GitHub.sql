/* Porównaj procent ogólnej liczby wypadków według miesięcy. Czy zauważasz jakieś wzory sezonowe? */

select  
	concat(monthname(CRASH_DATE),' ',year(CRASH_DATE)) 				as month_and_year
	,count(*) 														as accidents_per_month
	,(select count(*) from accidents)								as total_accidents
	,round((count(*) / (select count(*) from accidents)), 3) * 100	as accidents_per_month_in_percent
from accidents
group by 1
order by 4 desc

/* Określ częstotliwość wypadków według dnia tygodnia i godziny.
Kiedy najczęściej dochodzi do wypadków na podstawie tych danych? */

-- Ilość wypadków w 3 wariantach: dzień i godzinę, dzień oraz sama godzina
select 
	 distinct dayname(CRASH_DATE) as day_of_week
	,CRASH_TIME 		as hours
	,count(*) over (partition by dayname(CRASH_DATE), CRASH_TIME) 	as nr_of_accidents
	,count(*) over (partition by dayname(CRASH_DATE)) 				as nr_of_accidents_per_day
	,count(*) over (partition by CRASH_TIME ) 						as nr_of_accidents_per_hour
from accidents 
order by 3 desc

/* Na której konkretnie ulicy zgłoszono najwięcej wypadków?
Jaki to procent w stosunku do wszystkich zgłoszonych wypadków?*/

select 
	ON_STREET_NAME  											  
	,count(*) 													  	as nr_of_accidents
	,round((count(*) / (select count(*) from accidents)), 3) *100 	as accidents_per_street_percent
from accidents 
group by 1
order by 3 desc

/* Jaki był najczęstszy czynnik przyczyniający się do wypadków w tej próbce (na podstawie pojazdu 1)?
A jak to wygląda w przypadku wypadków śmiertelnych?*/

select
	 CONTRIBUTING_FACTOR_VEHICLE_1 		as casue_of_accident
	,count(*)							as nr_of_accidents
	,NUMBER_OF_PERSONS_KILLED 
	,NUMBER_OF_PEDESTRIANS_KILLED 
	,NUMBER_OF_CYCLIST_KILLED 
	,NUMBER_OF_MOTORIST_KILLED 
from accidents
group by 1, 3, 4, 5, 6
order by 2 desc
