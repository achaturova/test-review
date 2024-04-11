create or alter view dbo.vw_SKUPrice 
as
select
    SKU.ID,
    SKU.Code,
    SKU.Name,
    dbo.udf_GetSKUPrice(SKU.ID) as SKUPrice
from dbo.SKU