create procedure dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)
as
begin
	-- Проверяем существует ли фамилия в базе
	if not exists (
		select 1 
		from dbo.Family 
		where SurName = @FamilySurName
	)
	begin
		raiserror ('Введеная фамилия отсутсвует в базе', 16, 1)
		return
	end
		
	--  Обновляем данные в таблице dbo.Family в поле BudgetValue 
	update f
	set BudgetValue = f.BudgetValue - (
		select sum(b.Value)
		from dbo.Basket as b 
		where b.ID_Family = (select ID from dbo.Family where SurName = @FamilySurName)
	)
	from dbo.Family as f
	where SurName = @FamilySurName;
end;