
create or alter trigger dbo.tr_Basket_insert_update on dbo.Basket
after insert
as 
begin
    update b
    set b.DiscountValue =
        case 
            when b.ID_SKU in(
					select ID_SKU from inserted group by ID_SKU having count(*) >= 2
                )
                then b.Value * 0.05
            else 0
        end
    from dbo.Basket as b
    inner join inserted as i on i.ID = b.ID;
end