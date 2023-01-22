declare @yr int = 1880,
		@path nvarchar(300),
		@CRLF nchar(2) = NCHAR(13) + NCHAR(10),
		@delimiter nchar(1)=',';

while @yr<2022
begin
	truncate table LearnSQL.dbo.raw_data;


    DECLARE @SQL nvarchar(MAX);

	set @path = N'C:\YOUTUBE\SQL\BigUpdate\names\yob'+cast(@yr as nvarchar(4))+'.txt';

	SET @SQL = N'BULK INSERT LearnSQL.dbo.raw_data' + @CRLF +
               N'FROM N''' + REPLACE(@path,'''','''''') + N'''' + @CRLF + 
               N'WITH (codepage=''RAW'',' + @CRLF + 
			   N'      FORMAT = ''CSV'',' + @CRLF + 
			   N'      firstrow=1,' + @CRLF + 
			   N'      FIELDTERMINATOR = N'','',' + @CRLF +
               N'      ROWTERMINATOR = ''\n'');'

    --PRINT @SQL;
    EXEC sys.sp_executesql @SQL;

	set @SQL = N'insert into learnSQL.dbo.year_data' + @CRLF +
			N'select '+cast(@yr as nvarchar(4))+',fname, gender,num_births'+ @CRLF +
			N'from LearnSQL.dbo.raw_data'

	EXEC sys.sp_executesql @SQL;

	set @yr = @yr + 1
end


--select count(*)
--from learnSQL.dbo.year_data
