select 
	sto.store_name as "Name",
	sto.fascia as "Fascia",
  	round(cast(st_distance(sit.geom_4326, sto.geom_p_4326, true) *0.000621371 as numeric),2) as "Distance (mi)",
	case size_band
		when '30,138 ft2 > (2,800 m2)' then '>30k'
		when '15,069 < 30,138 ft2 (1,400 < 2,800 m2)'  then '15-30k'
		when '< 3,013 ft2 (280m2)' then '<3k'
		when '3,013 < 15,069 ft2 (280 < 1,400 m2)' then '3-15k'
	end as "Size (sq ft)",
	case 
		when st_intersects(sit.isoline_5min, sto.geom_p_4326) then '0-5 mins' 
		when st_intersects(sit.isoline_10min, sto.geom_p_4326) then '5-10 mins' 
		when st_intersects(sit.isoline_15min, sto.geom_p_4326) then '10-15 mins' 
	end as "Dt Band"
from mapp.uk_glx_sites sit
left join geodata.uk_glx_open_retail_points sto
on st_intersects(sit.isoline_15min, sto.geom_p_4326)
where sit.id =  ${id}
and sto.size_band ='< 3,013 ft2 (280m2)'
order by st_distance(sit.geom_4326, sto.geom_p_4326, true)
limit 5;