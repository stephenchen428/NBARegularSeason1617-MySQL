/*
In many ways, the code for creating a function works similarly to the code for 
creating a stored procedure. However, there are two primary differences between
stored procedures and function. First, a MySQL function always returns a single 
value. Second, a function cannot make changes to the database such as executing
an INSERT, UPDATE, or DELETE statement.

In MySQL, user-defined functions cannot retun a table, 
IN SQL Server, user-defined functions can return single value or table.
*/

/* 
This user-defined function called fn_playerFTRate with two input parameters. 
this function returns the total number of players whose field goal percentage is 
between 2 input values.
*/

delimiter //
create function fn_PlayerFTRate
	( min float(5,1), max float(5,1))
	returns int
begin
	return (select count(*) from PlayerInfo_percentage
			where `FT%` between min and max);
end//

/*Use SELECT to call a user-defined function*/
/*This select statement returns 24 players have the FT rate between 40 and 50 percentage.*/
select fn_PlayerFTRate(40,50) as PlayerFTRatein40to50;

select PlayerID, PlayerFName, PlayerLname from PlayerInfo_percentage where fn_PlayerFTRate(40,50)