
CREATE PROCEDURE [dbo].[Insertuser]
@name varchar(50) ,
@id int  ,
@pass varchar(50)  ,
@priv varchar(50)  ,
@synid int  
AS
Begin
SET NOCOUNT ON;
INSERT INTO users Values (@id,@name ,@pass ,@priv ,@synid);
END
GO

-----------------------------

CREATE PROCEDURE [dbo].[assignjudg]
@jid int  ,
@y int  ,
@id int  ,
@t varchar(50)  ,
@l varchar(50)  
AS
Begin
SET NOCOUNT ON;

insert into Assigned_To values(@jid,@y,@id,@t,@l)
END 
go
---------------------
CREATE PROCEDURE [dbo].[assinverdict]
@ver  varchar(50) ,
@cy int  ,
@cid int  ,
@ct varchar(50)  ,
@cl varchar(50)  
AS
Begin
SET NOCOUNT ON;

 UPDATE courtcase SET case_verdict =@ver where case_id = @cid and case_location =  @cl and case_type =  @ct  and case_year =  @cy; 
END 
GO
--------------
CREATE PROCEDURE [dbo].[autholaw]
@l_id  int,
@cid  int,
@cy  int,
@ct  varchar(50),
@cl  varchar(50)
AS
Begin
SET NOCOUNT ON;

 update  courtcase  set ld_id=@l_id where case_id= @cid AND case_year= @cy AND case_type= @ct AND case_location= @cl and ld_id is null ;
END 
GO
-----------------------------

CREATE PROCEDURE [dbo].[checklogin]
@id  int,
@name  varchar(50),
@pass  varchar(50)
AS
Begin
SET NOCOUNT ON;

SELECT privilage FROM users WHERE Id=@id AND fullname =@name AND password=@pass;
END 
GO
---------------------
CREATE PROCEDURE [dbo].[uid]
@loc  varchar(50),
@typ  varchar(50),
@year  int
AS
Begin
SET NOCOUNT ON;

select MAX(case_id)+1 from courtcase where case_type=@typ AND case_year=@year AND case_location=@loc;
END 
go
-----------------------------
CREATE PROCEDURE [dbo].[Selectmainjudge]
@s  int,
@deg  varchar(50)
AS
Begin
SET NOCOUNT ON;

select j_name from judge , chiefjustice where chiefjustice.ch_id = @s and judge.ch_id = chiefjustice.ch_id and j_degree =@deg;
END 
GO
--------------------------
CREATE PROCEDURE [dbo].[getjudgid]
@chid  int,
@jname  varchar(50)
AS
Begin
SET NOCOUNT ON;

select j_id from judge,chiefjustice where  judge.ch_id = chiefjustice.ch_id and j_name=@jname AND chiefjustice.ch_id=@chid;
END 
GO        
------------------------------
CREATE PROCEDURE [dbo].[searchcase]
@cid  int,
@cloc  varchar(50),
@cyear  int,
@ctyp  varchar(50)
AS
Begin
SET NOCOUNT ON;

select * from courtcase  where courtcase.case_id= @cid and courtcase.case_location=@cloc and court_type= @ctyp and courtcase.case_year= @cyear;
END 
GO
----------------------------------
CREATE PROCEDURE [dbo].[ch_cases]
@chid  int
AS
Begin
SET NOCOUNT ON;

 select case_id, case_type,case_location,case_year,casenotcourttype from courtcase , chiefjustice where chiefjustice.ch_id=courtcase.ch_id and chiefjustice.ch_id=@chid ;
END 
GO
----------------------------------
CREATE PROCEDURE [dbo].[j_cases ]
@jid  int
AS
Begin
SET NOCOUNT ON;

Select * from assigned_to as x where j_id=@jid order by case_id;
END 
GO
-----------------------------------------
CREATE PROCEDURE [dbo].[l_cases ]
@lid  int
AS
Begin
SET NOCOUNT ON;
select case_id, case_type,case_location,case_year,casenotcourttype from  courtcase ,lawyer where (lawyer.l_id=courtcase.l_id or lawyer.l_id=courtcase.ld_id) and lawyer.l_id=@lid ;
END 
GO
---------------------------------
CREATE PROCEDURE [dbo].[c_cases]
@cid  int
AS
Begin
SET NOCOUNT ON;

select case_id, case_type,case_location,case_year,casenotcourttype from courtcase where case_id in ((select case_id from courtcase where d_id=@cid) UNION (select case_id From Represent_in where c_id =@cid AND c_as='p'));
END 
GO
-----------------------------------
CREATE PROCEDURE [dbo].[casedet]
@cid  int,
@cyear  int,
@crtyp  varchar(50),
@cloc  varchar(50)
AS
Begin
SET NOCOUNT ON;

select * from courtcase where case_id= @cid AND case_year= @cyear AND case_type=@crtyp AND case_location=@cloc ;
END 
GO
---------------------------
CREATE PROCEDURE [dbo].[l_exist]
@l_id  int
AS
Begin
SET NOCOUNT ON;

select * from lawyer where l_id=@l_id;
END 
GO
--------------------------------
CREATE PROCEDURE [dbo].[caspname]
@cid  int,
@cyear  int,
@ctyp  varchar(50),
@cloc  varchar(50)
AS
Begin
SET NOCOUNT ON;

select c_name from civilian where c_id in (select c_id from represent_in where case_id=@cid  AND case_year= @cyear  AND case_type=@ctyp  AND case_location=@cloc  and c_as='p');
END 
GO
--------------------------------------
CREATE PROCEDURE [dbo].[casesesion]
@cid  int,
@cyear  int,
@ctyp  varchar(50),
@cloc  varchar(50)
AS
Begin
SET NOCOUNT ON;

select max(session_date) from courtsession where case_id=@cid and case_year=@cyear and case_type=@ctyp AND case_location=@cloc;
END 
go
------------------------------------------
CREATE PROCEDURE [dbo].[c_as]
@civid  int,
@cid  int,
@cyear  int,
@ctyp  varchar(50),
@cloc  varchar(50)
AS
Begin
SET NOCOUNT ON;

select c_as from Represent_in where c_id=@civid and case_id=@cid and case_type=@ctyp  and case_location= @cloc and case_year= @cyear;
END 
GO

----------------------------------------------
CREATE PROCEDURE [dbo].[find_l]
@LID  int
AS
Begin
SET NOCOUNT ON;

select l_name AS name,l_degree as degree from lawyer where l_id= @LID ;
end
go
