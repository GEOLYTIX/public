select 
  measure, 
  category,
  rtrim(to_char(numbers, 'FM999G999G999G999G990.999'), '.') as catchment, 
  national_numbers as UK, 
  case when national_numbers is null then null else round(numbers / national_numbers * 100) end as Index, 
  case when national_numbers is null then 0 else case when round(numbers / national_numbers * 100)< 100 then 100 - round(numbers / national_numbers * 100) else 0 end end underindex, 
  case when national_numbers is null then 0 else case when round(numbers / national_numbers * 100)> 100 then round(numbers / national_numbers * 100)-100 else 0 end end overindex 
from 
    (select
        UNNEST(
            ARRAY [ 
            'Population 2020', 
            'Population 2021', 
            'Population 2022', 'Population 2023', 
            'Population 2024', 'Population 2025', 
			'Households 2020',	
            'Workers',
            'White %',
            'Car Ownership %',
            'Students %', 
            'House %', 'Flats %', 'Own Home %', 'Social Rented %', 
            'Private Rented %', 'Social Grade AB %', 
            'Social Grade C1 %', 'Social Grade C2 %', 
            'Social Grade DE %', 
            'OAC - Rural residents',
            'OAC - Cosmopolitans',
            'OAC - Ethnicity central',
            'OAC - Multicultural metropolitans',
            'OAC - Urbanites',
            'OAC - Suburbanites',
            'OAC - Constrained city dwellers',
            'OAC - Hard-pressed living',
            'Age 0 - 18 %', 'Age 18 -24 %', 'Age 25 - 44 %', 'Age 45 - 59 %', 
            'Age 60+ %'
            ]
        ) AS measure, 
            UNNEST(
            ARRAY [ 
            'Population Change', 
            'Population Change', 
            'Population Change', 
            'Population Change', 
            'Population Change', 
            'Population Change', 
			'Summary',
            'Summary',
            'Summary',
            'Summary',
            'Summary', 
            'Home Ownership', 
            'Home Ownership',
            'Home Ownership', 
            'Home Ownership', 
            'Home Ownership', 
            'Social Grade', 
            'Social Grade', 
            'Social Grade', 
            'Social Grade',
            'OAC Supergroups',
            'OAC Supergroups',
            'OAC Supergroups',
            'OAC Supergroups',
            'OAC Supergroups',
            'OAC Supergroups',
            'OAC Supergroups',
            'OAC Supergroups',
            'Age Profile', 
            'Age Profile', 
            'Age Profile', 
            'Age Profile', 
            'Age Profile'
            ]
        ) AS category, 
	    UNNEST(numbers) as numbers,
	    UNNEST(national_numbers) as national_numbers
    from
        (select 
        ARRAY [  pop_20,pop_21,pop_22,pop_23,pop_24,pop_25,hhd_20,coalesce(workers,0),round(white*100,1),round(car_ownership*100,1),round(students*100,1),round(housetype_houses*100,1),round(housetype_flats*100,1),
            round(dwelling_ownhome*100,1),round(dwelling_socialrented*100,1),round(dwelling_privaterented*100,1),round(abhrp*100,1),round(c1hrp*100,1),round(c2hrp*100,1),round(dehrp*100,1),
            round(oac_supergroup_1*100,1),round(oac_supergroup_2*100,1),round(oac_supergroup_3*100,1),round(oac_supergroup_4*100,1),
            round(oac_supergroup_5*100,1),round(oac_supergroup_6*100,1),round(oac_supergroup_7*1001),round(oac_supergroup_8*100,1),
            round(age0to18*100,1), round(age18to24*100,1), round(age25to44*100,1),round(age45to59*100,1), round(age60plus*100,1)
        ] as numbers
        from 
            (SELECT 
                    coalesce(sum(m.hhd_20),0) as hhd_20, 	
                    coalesce(sum(m.pop_20),0) as pop_20, 	
                    coalesce(sum(pop_21),0) as pop_21, 
                    coalesce(sum(pop_22),0) as pop_22, 
                    coalesce(sum(pop_23),0) as pop_23, 
                    coalesce(sum(pop_24),0) as pop_24, 
                    coalesce(sum(pop_25),0) as pop_25, 
                    coalesce(sum(white) / sum(m.pop_11 :: numeric),0) as white, 
                    coalesce(sum(carownership_perc :: numeric * hhd_11) / sum(m.hhd_11 :: numeric),0) as car_ownership, 
                    coalesce(sum(housetype_houses)/ sum((housetype_houses + housetype_flats + housetype_other):: numeric),0) as housetype_houses, 
                    coalesce(sum(housetype_flats) / sum((housetype_houses + housetype_flats + housetype_other):: numeric),0) as housetype_flats, 
                    coalesce(sum(dwelling_ownhome) / sum( (dwelling_ownhome + dwelling_socialrented + dwelling_privaterented):: numeric),0) as dwelling_ownhome, 
                    coalesce(sum(dwelling_socialrented) / sum( (dwelling_ownhome + dwelling_socialrented + dwelling_privaterented):: numeric),0)as dwelling_socialrented, 
                    coalesce(sum(dwelling_privaterented) / sum( (dwelling_ownhome + dwelling_socialrented + dwelling_privaterented ):: numeric),0) as dwelling_privaterented, 
                    coalesce(sum(abhrp) / sum((abhrp + c1hrp + c2hrp + dehrp):: numeric ),0) as abhrp, 
                    coalesce(sum(c1hrp) / sum( (abhrp + c1hrp + c2hrp + dehrp):: numeric),0) as c1hrp, 
                    coalesce(sum(c2hrp) / sum((abhrp + c1hrp + c2hrp + dehrp):: numeric),0) as c2hrp, 
                    coalesce( sum(dehrp) / sum((abhrp + c1hrp + c2hrp + dehrp):: numeric),0)as dehrp, 
                    coalesce( sum(case when oac_supergroup = 1 then hhd_11 else 0 end) / sum(m.hhd_11 :: numeric),0 ) as oac_supergroup_1,
                    coalesce( sum(case when oac_supergroup = 2 then hhd_11 else 0 end) / sum(m.hhd_11 :: numeric),0 ) as oac_supergroup_2,
                    coalesce( sum(case when oac_supergroup = 3 then hhd_11 else 0 end) / sum(m.hhd_11 :: numeric),0 ) as oac_supergroup_3,
                    coalesce( sum(case when oac_supergroup = 4 then hhd_11 else 0 end) / sum(m.hhd_11 :: numeric),0 ) as oac_supergroup_4,
                    coalesce( sum(case when oac_supergroup = 5 then hhd_11 else 0 end) / sum(m.hhd_11 :: numeric),0 ) as oac_supergroup_5,
                    coalesce( sum(case when oac_supergroup = 6 then hhd_11 else 0 end) / sum(m.hhd_11 :: numeric),0 ) as oac_supergroup_6,
                    coalesce( sum(case when oac_supergroup = 7 then hhd_11 else 0 end) / sum(m.hhd_11 :: numeric),0 ) as oac_supergroup_7,
                    coalesce( sum(case when oac_supergroup = 8 then hhd_11 else 0 end) / sum(m.hhd_11 :: numeric),0 ) as oac_supergroup_8,
                    coalesce(sum(students)/ sum(m.pop_11 :: numeric),0) as students, 
                    coalesce(sum(age0to18) / sum(m.pop_11 :: numeric),0)as age0to18, 
                    coalesce(sum(age18to24) / sum(m.pop_11 :: numeric),0)as age18to24, 
                    coalesce(sum(age25to44) / sum(m.pop_11 :: numeric),0)as age25to44, 
                    coalesce(sum(age45to59) / sum(m.pop_11 :: numeric),0)as age45to59, 
                    coalesce(sum(age60plus) / sum(m.pop_11 :: numeric),0) as age60plus
                from geodata.uk_glx_geodata_oa_metrics m
              join geodata.uk_glx_geodata_admin_oa_fulllook l on m.id=l.id 
                where 
                  lad_id = ${id} 
			) o
            cross join (
                select 
                    sum(workers) as workers
                from geodata.uk_glx_geodata_workers_postcode w
                    join geodata.uk_glx_geodata_admin_lad s on  st_intersects(s.geom_4326_5m, w.geom_p_4326)
                where 
                    s.id = ${id} 
            ) w
         )site
        ,
        ( SELECT 
                    ARRAY [  
                    null,
                    null, 
                    null, 
                    null, 
                    null, 
                    null, 
                    null,
                    null,
                    round(
                    ethnicity_white /(pop_11 :: numeric)* 100, 
                    1
                    ), 
                    round(car_ownership *100, 1),
                    round(
                    houses /(
                        (houses + flats + housetype_other):: numeric
                    )* 100, 
                    1
                    ), 
                    round(
                    flats /(
                        (houses + flats + housetype_other):: numeric
                    )* 100, 
                    1
                    ), 
                    round(
                    ownhome /(
                        (
                        ownhome + social_rented + private_rented
                        ):: numeric
                    )* 100, 
                    1
                    ), 
                    round(
                    social_rented /(
                        (
                        ownhome + social_rented + private_rented
                        ):: numeric
                    )* 100, 
                    1
                    ), 
                    round(
                    private_rented /(
                        (
                        ownhome + social_rented + private_rented
                        ):: numeric
                    )* 100, 
                    1
                    ), 
                    round(
                    social_grade_ab_uk /(
                        (
                        social_grade_ab_uk + social_grade_c1_uk + social_grade_c2_uk + social_grade_de_uk
                        ):: numeric
                    )* 100, 
                    1
                    ), 
                    round(
                    social_grade_c1_uk /(
                        (
                        social_grade_ab_uk + social_grade_c1_uk + social_grade_c2_uk + social_grade_de_uk
                        ):: numeric
                    )* 100, 
                    1
                    ), 
                    round(
                    social_grade_c2_uk /(
                        (
                        social_grade_ab_uk + social_grade_c1_uk + social_grade_c2_uk + social_grade_de_uk
                        ):: numeric
                    )* 100, 
                    1
                    ), 
                    round(
                    social_grade_de_uk /(
                        (
                        social_grade_ab_uk + social_grade_c1_uk + social_grade_c2_uk + social_grade_de_uk
                        ):: numeric
                    )* 100, 
                    1
                    ), 
                        round(
                    students /(pop_11 :: numeric)* 100, 
                    1
                    ), 
                        round(oac_supergroup_1*100,1),
                        round(oac_supergroup_2*100,1),	
                        round(oac_supergroup_3*100,1),	
                        round(oac_supergroup_4*100,1),	
                        round(oac_supergroup_5*100,1),	
                        round(oac_supergroup_6*100,1),
                        round(oac_supergroup_7*100,1),	
                        round(oac_supergroup_8*100,1),
                    round(
                    age_under_18_uk /(pop_11 :: numeric)* 100, 
                    1
                    ), 
                    round(
                    age_18to24_uk /(pop_11 :: numeric)* 100, 
                    1
                    ), 
                    round(
                    (age_25to29_uk + age_30to44_uk)/(pop_11 :: numeric)* 100, 
                    1
                    ), 
                    round(
                    age_45to59_uk /(pop_11 :: numeric)* 100, 
                    1
                    ), 
                    round(
                    age_60plus_uk /(pop_11 :: numeric)* 100, 
                    1
                    )
                    ] as national_numbers
                FROM 
                    geodata.uk_glx_geodata_demog_national_totals t
             ) national_numbers
        )calc

