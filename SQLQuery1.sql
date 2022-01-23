create database TechStore
use  TechStore

create table Notebooks
(
	Id int primary key identity,
	Name nvarchar(25) not null,
	Price smallmoney not null
)

create table Phones
(
	Id int primary key identity,
	Name nvarchar(25) not null,
	Price smallmoney not null
)


create table Brands
(
	Id int primary key identity,
	Name nvarchar(25) not null

)
--Notebook ve Brand Arasinda Mentiqe Uygun Relation 
alter table Notebooks
add BrandsId int references Brands(Id)

--Phones ve Brand Arasinda Mentiqe Uygun Relation 
alter table Phones
add BrandsId int references Brands(Id)

--Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
select notebooks.Name, brands.Name as 'Brandname',Price from Notebooks
inner join Brands
on Notebooks.BrandsId=Brands.Id

--Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
select phones.Name, brands.Name as 'Brandname',Price from Phones
inner join Brands
on Phones.BrandsId=Brands.Id

--Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.
select notebooks.name as 'Notebookname',Brands.Name as 'BrandName' from Notebooks
inner join brands 
on notebooks.brandsid=brands.id
where brands.name like '%s%'

--Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.
select notebooks.name as 'Notebookname',Brands.Name as 'BrandName',Notebooks.Price as 'Price' from Notebooks
inner join brands 
on notebooks.brandsid=brands.id
where Notebooks.price between 2000 and 5000 or notebooks.price>5000

--Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.
select phones.name as 'PhoneName',Brands.Name as 'BrandName',Phones.Price as 'Price' from Phones
inner join brands 
on Phones.brandsid=brands.id
where Phones.price between 1000 and 1500 or Phones.price>1500

--Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
select brands.name as 'BrandName',count(Brands.Name) as 'NotebookCount'from brands
join notebooks
on brands.id=Notebooks.brandsid
group by Brands.Name

-- Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
select brands.name as 'BrandName',count(Brands.Name) as 'PhoneCount'from brands
join phones
on brands.id=Phones.brandsid
group by Brands.Name

--Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.
select Name,brandsid as 'BrandID' from phones
intersect
select Name,brandsid as 'BrandID' from notebooks


--Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
select notebooks.name as 'Name',notebooks.price as 'Price' from notebooks
where notebooks.brandsid is not null 
union 
select phones.name as 'Name',phones.Price as 'Price' from  phones
where phones.brandsid is not null 

--Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
select phones.id as'ID', phones.Name as 'Name', brands.Name  as 'Brandname',price as 'Price' from Phones
inner join Brands
on Phones.BrandsId=Brands.Id
union
select notebooks.id as 'ID', notebooks.Name as 'Name', brands.name as 'Brandname',price as 'Price' from Notebooks
inner join Brands
on notebooks.BrandsId=Brands.Id

-- Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
select phones.id as'ID', phones.Name as 'Name', brands.Name  as 'Brandname',price as 'Price' from Phones
inner join Brands
on Phones.BrandsId=Brands.Id
where phones.price>1000
union
select notebooks.id as 'ID', notebooks.Name as 'Name', brands.name as 'Brandname',price as 'Price' from Notebooks
inner join Brands
on notebooks.BrandsId=Brands.Id
where notebooks.price>1000

-- Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple              6750                3
--Samsung            3500                4
--Redmi              800                1

select brands.name as 'BrandName',sum(phones.Price) as 'TotalPrice',count(Brands.Name) as 'PhoneCount'from brands
join phones
on brands.id=Phones.brandsid
group by Brands.Name

--Notebooks Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple                6750                3
--Samsung              3500                4

select brands.name as 'BrandName',sum(notebooks.Price) as 'TotalPrice',count(Brands.Name) as 'NotebookCount'from brands
join notebooks
on brands.id=notebooks.brandsid
group by Brands.Name
having count(Brands.Name)>=3


