WITH min5 AS (
    SELECT ROUND(SUM(b.pop__18))                                                 AS population,
           ROUND(SUM(b.hholds__18))                                              AS households,
           ROUND(SUM(b.disinc__18) / sum(b.pop__18))                             AS disposable_income_per_capita,
           ROUND(SUM(b.retail__18))                                              AS retail_spend,
           ROUND(SUM(b.fmcg__18))                                                AS food_spend,
           ROUND(sum(ageunder4))                                                 AS age_under_4,
           ROUND(sum(age4to11))                                                  AS age_4_to_11,
           ROUND(sum(age12to16))                                                 AS age_12_to_16,
           ROUND(sum(age17to21 + age22to35 + age36to45 + age46to55 + age56to65)) AS age_17_to_65,
           ROUND(sum(age65to75 + age75plus))                                     AS age_65_plus
    FROM mapp.pol_mapp_sites a,
         geodata.pol_glx_geodata_hex_1k b
    WHERE ST_INTERSECTS(a.isoline_5min, b.geom_p_4326)
      AND a.id = ${id}),
     min10 AS (
         SELECT ROUND(SUM(b.pop__18))                                                 AS population,
                ROUND(SUM(b.hholds__18))                                              AS households,
                ROUND(SUM(b.disinc__18) / sum(b.pop__18))                             AS disposable_income_per_capita,
                ROUND(SUM(b.retail__18))                                              AS retail_spend,
                ROUND(SUM(b.fmcg__18))                                                AS food_spend,
                ROUND(sum(ageunder4))                                                 AS age_under_4,
                ROUND(sum(age4to11))                                                  AS age_4_to_11,
                ROUND(sum(age12to16))                                                 AS age_12_to_16,
                ROUND(sum(age17to21 + age22to35 + age36to45 + age46to55 + age56to65)) AS age_17_to_65,
                ROUND(sum(age65to75 + age75plus))                                     AS age_65_plus
         FROM mapp.pol_mapp_sites a,
              geodata.pol_glx_geodata_hex_1k b
         WHERE ST_INTERSECTS(a.isoline_10min, b.geom_p_4326)
           AND a.id = ${id}),
     min15 AS (
         SELECT ROUND(SUM(b.pop__18))                                                 AS population,
                ROUND(SUM(b.hholds__18))                                              AS households,
                ROUND(SUM(b.disinc__18) / sum(b.pop__18))                             AS disposable_income_per_capita,
                ROUND(SUM(b.retail__18))                                              AS retail_spend,
                ROUND(SUM(b.fmcg__18))                                                AS food_spend,
                ROUND(sum(ageunder4))                                                 AS age_under_4,
                ROUND(sum(age4to11))                                                  AS age_4_to_11,
                ROUND(sum(age12to16))                                                 AS age_12_to_16,
                ROUND(sum(age17to21 + age22to35 + age36to45 + age46to55 + age56to65)) AS age_17_to_65,
                ROUND(sum(age65to75 + age75plus))                                     AS age_65_plus
         FROM mapp.pol_mapp_sites a,
              geodata.pol_glx_geodata_hex_1k b
         WHERE ST_INTERSECTS(a.isoline_15min, b.geom_p_4326)
           AND a.id = ${id})

SELECT UNNEST(ARRAY ['Population','Households','Disposable Income Per Capita','Retail Spend','Food Spend',
    'Under 4','4 to 11','12 to 16','17 to 65','65 plus']) AS rows,
       UNNEST(
               ARRAY [min5.population,min5.households,min5.disposable_income_per_capita,min5.retail_spend,
                   min5.food_spend,min5.age_under_4,min5.age_4_to_11,min5.age_12_to_16,
                   min5.age_17_to_65,min5.age_65_plus])   AS min5,
       UNNEST(
               ARRAY [min10.population,min10.households,min10.disposable_income_per_capita,min10.retail_spend,
                   min10.food_spend,min10.age_under_4,min10.age_4_to_11,min10.age_12_to_16,
                   min10.age_17_to_65,min10.age_65_plus]) AS min10,
       UNNEST(
               ARRAY [min15.population,min15.households,min15.disposable_income_per_capita,min15.retail_spend,
                   min15.food_spend,min15.age_under_4,min15.age_4_to_11,min15.age_12_to_16,
                   min15.age_17_to_65,min15.age_65_plus]) AS min15
FROM min5,
     min10,
     min15;