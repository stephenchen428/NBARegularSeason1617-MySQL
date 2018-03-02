/* 
A trigger is a named block of cide that is excuted/fired, automatically 
when a particular type of SQL statement is executed.alter
*/
/*
After the name of the trigger, you code the BEFORE or AFTER keyword to 
indicate when the trigger is fired.

Before triggers can be used to update or validate record values before 
they are saved to the database. you can use before trigger on update 
the same object.

After triggers can be used to affect changes in other record values. 
you cannot use after trigger on update the same object.

SQL Server does not support BEFORE triggers. The cloest you have is 
INSTEAD OF trigger but their behavior is different to BEFORE triggers. 
*/


/*
After the ON clause, you code the FOR EACH ROW clause. This clause indicates
that the trigger is a row-level trigger that fires for each row that's modified.
*/
/*
Within the body of a trigger, you can use the NEW keyword to work with 
the new value in a row that's bring inserted or updated. If you use this 
keyword with a row that's being deleted, you will get an error since this 
row does not have any new value

you can use OLD keyword to work with the old values in a row that's being
updated or deleted. you cannot use this keyword with a row that's being 
inserted, since a new row does not have any old values. 
*/
/*
Unlike SQL Server, there are no inserted table and deleted table in NoSQL.
You can use the NEW and OLD keywords to modify the record values. 
The before trigger is only used to update the same record value, 
and the after trigger is only used to affect changes to other record value
*/
/*
This trigger called tri_teaminfo_upperteamid is a before trigger. 
This trigger would be used to update the new inserted record values
before they are saved to the teaminfo table
*/

delimiter //
create trigger tri_teaminfo_upperteamid
	before insert on teaminfo
    for each row
begin
	set new.TeamID = upper(new.TeamID);
end//

start transaction;
insert into teaminfo values ('bal','Baltimore Bullets','Southeast','Eastern' );
select * from teaminfo where teamid='BAL';
delete from teaminfo where TeamID = 'BAL'
rollback;

drop trigger tri_teaminfo_upperteamid;