SELECT 
  array_agg(
    json_build_object(
      'data', ARRAY [ 
      agriculture, 
      mining, 
      manufacturing, 
      electricity, 
      water, 
      construction, 
      wholesale, 
      transport, 
      accommodation, 
      it,
      finance, 
      real_estate, 
      professional, 
      administrative, 
      public_admin, 
      education, 
      human_health, 
      arts, 
      other,
      households, 
      extraterritorial
      ], 
      'backgroundColor', ARRAY [
      '#a6cee3', 
      '#1f78b4', 
      '#b2df8a', 
      '#33a02c', 
      '#fb9a99', 
      '#e31a1c', 
      '#fdbf6f', 
      '#ff7f00', 
      '#cab2d6', 
      '#6a3d9a', 
      '#ffff99', 
      '#b15928', 
      '#8dd3c7', 
      '#ffffb3', 
      '#bebada', 
      '#fb8072', 
      '#80b1d3', 
      '#fdb462', 
      '#b3de69', 
      '#fccde5', 
      '#d9d9d9' 
      ]
    )
  ) AS datasets, 
  ARRAY [ 
  'Agriculture & fishing', 
  'Mining & quarrying', 
  'Manufacturing', 
  'Electricity & gas', 
  'Water supply & management', 
  'Construction', 
  'Wholesale & retail trade', 
  'Transportation & storage', 
  'Accommodation & food services', 
  'Information & communication', 
  'Financial & insurance', 
  'Real estate', 
  'Professional', 
  'Administrative', 
  'Public administration & defence', 
  'Education', 
  'Human health & social services', 
  'Arts & entertainment', 
  'Other services', 
  'Domestic workers', 
  'Extraterritorial organisations' 
  ] AS labels 
  
FROM 
  geodata.uk_glx_geodata_workers_hybrid_zone
WHERE 
  id = %{id};