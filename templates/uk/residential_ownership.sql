SELECT
  ARRAY[json_build_object('data',
    ARRAY[
      dwelling_ownhome,
      dwelling_socialrented,
      dwelling_privaterented,
      dwelling_rentfree
    ])] AS datasets
  FROM geodata.uk_glx_geodata_oa_metrics
  WHERE id = %{id} ${filter};