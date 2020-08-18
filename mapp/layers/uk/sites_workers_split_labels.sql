with tab as (
select 
	coalesce(
		round(sum(agriculture*workers)/cast( nullif(sum(workers),0) as numeric), 1)
		,0) as agriculture,
	coalesce(
		round(sum(mining*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as mining,
	coalesce(
		round(sum(manufacturing*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as manufacturing,
	coalesce(
		round(sum(electricity*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as electricity,
	coalesce(
		round(sum(water*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as water,
	coalesce(
		round(sum(construction*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as construction,
	coalesce(
		round(sum(wholesale*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as wholesale,
	coalesce(
		round(sum(transport*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as transport,
	coalesce(
		round(sum(accommodation*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as accommodation,
	coalesce(
		round(sum(it*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as it,
	coalesce(
		round(sum(finance*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as finance,
	coalesce(
		round(sum(real_estate*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as real_estate,
	coalesce(
		round(sum(professional*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as professional,
	coalesce(
		round(sum(administrative*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as administrative,
	coalesce(
		round(sum(public_admin*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as public_admin,
	coalesce(
		round(sum(education*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as education,
	coalesce(
		round(sum(human_health*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as human_health,
	coalesce(
		round(sum(arts*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as arts,
	coalesce(
		round(sum(other*workers)/cast(nullif(sum(workers),0) as numeric), 1)
		,0) as other

from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_workers_hybrid_zone wor
on st_intersects(st_buffer(sit.geom_4326::geography,500)::geometry, wor.geom_4326)
where sit.id = ${id})

SELECT 
    UNNEST( ARRAY [
        'Agriculture, forestry and fishing',
		'Mining and quarrying',
		'Manufacturing',
		'Electricity, gas, steam and air conditioning supply',
		'Water supply; Sewerage, waste management and remediation activities',
		'Construction',
		'Wholesale and retail trade; Repair of motor vehicles and motorcycles',
		'Transportation and storage',
		'Accommodation and food service activities',
		'Information and communication',
		'Financial and insurance activities',
		'Real estate activities',
		'Professional, scientific and technical activities',
		'Administrative and support service activities',
		'Public administration and defence; Compulsory social security',
		'Education',
		'Human health and social work activities',
		'Arts, entertainment and recreation',
		'Other service activities'] ) AS label,

    UNNEST( ARRAY [
		tab.agriculture,
		tab.mining,
		tab.manufacturing,
		tab.electricity,
		tab.water,
		tab.construction,
		tab.wholesale,
		tab.transport,
		tab.accommodation,
		tab.it,
		tab.finance,
		tab.real_estate,
		tab.professional,
		tab.administrative,
		tab.public_admin,
		tab.education,
		tab.human_health,
		tab.arts,
		tab.other
        ] ) AS val
        
FROM tab;