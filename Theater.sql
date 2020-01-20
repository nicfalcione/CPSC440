DROP SCHEMA if exists private cascade;
DROP SCHEMA if exists public cascade;

CREATE SCHEMA private;
create schema public;

create table public.SeatRow (
	row varchar(2) primary key
);

-- insert using values
insert into SeatRow(row)
values
('A'),('B'),('C'),('D'),('E'),('F'),('G'),('H'),('J'),('K'),('L'),('M'),('N'),('O'),('P'),
('Q'),('R'),('AA'),('BB'),('CC'),('DD'),('EE'),('FF'),('GG'),('HH');

create table public.SeatNum (
	num int primary key
);

create function populate_col() returns void LANGUAGE plpgsql as $$
declare row int;
declare num int;
begin
	row := 1;
	num := 101;
	loop
    	insert into public.seatNum
    	select row;   	 
    	row = row + 1; 
		exit when row > 15;   	 
	end loop;
	loop
    	insert into public.seatNum
    	select num;   	 
    	num = num + 1; 
		exit when num > 126;
	end loop;
end $$;
select populate_col();

create table public.Seat (
	seatRow varchar(2) not null references SeatRow(row),
	seatNum int not null references SeatNum(num),
	seatSection text not null check(seatSection in('Balcony', 'Main Floor')),
	seatSide text not null check(seatSide in('Left','Middle','Right')), 
	seatPricingTier text not null check(seatPricingTier in ('Upper Balcony', 'Side','Orchestra')),
	wheelChair int not null check(wheelChair in(1,0)) default 0,
	constraint seat_pk primary key (seatRow, seatNum)
);

create table public.Customer (
	customerID serial primary key,
	firstName text not null,
	lastName text not null
);

create table public.Ticket (
	ticketNumber serial primary key,
	customerID int not null references public.Customer(customerID),
	seatRow varchar(2) not null,
	seatNum int not null,
	showTime timestamp not null,
	constraint ticket_constraint unique (seatRow, seatNum, showTime)
);

create table private.Customer(
	customerID serial primary key references public.Customer(customerID),
	creditCard bigInt
);

insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Main Floor', 'Middle','Orchestra', 0
from SeatRow, SeatNum 
where char_length(row) = 1 
and num <=15;


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Main Floor', 'Right', 'Orchestra', 0
from SeatRow, SeatNum 
where char_length(row) = 1 
and (num = 106 or num = 104 or num = 102);


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Main Floor', 'Left', 'Orchestra', 0
from SeatRow, SeatNum 
where char_length(row) = 1 
and (num = 105 or num = 103 or num = 101);


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Main Floor', 'Right', 'Side', 0
from SeatRow, SeatNum 
where char_length(row) = 1 
and num % 2 = 0 
and num >= 108 
and num <= 122;


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Main Floor', 'Left', 'Side', 0
from SeatRow, SeatNum  
where char_length(row) = 1 
and num % 2 != 0 
and num >= 107 
and num <= 121;


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Balcony', 'Right', 'Side', 0
from SeatRow, SeatNum 
where (row = 'AA' or row = 'BB' or row = 'CC' or row = 'DD')
and num % 2 = 0 
and num >= 102 
and num <= 126;


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Balcony', 'Middle', 'Orchestra', 0
from SeatRow, SeatNum  
where (row = 'AA' or row = 'BB' or row = 'CC' or row = 'DD')
and num >= 1  
and num <= 14;


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Balcony', 'Left', 'Side', 0
from SeatRow, SeatNum  
where (row = 'AA' or row = 'BB' or row = 'CC' or row = 'DD')
and num % 2 != 0 
and num >= 101 
and num <= 125;


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Balcony', 'Right', 'Upper Balcony', 0
from SeatRow, SeatNum  
where (row = 'EE' or row = 'FF' or row = 'GG' or row = 'HH')
and num % 2 = 0 
and num >= 102 
and num <= 122;


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Balcony', 'Middle', 'Upper Balcony', 0
from SeatRow, SeatNum  
where (row = 'EE' or row = 'FF' or row = 'GG' or row = 'HH') 
and num >= 1 
and num <= 11;


insert into seat(seatRow, seatNum, seatSection, seatSide, seatPricingTier, wheelChair)
select SeatRow.row, SeatNum.num, 'Balcony', 'Left', 'Upper Balcony', 0
from SeatRow, SeatNum 
where (row = 'EE' or row = 'FF' or row = 'GG' or row = 'HH')
and num % 2 != 0 
and num >= 101 
and num <= 121;

--Resolve upper balcony
DELETE FROM public.Seat WHERE seatRow = 'GG' AND seatSide = 'Right' AND seatNum > 120;
DELETE FROM public.Seat WHERE seatRow = 'HH' AND seatSide = 'Right' AND seatNum > 118;
DELETE FROM public.Seat WHERE seatRow = 'GG' AND seatSide = 'Left' AND seatNum > 119;
DELETE FROM public.Seat WHERE seatRow = 'HH' AND seatSide = 'Left' AND seatNum > 117;
DELETE FROM public.Seat WHERE (seatRow = 'FF' or seatRow = 'EE') AND seatSide = 'Middle' AND seatNum > 10;

--Resolve Middle Section
DELETE FROM public.Seat WHERE (seatRow = 'AA' or seatRow = 'BB' or seatRow = 'CC') AND seatSide = 'Right' AND seatNum > 124;
DELETE FROM public.Seat WHERE seatRow = 'AA' AND seatSide = 'Middle' AND seatNum > 13;
DELETE FROM public.Seat WHERE (seatRow = 'AA' or seatRow = 'BB' or seatRow = 'CC') AND seatSide = 'Left' AND seatNum > 123;
DELETE FROM public.Seat WHERE (seatRow = 'K' or seatRow = 'L' or seatRow = 'M' or seatRow = 'N') AND seatSide = 'Right' AND seatNum > 120;
DELETE FROM public.Seat WHERE (seatRow = 'F' or seatRow = 'G' or seatRow = 'H' or seatRow = 'J') AND seatSide = 'Right' AND seatNum > 118;
DELETE FROM public.Seat WHERE (seatRow = 'B' or seatRow = 'C' or seatRow = 'D' or seatRow = 'E') AND seatSide = 'Right' AND seatNum > 116;
DELETE FROM public.Seat WHERE seatRow = 'A' AND seatSide = 'Right' AND seatNum > 114;
DELETE FROM public.Seat WHERE (seatRow = 'K' or seatRow = 'L' or seatRow = 'M' or seatRow = 'N') AND seatSide = 'Left' AND seatNum > 119;
DELETE FROM public.Seat WHERE (seatRow = 'F' or seatRow = 'G' or seatRow = 'H' or seatRow = 'J') AND seatSide = 'Left' AND seatNum > 117;
DELETE FROM public.Seat WHERE (seatRow = 'B' or seatRow = 'C' or seatRow = 'D' or seatRow = 'E') AND seatSide = 'Left' AND seatNum > 115;
DELETE FROM public.Seat WHERE seatRow = 'A' AND seatSide = 'Left' AND seatNum > 113;
DELETE FROM public.Seat WHERE (seatRow = 'A' or seatRow = 'B' or seatRow = 'C') AND seatSide = 'Middle' AND seatNum > 10;
DELETE FROM public.Seat WHERE (seatRow = 'D' or seatRow = 'E' or seatRow = 'F') AND seatSide = 'Middle' AND seatNum > 11;
DELETE FROM public.Seat WHERE (seatRow = 'G' or seatRow = 'H' or seatRow = 'J') AND seatSide = 'Middle' AND seatNum > 12;
DELETE FROM public.Seat WHERE (seatRow = 'K' or seatRow = 'L' or seatRow = 'M') AND seatSide = 'Middle' AND seatNum > 13;
DELETE FROM public.Seat WHERE (seatRow = 'N' or seatRow = 'O' or seatRow = 'P') AND seatSide = 'Middle' AND seatNum > 14;


update Seat    
set seatPricingTier = 'Side' 
where char_length(seatRow) = 1
and seatNum >= 108;
    
update Seat    
set wheelChair = 1 
where seatRow in ('P', 'Q', 'R')
and seatNum > 108 
and seatSide = 'Right';

update Seat    
set wheelChair = 1 
where seatRow in ('P', 'Q', 'R')
and seatNum > 107 
and seatSide = 'Left';

insert into public.Customer(customerID, firstName, LastName) 
values (1234, 'Mike', 'Johnson');
insert into private.Customer(customerId, creditCard) 
values (1234, 1234567887654321);
insert into public.Ticket(customerId, seatRow, seatNum, showTime)
values (1234, 'A', 6, '2017-12-17 02:00:00');
insert into public.Ticket(customerId, seatRow, seatNum, showTime)
values (1234, 'A', 8, '2017-12-17 02:00:00');
insert into public.Ticket(customerId, seatRow, seatNum, showTime)
values (1234, 'A', 9, '2017-12-17 02:00:00');
insert into public.Ticket(customerId, seatRow, seatNum, showTime)
values (1234, 'A', 10, '2017-12-17 02:00:00');

select * from private.Customer;

