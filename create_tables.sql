drop table learnSQL.dbo.raw_data;
drop table learnSQL.dbo.year_data;

create table learnSQL.dbo.raw_data
(
	fname nvarchar(40),
	gender char(1),
	num_births int
)

create table learnSQL.dbo.year_data
(
	yr int,
	fname nvarchar(40),
	gender char(1),
	num_births int
)

drop table learnSQL.dbo.first_names
create table learnSQL.dbo.first_names
(
	fname nvarchar(40) not null,
	gender char(1) not null,
	total_usage int,
	last_year_used int
)

ALTER TABLE learnSQL.dbo.first_names
   ADD CONSTRAINT PK_first_names PRIMARY KEY (fname, gender);