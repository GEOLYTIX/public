SELECT
  ARRAY[json_build_object('data',
    ARRAY[
      age0to18,
      age18to24,
      age25to44,
      age45to59,
      age60plus
    ])] AS datasets
  FROM geodata.uk_glx_geodata_oa_metrics
  WHERE id = %{id} ${filter};