select  
	rp.rp_name as "Name",
	rp.rp_type as "Type",
	coalesce(rp.comp_strgh,0) as "Comp Strength",
	est_units as "Estimated Units",
	round(coalesce(est_brands / cast(nullif(est_units,0)as numeric),0) *100) as "% Brands",
 	round(cast(st_distance(sit.geom_4326, rp.geom_4326, true) *0.000621371 as numeric),2) as "Distance (mi)"
from mapp.uk_glx_sites sit
inner join  geodata.uk_glx_geodata_retail_place rp
on st_dwithin(sit.geom_4326, rp.geom_p_4326, 50000, true)
where sit.id = ${id};
order by st_distance(sit.geom_4326, rp.geom_4326, true)
limit 5;

