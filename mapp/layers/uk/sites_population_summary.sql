WITH 

min5 AS (
    SELECT (SUM(b.pop_19))::integer AS pop_19,
        (SUM(b.pop_11))::integer AS pop_11,
        (SUM(b.pop_19 - b.pop_11)::numeric * 100 / SUM(b.pop_11)::numeric) AS pop_growth,
        (SUM(b.students))::integer AS students,
        (100 * (SUM(pop_11) - SUM(white))::numeric / SUM(pop_11))::numeric AS non_white,
        (100 * SUM(dwelling_ownhome) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS own_home,
        (100 * SUM(dwelling_privaterented) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS private_rented,
        (100 * SUM(dwelling_socialrented) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS social_rented,
        (100 * SUM(pers1hhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS single_hhds,
        (100 * SUM(pers2hhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS hhds_two_ppl,
        (100 * SUM(pers2plushhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS hhds_3plus
    FROM mapp.uk_glx_sites a,
        geodata.uk_glx_geodata_demog_oa b
    WHERE a.id = ${id} 
        AND ST_INTERSECTS(a.isoline_5min, b.geom_p_4326)
),

min10 AS (
    SELECT (SUM(b.pop_19))::integer AS pop_19,
        (SUM(b.pop_11))::integer AS pop_11,
        (SUM(b.pop_19 - b.pop_11)::numeric * 100 / SUM(b.pop_11)::numeric) AS pop_growth,
        (SUM(b.students))::integer AS students,
        (100 * (SUM(pop_11) - SUM(white))::numeric / SUM(pop_11))::numeric AS non_white,
        (100 * SUM(dwelling_ownhome) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS own_home,
        (100 * SUM(dwelling_privaterented) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS private_rented,
        (100 * SUM(dwelling_socialrented) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS social_rented,
        (100 * SUM(pers1hhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS single_hhds,
        (100 * SUM(pers2hhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS hhds_two_ppl,
        (100 * SUM(pers2plushhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS hhds_3plus
    FROM mapp.uk_glx_sites a,
        geodata.uk_glx_geodata_demog_oa b
    WHERE a.id = ${id}
        AND ST_INTERSECTS(a.isoline_10min, b.geom_p_4326)
),

min15 AS (
    SELECT (SUM(b.pop_19))::integer AS pop_19,
        (SUM(b.pop_11))::integer AS pop_11,
        (SUM(b.pop_19 - b.pop_11)::numeric * 100 / SUM(b.pop_11)::numeric) AS pop_growth,
        (SUM(b.students))::integer AS students,
        (100 * (SUM(pop_11) - SUM(white))::numeric / SUM(pop_11))::numeric AS non_white,
        (100 * SUM(dwelling_ownhome) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS own_home,
        (100 * SUM(dwelling_privaterented) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS private_rented,
        (100 * SUM(dwelling_socialrented) / SUM(dwelling_ownhome + dwelling_privaterented + dwelling_socialrented))::integer AS social_rented,
        (100 * SUM(pers1hhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS single_hhds,
        (100 * SUM(pers2hhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS hhds_two_ppl,
        (100 * SUM(pers2plushhd) / SUM(pers1hhd + pers2hhd + pers2plushhd))::integer AS hhds_3plus
    FROM mapp.uk_glx_sites a,
        geodata.uk_glx_geodata_demog_oa b
    WHERE a.id = ${id}
        AND ST_INTERSECTS(a.isoline_15min, b.geom_p_4326)
)
      
SELECT UNNEST( ARRAY ['Current Population'
					  ,'Population 2011'
					  ,'Population Growth'
					  ,'Students'
					  ,'% BAME'
					  ,'Own Home'
					  ,'Private Rented'
					  ,'Social Rented'
					  ,'Single Hhds'
					  ,'2 Person Hhds'
					  ,'3+ Hhds'] ) AS rows,
       UNNEST( ARRAY [min5.pop_19
					  ,min5.pop_11
					  ,min5.pop_growth
					  ,min5.students
					  ,min5.non_white
					  ,min5.own_home
					  ,min5.private_rented
					  ,min5.social_rented
					  ,min5.single_hhds
					  ,min5.hhds_two_ppl
					  ,min5.hhds_3plus]) AS min5,
       UNNEST( ARRAY [min10.pop_19
					  ,min10.pop_11
					  ,min10.pop_growth
					  ,min10.students
					  ,min10.non_white
					  ,min10.own_home
					  ,min10.private_rented
					  ,min10.social_rented
					  ,min10.single_hhds
					  ,min10.hhds_two_ppl
					  ,min10.hhds_3plus]) AS min10,
       UNNEST( ARRAY [min15.pop_19
					  ,min15.pop_11
					  ,min15.pop_growth
					  ,min15.students
					  ,min15.non_white
					  ,min15.own_home
					  ,min15.private_rented
					  ,min15.social_rented
					  ,min15.single_hhds
					  ,min15.hhds_two_ppl
					  ,min15.hhds_3plus]) AS min15
FROM min5,
     min10,
     min15;