select 
	coalesce(sum(dwelling_ownhome) / nullif(cast(sum(dwelling_ownhome+dwelling_privaterented+dwelling_socialrented+dwelling_rentfree) as numeric),0),0) as "Owner Occupied",
	coalesce(sum(dwelling_privaterented) / nullif(cast(sum(dwelling_ownhome+dwelling_privaterented+dwelling_socialrented+dwelling_rentfree) as numeric),0),0) as "Renting",
	coalesce(sum(dwelling_socialrented) / nullif(cast(sum(dwelling_ownhome+dwelling_privaterented+dwelling_socialrented+dwelling_rentfree) as numeric),0),0) as "Social",
	coalesce(sum(dwelling_rentfree) / nullif(cast(sum(dwelling_ownhome+dwelling_privaterented+dwelling_socialrented+dwelling_rentfree) as numeric),0),0) as "Rent Free"
from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_oa_metrics oa
on st_intersects(sit.isoline_15min, oa.geom_p_4326)
where sit.id=${id};

