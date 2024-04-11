create or alter function dbo.udf_GetSKUPrice(
	@ID_SKU int
)
returns decimal(18, 2)
as
begin
	declare @Price decimal(18, 2)

	select @Price = CAST(b.Value / b.Quantity as decimal(18, 2))
	from dbo.Basket as b
	where b.ID_SKU = @ID_SKU;

	return @Price;
end
