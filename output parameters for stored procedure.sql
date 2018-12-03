-- sample stored procedure on how to use output parameters

--create database sample
--go
--use sample
--go



create procedure addition (@x int, @y int, @total int output)
as 
	Set @total = @x + @y;

	return 0;
go

------------------------------------------------------------------
declare @x int=10,
	    @y int=25,
		@total int=0;

exec addition @x,@y, @total output


select @total