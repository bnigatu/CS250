

drop table player;
create table player(
	PlayerID int identity primary key,
	PlayerName varchar(50),
	NumberOfCharacter int,
);
drop table [Character]
create table [Character](
	CharacterID int identity primary key,
	CharacterName varchar(50),
	PlayerID int,
	constraint fk_player foreign key (PlayerID) references Player(PlayerID)
);


IF OBJECT_ID('tr_aft_ins_delete_Character','TR') IS NOT NULL
	DROP TRIGGER tr_aft_ins_delete_Character;
go
	
CREATE TRIGGER tr_aft_ins_delete_Character 
ON dbo.[Character]
AFTER  INSERT, DELETE
AS
BEGIN 
	if ( @@rowcount = 0 ) RETURN; -- If there is not character change don't do nothing, exit.
    set nocount on;
	
		
			Update p set p.NumberOfCharacter = isnull(cnt,0)
			From player as p 
			left join (select c.PlayerID,count(c.CharacterID) as cnt
				  from [Character] as c
				  group by c.PlayerID
				  ) as c on p.PlayerID = c.PlayerID		
	
	RETURN;
END
GO


----
insert into player (PlayerName,NumberOfCharacter)
 values('James',0),
	 ('Ruslan',0),
	 ('Mark',0);

-- 
insert into [Character](	
	CharacterName,
	PlayerID)
	values('Barbara',1),
		  ('Yusuf',3),
		  ('Dwarf',2),
		  ('Gandalf',1);

delete 
from [Character]
where CharacterID = 2;

select *
from player


select *
from [Character]