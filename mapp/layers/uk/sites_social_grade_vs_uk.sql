 select 
 	round(dat.ab / (uk.social_grade_ab_uk / cast(social_grade_total_uk as numeric))  *100, 0) as ab,
	round(dat.c1 / (uk.social_grade_c1_uk / cast(social_grade_total_uk as numeric))  *100, 0) as c1,
	round(dat.c2 / (uk.social_grade_c2_uk / cast(social_grade_total_uk as numeric))  *100, 0) as c2,
	round(dat.de / (uk.social_grade_de_uk / cast(social_grade_total_uk as numeric))  *100, 0) as de
from 
 (select  
 	COALESCE(sum(abhrp) / nullif(cast(sum(abhrp + c1hrp + c2hrp + dehrp) as numeric),0),0) as ab,
  COALESCE(sum(c1hrp) / nullif(cast(sum(abhrp + c1hrp + c2hrp + dehrp) as numeric),0),0) as c1,
  COALESCE(sum(c2hrp) / nullif(cast(sum(abhrp + c1hrp + c2hrp + dehrp) as numeric),0),0) as c2,
  COALESCE(sum(dehrp) / nullif(cast(sum(abhrp + c1hrp + c2hrp + dehrp) as numeric),0),0) as de
 from mapp.uk_glx_sites sit
 inner join geodata.uk_glx_geodata_oa_metrics oa
 on ST_Intersects(sit.isoline_15min , oa.geom_p_4326)
 where sit.id = ${id}) dat
 cross join geodata.uk_glx_geodata_demog_national_totals uk ;
 