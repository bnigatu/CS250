create view vwLifeExpectancy
as
	SELECT ROW_NUMBER() OVER(ORDER BY c.[Name]) as id,
		   c.[Name] as country,
		   e.continent,
		   c.[population],
		   p.Infant_Mortality as [life expectancy],
		   n.GDP * 1000000.0/c.[Population] as [gdp per capita]
	FROM dbo.Country as c
	JOIN dbo.Encompasses as e on e.Country = c.Code
	JOIN dbo.[Population] as p on p.Country = c.Code
	JOIN dbo.Economy as n on n.Country = c.Code
go