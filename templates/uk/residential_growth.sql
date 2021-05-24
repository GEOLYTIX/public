SELECT
  ARRAY[json_build_object('data',
    ARRAY[
      pop_15,
      pop_16,
      pop_17,
      pop_18,
      pop_19,
      pop_20,
      pop_21,
      pop_22,
      pop_23,
      pop_24
    ])] AS datasets
  FROM geodata.uk_glx_geodata_oa_metrics
  WHERE id = %{id} ${filter};