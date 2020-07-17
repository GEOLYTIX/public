WITH min5 AS (
    SELECT (round(SUM(abhrp)))::integer AS sg_ab,
           (round(SUM(c1hrp)))::integer AS sg_c1,
           (round(SUM(c2hrp)))::integer AS sg_c2,
           (round(SUM(dehrp)))::integer AS sg_de,
           (round(SUM(abhrp + c1hrp + c2hrp + c2hrp)))::integer AS sg_total
    FROM live.house_list_site a,
         geodata.uk_glx_geodata_demog_oa b
    WHERE a.id = ${id}
      AND ST_INTERSECTS(a.isoline_5min, b.geom_p_4326)),
     min10 AS (
         SELECT (round(SUM(abhrp)))::integer AS sg_ab,
           (round(SUM(c1hrp)))::integer AS sg_c1,
           (round(SUM(c2hrp)))::integer AS sg_c2,
           (round(SUM(dehrp)))::integer AS sg_de,
           (round(SUM(abhrp + c1hrp + c2hrp + dehrp)))::integer AS sg_total
         FROM live.house_list_site a,
              geodata.uk_glx_geodata_demog_oa b
         WHERE a.id = ${id}
           AND ST_INTERSECTS(a.isoline_10min, b.geom_p_4326)),
     min15 AS (
         SELECT (round(SUM(abhrp)))::integer AS sg_ab,
           (round(SUM(c1hrp)))::integer AS sg_c1,
           (round(SUM(c2hrp)))::integer AS sg_c2,
           (round(SUM(dehrp)))::integer AS sg_de,
           (round(SUM(abhrp + c1hrp + c2hrp + dehrp)))::integer AS sg_total,
			SUM(abhrp)/SUM(abhrp + c1hrp + c2hrp + dehrp)::numeric AS sg_ab_p,
           	SUM(c1hrp)/SUM(abhrp + c1hrp + c2hrp + dehrp)::numeric AS sg_c1_p,
           	SUM(c2hrp)/SUM(abhrp + c1hrp + c2hrp + dehrp)::numeric AS sg_c2_p,
           	SUM(dehrp)/SUM(abhrp + c1hrp + c2hrp + dehrp)::numeric AS sg_de_p
         FROM live.house_list_site a,
              geodata.uk_glx_geodata_demog_oa b
         WHERE a.id = ${id}
           AND ST_INTERSECTS(a.isoline_15min, b.geom_p_4326)),
     uk AS (SELECT social_grade_ab_uk/(social_grade_total_uk)::numeric as sg_ab_uk_p,
                   social_grade_c1_uk/(social_grade_total_uk)::numeric as sg_c1_uk_p,
                   social_grade_c2_uk/(social_grade_total_uk)::numeric as sg_c2_uk_p,
                   social_grade_de_uk/(social_grade_total_uk)::numeric as sg_de_uk_p
            FROM geodata.uk_glx_geodata_demog_national_totals)
SELECT UNNEST(
               ARRAY ['AB','C1','C2','DE','Total']
           )  AS rows,
       UNNEST(
               ARRAY [min5.sg_ab
					  ,min5.sg_c1
					  ,min5.sg_c2
					  ,min5.sg_de
					  ,min5.sg_total]) AS min5,
       UNNEST(
               ARRAY [min10.sg_ab
					  ,min10.sg_c1
					  ,min10.sg_c2
					  ,min10.sg_de
					  ,min10.sg_total]
	   ) AS min10,
       UNNEST(
               ARRAY [min15.sg_ab
					  ,min15.sg_c1
					  ,min15.sg_c2
					  ,min15.sg_de
					  ,min15.sg_total]
	   ) AS min15,
       UNNEST(
               ARRAY [
				   round(100 * min15.sg_ab_p),
				   round(100 * min15.sg_c1_p),
				   round(100 * min15.sg_c2_p),
				   round(100 * min15.sg_de_p)
			   ]
	   ) AS share15,
       UNNEST(
               ARRAY [round(uk.sg_ab_uk_p *100)
					  ,round(uk.sg_c1_uk_p *100)
					  ,round(uk.sg_c2_uk_p *100)
					  ,round(uk.sg_de_uk_p *100)
					  ]
	   ) AS sg_uk_total,
       UNNEST(ARRAY [
		   round(case when (100 * min15.sg_ab_p) / uk.sg_ab_uk_p < 100 
 				then 100 - (100 * min15.sg_ab_p) / uk.sg_ab_uk_p
                else 0 end),
			round(case when (100 * min15.sg_c1_p) / uk.sg_c1_uk_p < 100 
 				then 100 - (100 * min15.sg_c1_p) / uk.sg_c1_uk_p
                else 0 end),
			round(case when (100 * min15.sg_c2_p) / uk.sg_c2_uk_p < 100 
 				then 100 - (100 * min15.sg_c2_p) / uk.sg_c2_uk_p
                else 0 end),
			round(case when (100 * min15.sg_de_p) / uk.sg_de_uk_p < 100 
 				then 100 - (100 * min15.sg_de_p) / uk.sg_de_uk_p
                else 0 end)
			]
		)    AS sg_under_indexer,
       UNNEST(ARRAY [
		   round(case when (100 * min15.sg_ab_p) / uk.sg_ab_uk_p >= 100 
 				then ((100 * min15.sg_ab_p) / uk.sg_ab_uk_p) - 100
                else 0 end),
		   round(case when (100 * min15.sg_c1_p) / uk.sg_c1_uk_p >= 100 
 				then ((100 * min15.sg_c1_p) / uk.sg_c1_uk_p) - 100
                else 0 end),
		   round(case when (100 * min15.sg_c2_p) / uk.sg_c2_uk_p >= 100 
 				then ((100 * min15.sg_c2_p) / uk.sg_c2_uk_p) - 100
                else 0 end),
		   round(case when (100 * min15.sg_de_p) / uk.sg_de_uk_p >= 100 
 				then ((100 * min15.sg_de_p) / uk.sg_de_uk_p) - 100
                else 0 end)
		  	]
		) AS sg_over_indexer,
       UNNEST(ARRAY [
		   round((100 * min15.sg_ab_p) / uk.sg_ab_uk_p),
		   round((100 * min15.sg_c1_p) / uk.sg_c1_uk_p),
		   round((100 * min15.sg_c2_p) / uk.sg_c2_uk_p),
		   round((100 * min15.sg_de_p) / uk.sg_de_uk_p)
		  ]
			 ) AS sg_index_value
FROM min5,
     min10,
     min15,
     uk;