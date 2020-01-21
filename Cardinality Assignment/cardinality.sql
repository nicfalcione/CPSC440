DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS dorm_room CASCADE;
DROP TABLE IF EXISTS developer CASCADE;
DROP TABLE IF EXISTS workstation CASCADE;
DROP TABLE IF EXISTS pupil CASCADE;
DROP TABLE IF EXISTS assigned_seat CASCADE;
DROP TABLE IF EXISTS artist CASCADE;
DROP TABLE IF EXISTS painting CASCADE;
DROP TABLE IF EXISTS dorm_resident CASCADE;
DROP TABLE IF EXISTS patient CASCADE;
DROP TABLE IF EXISTS prescription CASCADE;
DROP TABLE IF EXISTS doctor CASCADE;
DROP TABLE IF EXISTS medication CASCADE;

create table dorm_room(
	building text,
	number int,
	primary key(building, number)
);

create table student(
	id int primary key,
	first_name text not null,
	last_name text not null,
	dorm_room_building text,
    dorm_room_number int,
	foreign key(dorm_room_building, dorm_room_number) references dorm_room(building, number)
);

create table workstation(
	hostname text primary key
);

create table developer(
	first_name text,
	last_name text,
	workstation_hostname TEXT NOT NULL UNIQUE,
	foreign key(workstation_hostname) references workstation(hostname),
	primary key (first_name, last_name)
);

create table assigned_seat(
	number int primary key
);

create table pupil(
	id int primary key,
	name text,
	assigned_seat_number int unique,
	foreign key(assigned_seat_number) references assigned_seat(number)
);

create table artist(
	name text primary key,
	year_born int not null, 
	year_died int
);

create table painting(
	id int primary key,
	name text,
	artist_name text not null,
	foreign key(artist_name) references artist(name)
);

create table dorm_resident(
	id int primary key,
	first_name text not null, 
	last_name text not null, 
	room_number int,
	resident_assistant int, 
	foreign key(resident_assistant) references dorm_resident(id)
);

create table patient(
	id int primary key,
	first_name text not null, 
	last_name text not null
);

create table doctor(
	id int primary key, 
	last_name text not null
);

create table medication(
	name text primary key
);

create table prescription(
	patient_id int not null references patient(id),
	doctor_id int not null references doctor(id),
	medication_name text not null references medication(name)
);