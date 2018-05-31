create database Membership

use Membership 
go

create table Individuals
(
IndividualID int primary key identity (1,1)
, FirstName varchar (50) not null
, LastName varchar (50) not null 
, Addr varchar (75) not null
, Phone varchar (20)not null
)

create table Groups
(
GroupID int primary key identity (1,1)
, GroupName varchar (50)not null
--allowing dues to be null in case a group doesnt have cost requirements
, Dues money default 0
check (Dues >= 0)
)

create table GroupMembership
(
IndividualID int not null
, GroupID int not null
, constraint fk_Individual foreign key (IndividualID) references Individuals (IndividualID)
, constraint fk_Group foreign key (GroupID) references Groups (GroupID)
)

create clustered index Group_Index 
on GroupMembership (GroupID)

create index Individual_Index
on GroupMembership (IndividualID)


Alter table Individuals
add DuesPaid bit default 0 not null

drop table Groupmembership

create table GroupMembership
(
IndividualID int not null
, GroupID int unique not null
, constraint fk_Individual foreign key (IndividualID) references Individuals (IndividualID)
, constraint fk_Group foreign key (GroupID) references Groups (GroupID)
)


