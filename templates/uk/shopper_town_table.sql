SELECT
  id,
  shop_town,
  pop_19,
  100 * pop_11_19 as pop_11_19,
  grocers_big4,
  grocers_discount,
  grocers_premium
FROM geodata.uk_glx_geodata_seamless_shopper_town_metrics
WHERE true ${viewport} ${filter}
LIMIT 99;