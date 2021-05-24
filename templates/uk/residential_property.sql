SELECT
  ARRAY[json_build_object('data',
    ARRAY[
      housetype_houses,
      housetype_flats,
      housetype_other
    ])] AS datasets
  FROM geodata.uk_glx_geodata_oa_metrics
  WHERE id = %{id} ${filter};
