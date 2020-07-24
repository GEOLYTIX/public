select 
	coalesce(sum(pop_15),0) as "15",
	coalesce(sum(pop_16),0) as "16",
	coalesce(sum(pop_17),0) as "17",
	coalesce(sum(pop_18),0) as "18",
	coalesce(sum(pop_19),0) as "19",
	coalesce(sum(pop_20),0) as "20",
	coalesce(sum(pop_21),0) as "21"
from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_oa_metrics oa
on st_intersects(sit.isoline_15min, oa.geom_p_4326)
where sit.id=${id};
