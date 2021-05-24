SELECT ARRAY[
json_build_object(
  'data', ARRAY[
  sum(case when rpp.retailer='Sainsburys' then 1 else 0 end),
  sum(case when rpp.retailer='Asda' then 1 else 0 end),
  sum(case when rpp.retailer='Tesco' then 1 else 0 end),
  sum(case when rpp.retailer='Morrisons' then 1 else 0 end),
  sum(case when rpp.retailer='Waitrose' then 1 else 0 end),
  sum(case when rpp.retailer='Lidl' then 1 else 0 end),
  sum(case when rpp.retailer='Aldi' then 1 else 0 end),
  sum(case when rpp.retailer='Co-op' then 1 else 0 end)
  ],
  'backgroundColor', ARRAY[
  '#ffb300',
  '#d81b60',
  '#8e24aa',
  '#5e35b1',
  '#3949ab',
  '#1e88e5',
  '#039be5',
  '#00acc1'
  ]
  )] AS datasets,
  ARRAY[
  'Sainsburys',
  'Asda',
  'Tesco',
  'Morrisons',
  'Waitrose',
  'Lidl',
  'Aldi',
  'Co-op'
  ] AS labels 
FROM geodata.uk_glx_open_retail_points rpp
inner join geodata.uk_glx_geodata_seamless_shopper_town_metrics sst on st_intersects(sst.geom_4326, rpp.geom_p_4326)
where sst.id = ${id};