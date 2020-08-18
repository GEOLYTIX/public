select 
	coalesce(
		round(sum(agriculture*workers)/cast( nullif(sum(workers),0) as numeric), 1)
		,0) as "Agriculture, forestry and fishing",
	coalesce(
		round(sum(mining*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Mining and quarrying",
	coalesce(
		round(sum(manufacturing*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Manufacturing",
	coalesce(
		round(sum(electricity*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Electricity, gas, steam and air conditioning supply",
	coalesce(
		round(sum(water*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Water supply; Sewerage, waste management and remediation activities",
	coalesce(
		round(sum(construction*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Construction",
	coalesce(
		round(sum(wholesale*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Wholesale and retail trade; Repair of motor vehicles and motorcycles",
	coalesce(
		round(sum(transport*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Transportation and storage",
	coalesce(
		round(sum(accommodation*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Accommodation and food service activities",
	coalesce(
		round(sum(it*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Information and communication",
	coalesce(
		round(sum(finance*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Financial and insurance activities",
	coalesce(
		round(sum(real_estate*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Real estate activities",
	coalesce(
		round(sum(professional*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Professional, scientific and technical activities",
	coalesce(
		round(sum(administrative*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Administrative and support service activities",
	coalesce(
		round(sum(public_admin*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Public administration and defence; Compulsory social security",
	coalesce(
		round(sum(education*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Education",
	coalesce(
		round(sum(human_health*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Human health and social work activities",
	coalesce(
		round(sum(arts*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Arts, entertainment and recreation",
	coalesce(
		round(sum(other*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as "Other service activities"

from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_workers_hybrid_zone wor
on st_intersects(st_buffer(sit.geom_4326::geography,500)::geometry, wor.geom_4326)
where sit.id = ${id};