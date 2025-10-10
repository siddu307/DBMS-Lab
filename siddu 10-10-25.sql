use mysql

create user "Siddalingaiah" identified by "Siddu"
grant all privileges on *.* to "Siddalingaiah"
flush privileges

create database bm281;
show databases;
use bm281;
create database insurance_database;
use insurance_database;

create table person(
driver_id varchar(15),
name varchar(30),
address varchar(50),
primary key(driver_id));

create table car(
reg_num varchar(15),
model varchar(20),
year int,
primary key(reg_num));

create table accident(
report_num int,
accident_date date,
location varchar(50),
primary key(report_num));

create table owns(
driver_id varchar(15),
reg_num varchar(30),
primary key(driver_id,reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));

create table participated(
driver_id varchar(15),
reg_num varchar(30),
report_num int,
damage_amount int,
primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));

insert into person values('A01','Richard','Srinivas nagar'),
('A02','Pradeep','Rajajinagar'),
('A03','Smith','Ashoknagar'),
('A04','Venu','N R colony'),
('A05','John','Hanumanth nagar');

insert into car values('KA052250','Indica',1990),
('KA031181','Lancer',1957),
('KA095477','Toyota	',1998),
('KA053408','Honda',2008),
('KA041702','Audi',2005);

insert into accident values(11,'2003-01-01','Mysore road'),
(12,'2004-02-02','South end circle'),
(13,'2003-01-21','Bull temple road'),
(14,'2008-02-17','Mysore road'),
(15,'2005-03-04','Kanakapura road');

insert into owns values('A01','KA052250'),
('A02','KA031181'),
('A03','KA095477'),
('A04','KA053408'),
('A05','KA041702');

insert into participated values('A01','KA052250',11,10000),
('A02','KA031181',12,50000),
('A03','KA095477',13,25000),
('A04','KA053408',14,3000),
('A05','KA041702',15,5000);

select*from person;
select*from car;
select*from accident;
select*from owns;
select*from participated;

select accident_date,location
from accident;

select name
from person p,participated pa
where ((p.driver_id=pa.driver_id) and (damage_amount>=25000));

select name,model
from person p,car c,owns o
where((p.driver_id=o.driver_id) and (c.reg_num=o.reg_num));

select accident_date,location,name,damage_amount
from person p,accident a,participated pa
where((p.driver_id=pa.driver_id) and (a.report_num=pa.report_num));

select accident_date,location,sum(pa.damage_amount)
from accident a,participated pa
where a.report_num=pa.report_num
group by a.report_num;

select name,count(*) 
from participated pa,person p
where pa.driver_id=p.driver_id
group by pa.driver_id
having count(*)>1;

select model
from car c
where reg_num not in (select reg_num 
                      from participated);

select accident_date
from accident 
where accident_date >= all(select accident_date
						from accident);

select name,avg(pa.damage_amount)
from person p,participated pa
where p.driver_id=pa.driver_id
group by pa.driver_id;

update participated
set damage_amount=25000
where driver_id='A02';

select name
from person p,participated pa
where((p.driver_id=pa.driver_id) and pa.damage_amount>= all(select damage_amount
                                                             from participated));

select model
from car c,participated pa
where c.reg_num=pa.reg_num
group by pa.reg_num
having sum(pa.damage_amount)>20000;           

create view summary_accidents as select 
a.report_num as Acc_ReportNum,
a.location as Acc_Location,
a.accident_date as Acc_date,
COUNT(p.driver_id) AS NumberOfParticipants,
SUM(p.damage_amount) AS TotalDamage
from accident as a,participated as p
where a.report_num=p.report_num
group by a.report_num;                              
                                                             
select * from summary_accidents;



