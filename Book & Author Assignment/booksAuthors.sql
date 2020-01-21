--Author: Nic Falcione
drop table if exists Book cascade;
drop table if exists Author cascade;
drop table if exists BookAuthor cascade;

create table Book (
	Title varchar(100) not null,
	Edition int not null,
	Publisher varchar(50) not null,
	ISBN decimal(13,0) primary key 
);

create table Author (
	ID int primary key, 
	Name varchar(50) not null
);

create table BookAuthor (
	AuthorID int references Author,
	BookISBN decimal(13,0) references Book,
	primary key (AuthorID, BookISBN)
);

insert into Book(Title, Edition, Publisher, ISBN)
	values ('Object-Oriented Design and Patterns', 2, 'Wiley', 9780471744870);
insert into Book(Title, Edition, Publisher, ISBN)
	values ('Intro to Java Programming Comprehensive Version', 10, 'Pearson', 9780133761313);
insert into Book(Title, Edition, Publisher, ISBN)
	values ('Advanced Engineering Mathematics', 10, 'Wiley', 9780470458365);
insert into Book(Title, Edition, Publisher, ISBN)
	values ('Computer Architecture', 5, 'Elsevier Science', 9780123838728);
	
insert into Author(ID, Name)
	values (1, 'Cay S. Horstmann');
insert into Author(ID, Name)
	values (2, 'Y. Daniel Liang');
insert into Author(ID, Name)
	values (3, 'Erwin O. Kreysig');
insert into Author(ID, Name)
	values (4, 'John L. Hennessy');
insert into Author(ID, Name)
	values (5, 'David A. Patterson');
	
insert into BookAuthor(AuthorID, BookISBN)
	values (1, 9780471744870);
insert into BookAuthor(AuthorID, BookISBN)
	values (2, 9780133761313);
insert into BookAuthor(AuthorID, BookISBN)
	values (3, 9780470458365);
insert into BookAuthor(AuthorID, BookISBN)
	values (4, 9780123838728);
insert into BookAuthor(AuthorID, BookISBN)
	values (5, 9780123838728);