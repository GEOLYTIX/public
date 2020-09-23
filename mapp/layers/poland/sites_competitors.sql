WITH min5 AS (
    SELECT sum(case when b.st_fascia = 'ABC' then 1 else 0 end)            AS ABC,
           sum(case when b.st_fascia = 'Aldi' then 1 else 0 end)           AS Aldi,
           sum(case when b.st_fascia = 'Auchan' then 1 else 0 end)         AS Auchan,
           sum(case when b.st_fascia = 'Biedronka' then 1 else 0 end)      AS Biedronka,
           sum(case when b.st_fascia = 'Carrefour' then 1 else 0 end)      AS Carrefour,
           sum(case when b.st_fascia = 'Delikatesy Centrum' then 1 else 0 end)          AS "Delikatesy Centrum",
           sum(case when b.st_fascia = 'Dino' then 1 else 0 end)           AS Dino,
           sum(case when b.st_fascia = 'Groszek' then 1 else 0 end)        AS Groszek,
           sum(case when b.st_fascia = 'Kaufland' then 1 else 0 end)       AS Kaufland,
           sum(case when b.st_fascia = 'Lidl' then 1 else 0 end)           AS Lidl,
           sum(case when b.st_fascia = 'Lewiatan' then 1 else 0 end)       AS Lewiatan,
           sum(case when b.st_fascia = 'Netto' then 1 else 0 end)          AS Netto,
           sum(case when b.st_fascia = 'Odido' then 1 else 0 end)          AS Odido,
           sum(case when b.st_fascia = 'Społem' then 1 else 0 end)         AS Społem,
           sum(case when b.st_fascia = 'Stokrotka' then 1 else 0 end)      AS Stokrotka,
           sum(case when b.st_fascia = 'Tesco' then 1 else 0 end)          AS Tesco,
           sum(case when b.st_fascia = 'Żabka' then 1 else 0 end)          AS Żabka,
           count(*)                                                        AS Total
    FROM mapp.pol_mapp_sites a,
         geodata.pol_glx_geodata_retail_points b
    WHERE ST_INTERSECTS(a.isoline_5min, b.geom_p_4326)
      AND a.id = ${id}
      AND b.st_fascia in (
                          'ABC',
                          'Aldi',
                          'Auchan',
                          'Biedronka',
                          'Carrefour',
                          'Delikatesy Centrum',
                          'Dino',
                          'Groszek',
                          'Kaufland',
                          'Lidl',
                          'Lewiatan',
                          'Netto',
                          'Odido',
                          'Społem',
                          'Stokrotka',
                          'Tesco',
                          'Żabka'
        )
),
     min10 AS (
         SELECT sum(case when b.st_fascia = 'ABC' then 1 else 0 end)            AS ABC,
           sum(case when b.st_fascia = 'Aldi' then 1 else 0 end)           AS Aldi,
           sum(case when b.st_fascia = 'Auchan' then 1 else 0 end)         AS Auchan,
           sum(case when b.st_fascia = 'Biedronka' then 1 else 0 end)      AS Biedronka,
           sum(case when b.st_fascia = 'Carrefour' then 1 else 0 end)      AS Carrefour,
           sum(case when b.st_fascia = 'Delikatesy Centrum' then 1 else 0 end)          AS "Delikatesy Centrum",
           sum(case when b.st_fascia = 'Dino' then 1 else 0 end)           AS Dino,
           sum(case when b.st_fascia = 'Groszek' then 1 else 0 end)        AS Groszek,
           sum(case when b.st_fascia = 'Kaufland' then 1 else 0 end)       AS Kaufland,
           sum(case when b.st_fascia = 'Lidl' then 1 else 0 end)           AS Lidl,
           sum(case when b.st_fascia = 'Lewiatan' then 1 else 0 end)       AS Lewiatan,
           sum(case when b.st_fascia = 'Netto' then 1 else 0 end)          AS Netto,
           sum(case when b.st_fascia = 'Odido' then 1 else 0 end)          AS Odido,
           sum(case when b.st_fascia = 'Społem' then 1 else 0 end)         AS Społem,
           sum(case when b.st_fascia = 'Stokrotka' then 1 else 0 end)      AS Stokrotka,
           sum(case when b.st_fascia = 'Tesco' then 1 else 0 end)          AS Tesco,
           sum(case when b.st_fascia = 'Żabka' then 1 else 0 end)          AS Żabka,
           count(*)                                                        AS Total
         FROM mapp.pol_mapp_sites a,
              geodata.pol_glx_geodata_retail_points b
         WHERE ST_INTERSECTS(a.isoline_10min, b.geom_p_4326)
           AND a.id = ${id}
           AND b.st_fascia in (
                          'ABC',
                          'Aldi',
                          'Auchan',
                          'Biedronka',
                          'Carrefour',
                          'Delikatesy Centrum',
                          'Dino',
                          'Groszek',
                          'Kaufland',
                          'Lidl',
                          'Lewiatan',
                          'Netto',
                          'Odido',
                          'Społem',
                          'Stokrotka',
                          'Tesco',
                          'Żabka'
        )
     ),
     min15 AS (
         SELECT sum(case when b.st_fascia = 'ABC' then 1 else 0 end)            AS ABC,
           sum(case when b.st_fascia = 'Aldi' then 1 else 0 end)           AS Aldi,
           sum(case when b.st_fascia = 'Auchan' then 1 else 0 end)         AS Auchan,
           sum(case when b.st_fascia = 'Biedronka' then 1 else 0 end)      AS Biedronka,
           sum(case when b.st_fascia = 'Carrefour' then 1 else 0 end)      AS Carrefour,
           sum(case when b.st_fascia = 'Delikatesy Centrum' then 1 else 0 end)          AS "Delikatesy Centrum",
           sum(case when b.st_fascia = 'Dino' then 1 else 0 end)           AS Dino,
           sum(case when b.st_fascia = 'Groszek' then 1 else 0 end)        AS Groszek,
           sum(case when b.st_fascia = 'Kaufland' then 1 else 0 end)       AS Kaufland,
           sum(case when b.st_fascia = 'Lidl' then 1 else 0 end)           AS Lidl,
           sum(case when b.st_fascia = 'Lewiatan' then 1 else 0 end)       AS Lewiatan,
           sum(case when b.st_fascia = 'Netto' then 1 else 0 end)          AS Netto,
           sum(case when b.st_fascia = 'Odido' then 1 else 0 end)          AS Odido,
           sum(case when b.st_fascia = 'Społem' then 1 else 0 end)         AS Społem,
           sum(case when b.st_fascia = 'Stokrotka' then 1 else 0 end)      AS Stokrotka,
           sum(case when b.st_fascia = 'Tesco' then 1 else 0 end)          AS Tesco,
           sum(case when b.st_fascia = 'Żabka' then 1 else 0 end)          AS Żabka,
           count(*)                                                        AS Total
         FROM mapp.pol_mapp_sites a,
              geodata.pol_glx_geodata_retail_points b
         WHERE ST_INTERSECTS(a.isoline_15min, b.geom_p_4326)
           AND a.id = ${id}
           AND b.st_fascia in (
                          'ABC',
                          'Aldi',
                          'Auchan',
                          'Biedronka',
                          'Carrefour',
                          'Delikatesy Centrum',
                          'Dino',
                          'Groszek',
                          'Kaufland',
                          'Lidl',
                          'Lewiatan',
                          'Netto',
                          'Odido',
                          'Społem',
                          'Stokrotka',
                          'Tesco',
                          'Żabka'
        )
     )
SELECT UNNEST(ARRAY [
    
                          'ABC',
                          'Aldi',
                          'Auchan',
                          'Biedronka',
                          'Carrefour',
                          'Delikatesy Centrum',
                          'Dino',
                          'Groszek',
                          'Kaufland',
                          'Lidl',
                          'Lewiatan',
                          'Netto',
                          'Odido',
                          'Społem',
                          'Stokrotka',
                          'Tesco',
                          'Żabka',
                          'Total'
    ]
           ) AS rows,
       UNNEST(
               ARRAY [
                   min5.ABC,
                   min5.Aldi,
                   min5.Auchan,
                   min5.Biedronka,
                   min5.Carrefour,
                   min5."Delikatesy Centrum",
                   min5.Dino,
                   min5.Groszek,
                   min5.Kaufland,
                   min5.Lidl,
                   min5.Lewiatan,
                   min5.Netto,
                   min5.Odido,
                   min5.Społem,
                   min5.Stokrotka,
                   min5.Tesco,
                   min5.Żabka,
                   min5.Total
                   ]
           ) AS min5,
       UNNEST(
               ARRAY [
                   min10.ABC,
                   min10.Aldi,
                   min10.Auchan,
                   min10.Biedronka,
                   min10.Carrefour,
                   min10."Delikatesy Centrum",
                   min10.Dino,
                   min10.Groszek,
                   min10.Kaufland,
                   min10.Lidl,
                   min10.Lewiatan,
                   min10.Netto,
                   min10.Odido,
                   min10.Społem,
                   min10.Stokrotka,
                   min10.Tesco,
                   min10.Żabka,
                   min10.Total
                   ]
           ) AS min10,
       UNNEST(
               ARRAY [
                   min15.ABC,
                   min15.Aldi,
                   min15.Auchan,
                   min15.Biedronka,
                   min15.Carrefour,
                   min15."Delikatesy Centrum",
                   min15.Dino,
                   min15.Groszek,
                   min15.Kaufland,
                   min15.Lidl,
                   min15.Lewiatan,
                   min15.Netto,
                   min15.Odido,
                   min15.Społem,
                   min15.Stokrotka,
                   min15.Tesco,
                   min15.Żabka,
                   min15.Total
                   ]
           ) AS min15
       
FROM min5,
     min10,
     min15;