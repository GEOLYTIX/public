WITH min5 AS (
    SELECT (round(SUM(age0to18))) AS age_under_18,
           (round(SUM(age18to24))) AS age_18to24,
           (round(SUM(age25to29))) AS age_25to29,
           (round(SUM(age30to44))) AS age_30to44,
           (round(SUM(age45to59))) AS age_45to59,
           (round(SUM(age60plus))) AS age_60plus,
           (round(SUM(pop_11))) AS age_profile_total
    FROM live.house_list_site a,
         geodata.uk_glx_geodata_demog_oa b
    WHERE a.id = ${id}
      AND ST_INTERSECTS(a.isoline_5min, b.geom_p_4326))
	  ,
     min10 AS (
         SELECT (round(SUM(age0to18))) AS age_under_18,
           (round(SUM(age18to24))) AS age_18to24,
           (round(SUM(age25to29))) AS age_25to29,
           (round(SUM(age30to44))) AS age_30to44,
           (round(SUM(age45to59))) AS age_45to59,
           (round(SUM(age60plus))) AS age_60plus,
           (round(SUM(pop_11))) AS age_profile_total
         FROM live.house_list_site a,
              geodata.uk_glx_geodata_demog_oa b
         WHERE a.id = ${id}
           AND ST_INTERSECTS(a.isoline_10min, b.geom_p_4326))
	,
     min15 AS (
         SELECT (round(SUM(age0to18))) AS age_under_18,
           	(round(SUM(age18to24))) AS age_18to24,
           	(round(SUM(age25to29))) AS age_25to29,
           	(round(SUM(age30to44))) AS age_30to44,
           	(round(SUM(age45to59))) AS age_45to59,
           	(round(SUM(age60plus))) AS age_60plus,
           	(round(SUM(pop_11))) AS age_profile_total,
			SUM(age0to18)/SUM(pop_11)::numeric AS age_under_18_p,
           	SUM(age18to24)/SUM(pop_11)::numeric AS age_18to24_p,
           	SUM(age25to29)/SUM(pop_11)::numeric AS age_25to29_p,
           	SUM(age30to44)/SUM(pop_11)::numeric AS age_30to44_p,
           	SUM(age45to59)/SUM(pop_11)::numeric AS age_45to59_p,
           	SUM(age60plus)/SUM(pop_11)::numeric AS age_60plus_p 
         FROM live.house_list_site a,
              geodata.uk_glx_geodata_demog_oa b
         WHERE a.id = ${id}
           AND ST_INTERSECTS(a.isoline_15min, b.geom_p_4326))
	,
     uk AS (SELECT age_under_18_uk/age_total_uk::numeric age_under_18_uk_p,
                   age_18to24_uk/age_total_uk::numeric age_18to24_uk_p,
                   age_25to29_uk/age_total_uk::numeric age_25to29_uk_p,
                   age_30to44_uk/age_total_uk::numeric age_30to44_uk_p,
                   age_45to59_uk/age_total_uk::numeric age_45to59_uk_p,
                   age_60plus_uk/age_total_uk::numeric age_60plus_uk_p
			FROM geodata.uk_glx_geodata_demog_national_totals)
SELECT 
UNNEST(
               ARRAY ['< 18'
					  ,'18 to 24'
					  ,'25 to 29'
					  ,'30 to 44'
					  ,'45 to 59'
					  ,'60+'
					  ,'Total']
           )  AS rows,
    UNNEST(
               ARRAY [
				  min5.age_under_18,
				  min5.age_18to24,
				  min5.age_25to29,
				  min5.age_30to44,
				  min5.age_45to59,
				  min5.age_60plus,
				  min5.age_profile_total
					]
			) AS min5,
     UNNEST(
               ARRAY [
				  min10.age_under_18,
				  min10.age_18to24,
				  min10.age_25to29,
				  min10.age_30to44,
				  min10.age_45to59,
				  min10.age_60plus,
				  min10.age_profile_total
					]
  			) AS min10,
     UNNEST(
               ARRAY [
				  min15.age_under_18,
				  min15.age_18to24,
				  min15.age_25to29,
				  min15.age_30to44,
				  min15.age_45to59,
				  min15.age_60plus,
				  min15.age_profile_total
					]
			) AS min15,
      UNNEST(
               ARRAY [
				  round(100 * min15.age_under_18_p),
				  round(100 * min15.age_18to24_p),
				  round(100 * min15.age_25to29_p),
				  round(100 * min15.age_30to44_p),
				  round(100 * min15.age_45to59_p),
				  round(100 * min15.age_60plus_p)
   					]
   			) AS share15,
      UNNEST(
               ARRAY [
				   round(uk.age_under_18_uk_p *100)
				  ,round(uk.age_18to24_uk_p * 100)
				  ,round(uk.age_25to29_uk_p * 100)
				  ,round(uk.age_30to44_uk_p * 100)
				  ,round(uk.age_45to59_uk_p * 100)
				  ,round(uk.age_60plus_uk_p * 100)
				  
					]
       		) AS age_uk_total,
      UNNEST(ARRAY [
   			round(case when (100 * min15.age_under_18_p) / uk.age_under_18_uk_p < 100 
 				then 100 - (100 * min15.age_under_18_p) / uk.age_under_18_uk_p
                else 0 end),
   			round(case when (100 * min15.age_18to24_p) / uk.age_18to24_uk_p < 100 
   				then 100 -  (100 * min15.age_18to24_p) / uk.age_18to24_uk_p
                else 0 end),
   			round(case when (100 * min15.age_25to29_p) / uk.age_25to29_uk_p < 100 
				then 100 -  (100 * min15.age_25to29_p) / uk.age_25to29_uk_p
                else 0 end),
   			round(case when  (100 * min15.age_30to44_p) / uk.age_30to44_uk_p < 100 
   				then 100 -  (100 * min15.age_30to44_p) / uk.age_30to44_uk_p
                else 0 end),
   			round(case when  (100 * min15.age_45to59_p) / uk.age_45to59_uk_p < 100
                then 100 -  (100 * min15.age_45to59_p) / uk.age_45to59_uk_p
                else 0 end),
   			round(case when  (100 * min15.age_60plus_p) / uk.age_60plus_uk_p < 100
               	then 100 -  (100 * min15.age_60plus_p) / uk.age_60plus_uk_p                                                                                                                                
   				else 0 end)
   			]
		)    AS age_under_indexer,
       UNNEST(ARRAY [
   			round(case when (100 * min15.age_under_18_p) / uk.age_under_18_uk_p >= 100 
 				then ((100 * min15.age_under_18_p) / uk.age_under_18_uk_p) - 100
                else 0 end),
   			round(case when (100 * min15.age_18to24_p) / uk.age_18to24_uk_p >= 100 
   				then ((100 * min15.age_18to24_p) / uk.age_18to24_uk_p) - 100
                else 0 end),
   			round(case when (100 * min15.age_25to29_p) / uk.age_25to29_uk_p >= 100 
   				then ((100 * min15.age_25to29_p) / uk.age_25to29_uk_p) - 100
                else 0 end),
   			round(case when (100 * min15.age_30to44_p) /  uk.age_30to44_uk_p >= 100 
   				then ((100 * min15.age_30to44_p) / uk.age_30to44_uk_p) - 100
                else 0 end),
   			round(case when (100 * min15.age_45to59_p) / uk.age_45to59_uk_p >= 100
               	then ((100 * min15.age_45to59_p) / uk.age_45to59_uk_p) - 100
                else 0 end),
   			round(case when (100 * min15.age_60plus_p) / uk.age_60plus_uk_p >= 100
                then ((100 * min15.age_60plus_p) / uk.age_60plus_uk_p) - 100
                else 0 end)
   			]
		) AS age_over_indexer,
       UNNEST(ARRAY [
		   round((100 * min15.age_under_18_p) / uk.age_under_18_uk_p),
		   round((100 * min15.age_18to24_p) / uk.age_18to24_uk_p),
		   round((100 * min15.age_25to29_p) / uk.age_25to29_uk_p),
		   round((100 * min15.age_30to44_p) / uk.age_30to44_uk_p),
		   round((100 * min15.age_45to59_p) / uk.age_45to59_uk_p),
		   round((100 * min15.age_60plus_p) / uk.age_60plus_uk_p)
		   ]
	) AS age_index_value
FROM min5,
     min10,
     min15,
     uk;