WITH

min15 AS (
    SELECT round((sum(oac_sg_1)/sum(pop_11)),2) oac_sg_1,
        round((sum(oac_sg_2)/sum(pop_11)),2) oac_sg_2,
        round((sum(oac_sg_3)/sum(pop_11)),2) oac_sg_3,
        round((sum(oac_sg_4)/sum(pop_11)),2) oac_sg_4,
        round((sum(oac_sg_5)/sum(pop_11)),2) oac_sg_5,
        round((sum(oac_sg_6)/sum(pop_11)),2) oac_sg_6,
        round((sum(oac_sg_7)/sum(pop_11)),2) oac_sg_7,
        round((sum(oac_sg_8)/sum(pop_11)),2) oac_sg_8
    FROM mapp.uk_glx_sites a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b
    WHERE a.id = ${id}
        AND ST_INTERSECTS(a.isoline_15min, b.geom_4326)
),

uk AS (
    SELECT round((sum(oac_sg_1)/sum(pop_11)),2) oac_sg_1,
        round((sum(oac_sg_2)/sum(pop_11)),2) oac_sg_2,
        round((sum(oac_sg_3)/sum(pop_11)),2) oac_sg_3,
        round((sum(oac_sg_4)/sum(pop_11)),2) oac_sg_4,
        round((sum(oac_sg_5)/sum(pop_11)),2) oac_sg_5,
        round((sum(oac_sg_6)/sum(pop_11)),2) oac_sg_6,
        round((sum(oac_sg_7)/sum(pop_11)),2) oac_sg_7,
        round((sum(oac_sg_8)/sum(pop_11)),2) oac_sg_8
    FROM geodata.uk_glx_geodata_seamless_shopper_town_metrics
)


SELECT UNNEST( ARRAY ['Min 15', 'UK'] ) AS rows,

       UNNEST( ARRAY [min15.oac_sg_1, uk.oac_sg_1 ] ) AS oac_sg_1,

       UNNEST( ARRAY [min15.oac_sg_2, uk.oac_sg_2 ] ) AS oac_sg_2,

       UNNEST( ARRAY [min15.oac_sg_3, uk.oac_sg_3 ] ) AS oac_sg_3,

       UNNEST( ARRAY [min15.oac_sg_4, uk.oac_sg_4 ] ) AS oac_sg_4,

       UNNEST( ARRAY [min15.oac_sg_5, uk.oac_sg_5 ] ) AS oac_sg_5,

       UNNEST( ARRAY [min15.oac_sg_6, uk.oac_sg_6 ] ) AS oac_sg_6,

       UNNEST( ARRAY [min15.oac_sg_7, uk.oac_sg_7 ] ) AS oac_sg_7,

       UNNEST( ARRAY [min15.oac_sg_8, uk.oac_sg_8 ] ) AS oac_sg_8

FROM min15,
     uk;