select 
 	COALESCE(sum(age0to18) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as "< 18 yrs",
  COALESCE(sum(age18to24) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as "18 to 24 yrs",
  COALESCE(sum(age25to29) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as "25 to 29 yrs",
  COALESCE(sum(age30to44) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as "30 to 44 yrs",
  COALESCE(sum(age45to59) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as "45 to 59 yrs",
  COALESCE(sum(age60plus) / nullif(cast(sum(age0to18 +age18to24 +age25to29 + age30to44 + age45to59 + age60plus) as numeric),0),0) as "60 yrs +"
from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_demog_oa oa
on st_intersects(sit.isoline_15min, oa.geom_p_4326)
where sit.id =  ${id};

