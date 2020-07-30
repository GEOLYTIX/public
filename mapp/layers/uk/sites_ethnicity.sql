select 
	round(100 *cast(coalesce (sum(ret_white_tot__11)/nullif(sum(pop__11),0),0) as numeric),2) as "White",
	round(100 *cast(coalesce (sum(ret_mixed__11)/nullif(sum(pop__11),0),0) as numeric),2) as "Mixed",
	round(100 *cast(coalesce (sum(ret_bandladeshi_brit__11 + ret_chinese_brit__11 + ret_indian_brit__11 + ret_pakistani_brit__11 + ret_otherasian_brit__11)/nullif(sum(pop__11),0),0) as numeric),2) as "Black",
	 round(100 *cast(coalesce (sum(ret_african_brit__11 + ret_caribbean_brit__11 + ret_otherblack_brit__11)/nullif(sum(pop__11),0),0) as numeric),2) as "Asian",
	 round(100 *cast(coalesce (sum(ret_other__11)/nullif(sum(pop__11),0),0) as numeric),2) as "Other"
from mapp.uk_glx_sites sit
left join geodata.uk_glx_geodata_hex_1k hex
on st_intersects(sit.isoline_15min, hex.geom_4326)
where sit.id=${id};
