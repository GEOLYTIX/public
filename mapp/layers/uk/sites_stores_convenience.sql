select 
	sto.store_name,
	sto.fascia,
    sto.size_sqft,
  	round(cast(st_distance(sit.geom_4326, sto.geom_p_4326, true) *0.000621371 as numeric),2) as "distance",
	case 
		when st_intersects(sit.isoline_5min, sto.geom_p_4326) then '0-5 mins' 
		when st_intersects(sit.isoline_10min, sto.geom_p_4326) then '5-10 mins' 
		when st_intersects(sit.isoline_15min, sto.geom_p_4326) then '10-15 mins' 
	end as "band"
from mapp.uk_glx_sites sit
left join geodata.uk_glx_open_retail_points sto
on st_intersects(sit.isoline_15min, sto.geom_p_4326)
and sto.store_type = 'Convenience'
where sit.id =  ${id}
and sto.size_band <>'< 3,013 ft2 (280m2)'
order by st_distance(sit.geom_4326, sto.geom_p_4326, true);