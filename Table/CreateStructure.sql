-- Проверка наличия схемы в системных базах данных, при отсутствии схема создается
if not exists (select 1 from sys.schemas as s where s.name = 'dbo')
begin
	exec('create schema dbo')
end

-- Создание таблицы dbo.SKU
if object_id('dbo.SKU') is null
begin
	create table dbo.SKU (
		ID int not null identity,
		Code as 's' + CAST(ID as varchar(255)),
		Name varchar(255) not null,
		constraint PK_SKU primary key (ID)
	)
	alter table dbo.SKU add constraint UK_SKU_Code unique (Code)
end 

-- Создание таблицы dbo.Family
if object_id('dbo.Family') is null
begin
	create table dbo.Family (
		ID int not null identity,
		SurName varchar(255) not null,
		BudgetValue decimal(10, 2),
		constraint PK_Family primary key (ID)
	)   
end

-- Создание таблицы dbo.Basket
if object_id('dbo.Basket') is null
begin
	create table dbo.Basket (
		ID int not null identity,
		ID_SKU int not null,
		ID_Family int not null,
		Quantity int check (Quantity >= 0),
		Value decimal(10, 2) check (Value >= 0),
		PurchaseDate date,
		DiscountValue decimal(10, 2),
		constraint PK_Basket primary key (ID) 
	)
	alter table dbo.Basket add constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID)
	alter table dbo.Basket add constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID)
	alter table dbo.Basket add constraint DF_Basket_PurchaseDate default getdate() for PurchaseDate
end