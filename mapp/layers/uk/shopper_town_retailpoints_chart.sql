select
 a.retailer,
 count(a.id)
from
    geodata.uk_glx_open_retail_points a,
    geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
where
    b.id = ${id}
    and st_intersects(b.geom_4326, a.geom_p_4326)
    and a.retailer in ('Sainsburys', 'Asda', 'Tesco', 'Morrisons', 'Waitrose', 'Lidl', 'Aldi', 'Co-op')
group by a.retailer