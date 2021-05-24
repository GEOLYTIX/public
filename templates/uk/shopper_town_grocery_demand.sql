SELECT 
  ARRAY [json_build_object(
    'data', ARRAY [
      grocery_demand_main, 
      grocery_demand_conv, 
      grocery_demand_online
    ],
    'backgroundColor', ARRAY [
      '#8e24aa',
      '#ffb300',
      '#1e88e5'
    ]
  )] AS datasets,
  ARRAY [
    'Supermarket',
    'Convenience',
    'Online'
  ] AS labels
FROM geodata.uk_glx_geodata_seamless_shopper_town_metrics 
WHERE id = ${id};