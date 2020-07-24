 select 
 	dat.age0to18 / (uk.age_under_18_uk / cast(uk.age_total_uk as numeric))  *100 as age_under_18,
	dat.age18to24 / (uk.age_18to24_uk / cast(uk.age_total_uk as numeric))  *100 as age_18_24,
	dat.age25to29 / (uk.age_25to29_uk / cast(uk.age_total_uk as numeric))  *100 as age_25_29,
	dat.age30to44 / (uk.age_30to44_uk / cast(uk.age_total_uk as numeric))  *100 as age_30_44,
	dat.age45to59 / (uk.age_45to59_uk / cast(uk.age_total_uk as numeric))  *100 as age_45_59,
	dat.age60plus / (uk.age_60plus_uk / cast(uk.age_total_uk as numeric))  *100 as age_over_60
from 
 (select  
 	COALESCE(sum(age0to18) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as age0to18,
  COALESCE(sum(age18to24) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as age18to24,
  COALESCE(sum(age25to29) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as age25to29,
  COALESCE(sum(age30to44) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as age30to44,
  COALESCE(sum(age45to59) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as age45to59,
  COALESCE(sum(age60plus) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as age60plus
 from mapp.uk_glx_sites sit
 inner join geodata.uk_glx_geodata_demog_oa oa
 on ST_Intersects(sit.isoline_15min , oa.geom_p_4326)
 where sit.id =  ${id}) dat
 cross join geodata.uk_glx_geodata_demog_national_totals uk 
 