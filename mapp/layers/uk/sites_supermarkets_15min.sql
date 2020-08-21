select  
	rp.store_name,
    rp.fascia,
    rp.size_sqft,
 	round(cast(st_distance(sit.geom_4326, rp.geom_p_4326, true) * 0.000621371 as numeric),2) as "distance"
from mapp.uk_glx_sites sit
inner join  geodata.uk_glx_open_retail_points rp
on st_intersects(sit.isoline_15min, rp.geom_p_4326)
and rp.store_type = 'Supermarket'
where sit.id = ${id}
order by st_distance(sit.geom_4326, rp.geom_p_4326, true);