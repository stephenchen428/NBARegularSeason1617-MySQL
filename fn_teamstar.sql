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
This function returns a single value(PlayerID) 
which a player with the highest average point in a team, 
and the player is defined by 1 input parameter(the input TeamID)
*/
delimiter //
create function fn_teamstar
	(Team_ID varchar(3))
Returns int
begin
	declare Player_ID float;
    
    select p.PlayerID
    into Player_ID
    from PlayerInfo p,
		(select teamID, Max(PTS) as PlayerPTS
		from playerInfo
		group by teamID) as MaxPts 
	where p.PTS = MaxPts.PlayerPTS
		and p.TeamID = Team_ID;
        
        return(Player_ID);
end//

select fn_teamstar('HOU') as TeamStarinHOU;

/* 
The select statement returns the player with the highest PTS in HOU and his coach information
*/
select p.TeamID, p.PlayerID, p.PlayerFName, p.PlayerLName, p.PTS,
	   c.CoachID,c.CoachFName,c.CoachLName
from playerinfo p, coachinfo c
where p.TeamID = c.TeamID
	and p.PlayerID=fn_teamstar('HOU');