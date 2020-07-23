WITH

min5 AS (
SELECT
    
    (SELECT ROUND(SUM(b.pop_19))
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_geodata_demog_oa b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_5min, b.geom_p_4326)) AS pop_19,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_5min, b.geom_p_4326)
         AND b.retailer IN ('Asda', 'Sainsburys', 'Morrisons', 'Tesco')) as count_big4,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_5min, b.geom_p_4326)
         AND b.retailer IN ('Aldi', 'Lidl')) as count_discounter,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_5min, b.geom_p_4326)
         AND b.retailer IN ('Waitrose', 'Marks and Spencer', 'Booths')) as count_premium
),

min10 AS (
SELECT
    
    (SELECT ROUND(SUM(b.pop_19))
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_geodata_demog_oa b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_10min, b.geom_p_4326)) AS pop_19,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_10min, b.geom_p_4326)
         AND b.retailer IN ('Asda', 'Sainsburys', 'Morrisons', 'Tesco')) as count_big4,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_10min, b.geom_p_4326)
         AND b.retailer IN ('Aldi', 'Lidl')) as count_discounter,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_10min, b.geom_p_4326)
         AND b.retailer IN ('Waitrose', 'Marks and Spencer', 'Booths')) as count_premium
),

min15 AS (
SELECT
    
    (SELECT ROUND(SUM(b.pop_19))
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_geodata_demog_oa b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_15min, b.geom_p_4326)) AS pop_19,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_15min, b.geom_p_4326)
         AND b.retailer IN ('Asda', 'Sainsburys', 'Morrisons', 'Tesco')) as count_big4,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_15min, b.geom_p_4326)
         AND b.retailer IN ('Aldi', 'Lidl')) as count_discounter,

    (SELECT count(retailer)
     FROM mapp.uk_glx_sites a,
          geodata.uk_glx_open_retail_points b
     WHERE a.id = ${id}
         AND ST_INTERSECTS(a.isoline_15min, b.geom_p_4326)
         AND b.retailer IN ('Waitrose', 'Marks and Spencer', 'Booths')) as count_premium
)


SELECT 
    UNNEST( ARRAY [
        'Population 2019',
        'Count Big4',
        'Count Discounter',
        'Count Premium'] ) AS rows,

    UNNEST( ARRAY [
		min5.pop_19,
        min5.count_big4,
        min5.count_discounter,
        min5.count_premium
        ] ) AS min5,

    UNNEST( ARRAY [
		min10.pop_19,
        min10.count_big4,
        min10.count_discounter,
        min10.count_premium
		] ) AS min10,

    UNNEST( ARRAY [
		min15.pop_19,
        min15.count_big4,
        min15.count_discounter,
        min15.count_premium
		] ) AS min15
        
FROM min5,
     min10,
     min15;