--truncate table learnSQL.dbo.first_names
--drop table #temp_year_data
create table #temp_year_data
	(
		fname nvarchar(40) not null,
		gender char(1) not null,
		yr int,
		num_births int default(0),
		fname_prod nvarchar(40) null
	);	
ALTER TABLE #temp_year_data
   ADD CONSTRAINT PK_temp_year_data PRIMARY KEY (fname, gender);

declare @yr int = 1880;

while @yr<2022
begin

	truncate table #temp_year_data;

	insert into #temp_year_data(fname, gender,yr, num_births,fname_prod)
	select 
		yd.fname, 
		yd.gender, 
		yd.yr, 
		yd.num_births,
		fn.fname
	from learnSQL.dbo.year_data yd
		left join learnSQL.dbo.first_names fn
			on(fn.fname = yd.fname
				and fn.gender = yd.gender)
	where yd.yr = @yr;

	insert into learnSQL.dbo.first_names(fname, gender,total_usage, last_year_used)
	select	tyd.fname, tyd.gender, tyd.num_births, @yr
	from	#temp_year_data tyd
	where	tyd.fname_prod is null;

	delete from #temp_year_data 
	where fname_prod is null;

	update learnSQL.dbo.first_names
	set first_names.total_usage = first_names.total_usage + tyd.num_births,
		first_names.last_year_used = @yr
	from #temp_year_data tyd
	where first_names.fname = tyd.fname
	and	 first_names.gender = tyd.gender
	and tyd.fname_prod is not null;

	set @yr = @yr + 1;
end
