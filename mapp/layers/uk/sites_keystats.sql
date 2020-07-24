WITH

min5 AS (
	
	select
		pop_19,
		pop_24,
		count_big4,
		count_discounter,
		count_premium,
		grocery_demand
		from
	(select 
	 	sit.id,
		ROUND(coalesce(sum(pop_19),0)) as pop_19,
		ROUND(coalesce(sum(pop_24),0)) as pop_24,
		ROUND(coalesce(sum(demand_total),0)) as grocery_demand
	from mapp.uk_glx_sites sit
	left join geodata.uk_glx_geodata_oa_metrics oa
	on st_intersects(sit.isoline_5min, oa.geom_p_4326)
	 group by sit.id
	) demo
	left join (
	select 
		sit.id,
		coalesce(sum(case when retailer in ('Asda', 'Morrisons', 'Sainsburys', 'Tesco') then 1 else 0 end),0 ) as count_big4,
		coalesce(sum(case when retailer in ('Aldi', 'Lidl') then 1 else 0 end),0 ) as count_discounter,
		coalesce(sum(case when retailer in ('Waitrose', 'Marks and Spencer', 'Booths') then 1 else 0 end),0 ) as count_premium
	from mapp.uk_glx_sites sit
	left join geodata.uk_glx_open_retail_points orp
	on st_intersects(sit.isoline_5min, orp.geom_p_4326)
	group by sit.id
	) ret
	on ret.id = demo.id
	where demo.id = ${id}

),

min10 AS (
	
	select
		pop_19,
		pop_24,
		count_big4,
		count_discounter,
		count_premium,
		grocery_demand
		from
	(select 
	 	sit.id,
		ROUND(coalesce(sum(pop_19),0)) as pop_19,
		ROUND(coalesce(sum(pop_24),0)) as pop_24,
		ROUND(coalesce(sum(demand_total),0)) as grocery_demand
	from mapp.uk_glx_sites sit
	left join geodata.uk_glx_geodata_oa_metrics oa
	on st_intersects(sit.isoline_10min, oa.geom_p_4326)
	 group by sit.id
	) demo
	left join (
	select 
		sit.id,
		coalesce(sum(case when retailer in ('Asda', 'Morrisons', 'Sainsburys', 'Tesco') then 1 else 0 end),0 ) as count_big4,
		coalesce(sum(case when retailer in ('Aldi', 'Lidl') then 1 else 0 end),0 ) as count_discounter,
		coalesce(sum(case when retailer in ('Waitrose', 'Marks and Spencer', 'Booths') then 1 else 0 end),0 ) as count_premium
	from mapp.uk_glx_sites sit
	left join geodata.uk_glx_open_retail_points orp
	on st_intersects(sit.isoline_10min, orp.geom_p_4326)
	group by sit.id
	) ret
	on ret.id = demo.id
	where demo.id = ${id}

),

min15 AS (
	
	select
		pop_19,
		pop_24,
		count_big4,
		count_discounter,
		count_premium,
		grocery_demand
		from
	(select 
	 	sit.id,
		ROUND(coalesce(sum(pop_19),0)) as pop_19,
		ROUND(coalesce(sum(pop_24),0)) as pop_24,
		ROUND(coalesce(sum(demand_total),0)) as grocery_demand
	from mapp.uk_glx_sites sit
	left join geodata.uk_glx_geodata_oa_metrics oa
	on st_intersects(sit.isoline_15min, oa.geom_p_4326)
	 group by sit.id
	) demo
	left join (
	select 
		sit.id,
		coalesce(sum(case when retailer in ('Asda', 'Morrisons', 'Sainsburys', 'Tesco') then 1 else 0 end),0 ) as count_big4,
		coalesce(sum(case when retailer in ('Aldi', 'Lidl') then 1 else 0 end),0 ) as count_discounter,
		coalesce(sum(case when retailer in ('Waitrose', 'Marks and Spencer', 'Booths') then 1 else 0 end),0 ) as count_premium
	from mapp.uk_glx_sites sit
	left join geodata.uk_glx_open_retail_points orp
	on st_intersects(sit.isoline_15min, orp.geom_p_4326)
	group by sit.id
	) ret
	on ret.id = demo.id
	where demo.id = ${id}

)


SELECT 
    UNNEST( ARRAY [
        'Population 2019',
		'Population 2024',
        'Count Big4',
        'Count Discounter',
        'Count Premium',
		'Grocery Demand'] ) AS rows,

    UNNEST( ARRAY [
		min5.pop_19,
		min5.pop_24,
        min5.count_big4,
        min5.count_discounter,
        min5.count_premium,
		min5.grocery_demand
        ] ) AS min5,

    UNNEST( ARRAY [
		min10.pop_19,
		min10.pop_24,
        min10.count_big4,
        min10.count_discounter,
        min10.count_premium,
		min10.grocery_demand
		] ) AS min10,

    UNNEST( ARRAY [
		min15.pop_19,
		min15.pop_24,
        min15.count_big4,
        min15.count_discounter,
        min15.count_premium,
		min15.grocery_demand
		] ) AS min15
        
FROM min5,
     min10,
     min15;