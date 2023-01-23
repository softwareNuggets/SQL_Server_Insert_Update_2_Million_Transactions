--get the top 20 used names
select top 20 *
from first_names
order by total_usage desc

--how many records
select	count(distinct fname) num_unique_names,
		count(distinct yr) num_of_unique_years,
		count(*) num_rows
from LearnSQL.dbo.year_data



--naming children color names
select *
from first_names
where fname in (
		'azure','beige','bisque','black','blue','brown',
		'chocolate','coral','cyan','charcoal',
		'cooper','crimson','fuchsia','gold','gray','green','indigo',
		'ivory','khaki','lavender','lime','linen','magenta',
		'maroon','navy','olive',
		'orange','pink','plum','purple','salmon',
		'sky','silver','tan','teal','turquoise','violet','white','yellow')
order by total_usage desc


--pivot on some years for male names ending with 's'
select *
from (select	
		fname,
		'Y'+cast(yr as varchar(4)) theYear, 
		num_births 
		from LearnSQL.dbo.year_data
		where fname like '%s'
		and gender = 'M'
	) as s1
pivot
(
	sum(s1.num_births)
	for s1.theyear
	in ([Y1880],[Y1890],[Y1900],[Y1910],[Y1920],[Y1930],
		[Y1940],[Y1950],[Y1960],[Y1970],[Y1980],[Y1990],
		[Y2000],[Y2010],[Y2020])
) as pivotTable
order by Y2020 desc