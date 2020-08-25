select 
	coalesce(
		round(sum(agriculture*workers)/cast( nullif(sum(workers),0) as numeric), 1)
		,0) as "Agriculture",
	coalesce(
		round(sum(mining*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Mining",
	coalesce(
		round(sum(manufacturing*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Manufacturing",
	coalesce(
		round(sum(electricity*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Electricity",
	coalesce(
		round(sum(water*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Water",
	coalesce(
		round(sum(construction*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Construction",
	coalesce(
		round(sum(wholesale*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Wholesale",
	coalesce(
		round(sum(transport*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Transport",
	coalesce(
		round(sum(accommodation*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Accommodation",
	coalesce(
		round(sum(it*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "IT",
	coalesce(
		round(sum(finance*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Finance",
	coalesce(
		round(sum(real_estate*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Real Estate",
	coalesce(
		round(sum(professional*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Professional",
	coalesce(
		round(sum(administrative*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Administrative",
	coalesce(
		round(sum(public_admin*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Public Admin",
	coalesce(
		round(sum(education*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Education",
	coalesce(
		round(sum(human_health*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Human Health",
	coalesce(
		round(sum(arts*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Arts",
	coalesce(
		round(sum(other*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Other"

from mapp.uk_polygons
left join geodata.uk_glx_geodata_workers_hybrid_zone
on st_intersects(mapp.uk_polygons.geom_3857, geodata.uk_glx_geodata_workers_hybrid_zone.geom_3857)
where mapp.uk_polygons.id = ${id};