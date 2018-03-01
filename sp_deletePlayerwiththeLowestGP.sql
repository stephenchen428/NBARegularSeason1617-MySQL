 /*    
   IF condition1 THEN
   {...statements to execute when condition1 is TRUE...}

   ELSEIF condition2 THEN
   {...statements to execute when condition2 is TRUE...}

   ELSE
   {...statements to execute when both condition1 and condition2 are FALSE...}

   END IF;
*/

/*
   MySQL doesn't have the equivalent of the output or
   returning clauses.
   
   In SQL Server, you can ouptput the rows from deleted and inserted
   tables by using outout keyword.
*/

/*
  Limit Query Optization
  
  If you need only a specified number of rows from a result set, use a LIMIT clause in the 
  query, rather than fetching the whole result set and throwing away the extra data.
  
  If you combine LIMIT row_count with ORDER BY, MySQL stops sorting as soon as it has found 
  the first row_count rows of the sorted result, rather than sorting the entire result.
  
  In SQL Server, the SELECT TOP clause is used to specify the number of records to return.  
*/
/* 
	This stored proecure has 1 input parameter-TeamID
	if the selected team has more than 17 players, it will delete the player who played 
	the lowest game in this season.
*/   

delimiter //
create procedure SP_deletePlayerwiththeLowestGP
	(in Input_TeamID varchar(3))
begin
	declare countplayer int;

	select countplayer = count(*)
	from playerinfocopy				 
	where TeamID=Input_TeamID;

	if countplayer >17 then
		delete from PlayerInfoCopy
		where PlayerID in (select PlayerID
						   from PlayerInfoCopy
                           where teamID = Input_TeamID
						   order by GP limit 1);
	else
		select 'Cannot delete player(s). ' as '';
	end if;
end//

call SP_deletePlayerwiththeLowestGP('ATL');

select TeamID, Count(*) as TotalPlayer
from PlayerInfoCopy
where TeamID='ATL' 
group by TeamID;

select *
from PlayerInfoCopy	
where TeamID='ATL' 					   
order by GP limit 1

drop proc SP_deletePlayerwiththeLowestGP;
