SELECT 
ARRAY [json_build_object(
	'data', ARRAY [
	oac_sg_1, 
	oac_sg_2, 
	oac_sg_3, 
	oac_sg_4, 
	oac_sg_5, 
	oac_sg_6, 
	oac_sg_7, 
	oac_sg_8
	],
	'backgroundColor', ARRAY [
	  '#ffb300',
    '#d81b60',
    '#8e24aa',
    '#5e35b1',
    '#3949ab',
    '#1e88e5',
    '#039be5',
    '#00acc1'
  ],
	'borderColor', ARRAY [
	  '#ffb300',
    '#d81b60',
    '#8e24aa',
    '#5e35b1',
    '#3949ab',
    '#1e88e5',
    '#039be5',
    '#00acc1'
  ]
)] AS datasets
FROM geodata.uk_glx_geodata_seamless_shopper_town_metrics 
WHERE id = %{id};