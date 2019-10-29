use Training_13Aug19_Pune
go


create table AirportTerminal_bk
(
ID int primary key identity(400,1),
TerminalName varchar(50) unique,
AiportName varchar(50) not null,
ContactNo varchar(50) not null
)




create table FlightOperators_bk
(
ID int primary key identity(300,1),
Name varchar(50) unique,
HeadOffice varchar(50) not null,
ContactNo varchar(50) not null
)

create table FlightStatus_bk
(
ID int primary key identity(200,1),
Description varchar(50) unique
)


create table FlightDeparture_bk
(
ID int primary key identity(500,1),
Scheduled DateTime not null,
Estimated DateTime not null,
Actual DateTime not null
)


create table Flight_bk
(
ID int primary key identity(100,1),
Name varchar(50) foreign key(Name) references FlightOperators_bk(Name),
Destination  varchar(30) not null,
DepartureId int foreign key(DepartureId) references FlightDeparture_bk(ID),
TerminalId int foreign key(TerminalId) references AirportTerminal_bk(ID),
GateNo varchar(30) not null,
StatusId int foreign key(StatusId) references FlightStatus_bk(ID)
)


create procedure InsertFlight_bk
(
@Name varchar(50),
@Destination varchar(30),
@Scheduled DateTime,
@Estimated DateTime,
@Actual DateTime,
@TerminalId int,
@GateNo varchar(50),
@StatusId int
)
as
begin
Insert into FlightDeparture_bk values(@Scheduled, @Estimated, @Actual) 
Insert into Flight_bk values(@Name, @Destination, (select max(ID) from FlightDeparture_bk),@TerminalId, @GateNo, @StatusId )
end

drop procedure InsertFlight_bk
drop table Flight_bk
drop table FlightDeparture_bk

select count(ID) from FlightDeparture_bk


select * from Flight_bk where ID=101


create procedure UpdateFlight_bk
(
@ID int,
@Name varchar(50),
@Destination varchar(30),
@Scheduled DateTime,
@Estimated DateTime,
@Actual DateTime,
@TerminalId int,
@GateNo varchar(50),
@StatusId int
)
as
begin
Insert into FlightDeparture_bk values(@Scheduled, @Estimated, @Actual) 
Update Flight_bk set  Name= @Name, Destination= @Destination, DepartureId = ((select max(FlightDeparture_bk.ID) from FlightDeparture_bk)) , TerminalId = @TerminalId, GateNo = @GateNo, StatusId = @StatusId where ID=@ID
end

drop procedure updateflight_bk

create procedure DeleteFlight_bk
(@ID int)
as
begin
delete from Flight_bk where ID=@ID
end

set identity_insert Flight_bk on
go


create procedure GetAllFlights_bk 
as
begin
select * from Flight_bk  fb inner join FlightDeparture_bk fd on fb.DepartureId = fd.ID 
end


select * from Flight_bk fb , FlightDeparture_bk fd , FlightStatus_bk fs where fb.DepartureId = fd.ID  and fs.ID = fb.StatusId ;