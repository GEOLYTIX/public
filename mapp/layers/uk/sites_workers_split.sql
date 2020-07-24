select 
	coalesce(sum(agriculture/100*workers)/cast( nullif(sum(workers),0) as numeric),0) as "Agriculture",
	coalesce(sum(mining/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Mining",
	coalesce(sum(manufacturing/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Manufacturing",
	coalesce(sum(electricity/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Electricity",
	coalesce(sum(water/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Water",
	coalesce(sum(construction/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Construction",
	coalesce(sum(wholesale/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Wholesale",
	coalesce(sum(transport/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Transport",
	coalesce(sum(accommodation/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Accommodation",
	coalesce(sum(it/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "IT",
	coalesce(sum(finance/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Finance",
	coalesce(sum(real_estate/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Real Estate",
	coalesce(sum(professional/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Professional",
	coalesce(sum(administrative/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Administrative",
	coalesce(sum(public_admin/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Public Admin",
	coalesce(sum(education/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Education",
	coalesce(sum(human_health/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Human Health",
	coalesce(sum(arts/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Arts",
	coalesce(sum(other/100*workers)/cast(nullif(sum(workers),0)as numeric),0) as "Other"
from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_workers_hybrid_zone wor
on st_intersects(st_buffer(sit.geom_4326::geography,500)::geometry, wor.geom_4326)
where sit.id= ${id};


