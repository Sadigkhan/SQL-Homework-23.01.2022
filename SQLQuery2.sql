create database LibraryDB
use LibraryDb

create table books
(
	Id int primary key identity,
	Name nvarchar(101) check(len(name)>2and len(name)<100) not null,
	pagecount int not null check(pagecount>=10)

)

create table Authors
(
	Id int primary key identity,
	Name nvarchar(25)  not null,
	Surname nvarchar(25)

)

--Books ve Authors table-larinizin mentiqi uygun elaqesi olsun.
alter table Books
add AuthorsId int references authors(id)

--Id, Name, PageCount ve AuthorFullName columnlarinin valuelarini qaytaran bir view yaradin
create view usv_GetAllBooks
as
select books.id as 'ID', books.Name as'BookName',pagecount as 'PageCount',(Authors.Name+' '+Authors.Surname) as 'AuthorFullName' from books
join authors
on Authors.Id=books.authorsid

select *from usv_GetAllBooks

--Gonderilmis axtaris deyirene gore hemin axtaris deyeri name ve ya authorFullNamelerinde olan Book-lari Id, Name, PageCount, AuthorFullName columnlari seklinde gostern procedure 
create procedure usp_GetBooksByString
@string nvarchar(25)
AS
BEGIN
select books.id as 'ID', books.Name as'BookName',pagecount as 'PageCount',(Authors.Name+' '+Authors.Surname) as 'AuthorFullName' from books
join authors
on Authors.Id=books.authorsid
where books.Name like '%'+@STRING+'%' or (Authors.Name+' '+Authors.Surname)  like '%'+@STRING+'%'
END

EXEC usp_GetBooksByString 'AG'

--Authors tableinin insert, update ve deleti ucun (her biri ucun ayrica) procedure 

INSERT INTO AUTHORS
VALUES('Elxan','Elatli')

CREATE PROCEDURE usp_InsertAuthor
@Name nvarchar(25), 
@Surname nvarchar (25)
as
begin
INSERT INTO AUTHORS
VALUES(@name,@surname)
end

exec usp_InsertAuthor '',''


create procedure usp_UpdateAuthor
@Name nvarchar(25), 
@Surname nvarchar(25),
@id int
as
begin
update authors
set 
Name=@name,
Surname=@surname
where id=@id
end

exec usp_UpdateAuthor jess,Kidd,7

create procedure usp_DeleteAuthor
@Id int
as
begin
delete authors
where  authors.Id=@id
end

exec usp_DeleteAuthor 7


--Authors-lari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz 
--Id-author id-si, FullName - Name ve Surname birlesmesi, BooksCount - 
--Hemin authorun elaqeli oldugu kitablarin sayi, MaxPageCount - hemin authorun elaqeli oldugu kitablarin icerisindeki max pagecount deyeri

create view usv_GetAllAuthors
as
select authors.id as 'ID', (authors.Name+' '+Authors.Surname) as'AuthorsFullName',
count((authors.Name+' '+Authors.Surname))as 'BooksCount',
max(books.pagecount)as 'MaximumPagecount'from authors
join books
on authors.id=books.authorsId
group by (authors.Name+' '+Authors.Surname), Authors.Id

select * from usv_GetAllAuthors




 






 
