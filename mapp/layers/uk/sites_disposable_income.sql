select 
	round(100* coalesce (sum( case when avgdis_pmh >= 5000 then 1 else 0 end)/cast(count(*) as numeric),0),2) as "£5000+",
	round(100*coalesce (sum( case when avgdis_pmh >= 4000 and avgdis_pmh < 5000 then 1 else 0 end)/cast(count(*) as numeric),0),2) as "£4000-5000",
	round(100*coalesce (sum( case when avgdis_pmh >= 3000 and avgdis_pmh < 4000 then 1 else 0 end)/cast(count(*) as numeric),0),2) as "£3000-4000",
	round(100*coalesce (sum( case when avgdis_pmh >= 2000 and avgdis_pmh < 3000 then 1 else 0 end)/cast(count(*) as numeric),0),2) as "£2000-3000",
	round(100*coalesce (sum( case when avgdis_pmh >= 1000 and avgdis_pmh < 2000 then 1 else 0 end)/cast(count(*) as numeric),0),2) as "£1000-2000",
	round(100*coalesce (sum( case when avgdis_pmh < 1000 then 1 else 0 end)/cast(count(*) as numeric),0),2) as "<£1000"
from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_oa_metrics oa
on st_intersects(sit.isoline_15min, oa.geom_p_4326)
where sit.id=${id};