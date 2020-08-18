With 
dat as (
  select 
    round(coalesce(sum(case when st_distance(sit.geom_4326, wor.geom_p_4326, true) <250 then workers else 0 end))) as workers_250,
    round(coalesce(sum(case when st_distance(sit.geom_4326, wor.geom_p_4326, true) <500 then workers else 0 end))) as workers_500,
    round(coalesce(sum(case when st_distance(sit.geom_4326, wor.geom_p_4326, true) <750 then workers else 0 end))) as workers_750,
    round(coalesce(sum(case when st_distance(sit.geom_4326, wor.geom_p_4326, true) <1000 then workers else 0 end))) as workers_1000
  from mapp.uk_glx_sites sit
  left join geodata.uk_glx_geodata_workers_postcode wor
  on st_dwithin(sit.geom_4326, wor.geom_p_4326, 1000, true)
  where sit.id=${id}
)

select
	unnest(array ['0-250m', '0-500m', '0-750m', '0-1km']) as distance,
	unnest(array [workers_250, workers_500, workers_750, workers_1000]) as workers
from dat;