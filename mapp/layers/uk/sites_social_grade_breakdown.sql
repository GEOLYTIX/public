select 
 	COALESCE(sum(abhrp) / nullif(cast(sum(abhrp + c1hrp + c2hrp + dehrp) as numeric),0),0) as ab,
  COALESCE(sum(c1hrp) / nullif(cast(sum(abhrp + c1hrp + c2hrp + dehrp) as numeric),0),0) as c1,
  COALESCE(sum(c2hrp) / nullif(cast(sum(abhrp + c1hrp + c2hrp + dehrp) as numeric),0),0) as c2,
  COALESCE(sum(dehrp) / nullif(cast(sum(abhrp + c1hrp + c2hrp + dehrp) as numeric),0),0) as de
from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_demog_oa oa
on st_intersects(sit.isoline_15min, oa.geom_p_4326)
where sit.id =  ${id};
