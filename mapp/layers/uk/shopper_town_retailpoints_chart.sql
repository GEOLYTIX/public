SELECT sum(case
               when rpp.retailer='Sainsburys' then 1
               else 0
           end) as "Sainsburys",
       sum(case
               when rpp.retailer='Asda' then 1
               else 0
           end) as "Asda",
       sum(case
               when rpp.retailer='Tesco' then 1
               else 0
           end) as "Tesco",
       sum(case
               when rpp.retailer='Morrisons' then 1
               else 0
           end) as "Morrisons",
       sum(case
               when rpp.retailer='Waitrose' then 1
               else 0
           end) as "Waitrose",
       sum(case
               when rpp.retailer='Lidl' then 1
               else 0
           end) as "Lidl",
       sum(case
               when rpp.retailer='Aldi' then 1
               else 0
           end) as "Aldi",
       sum(case
               when rpp.retailer='Co-op' then 1
               else 0
           end) as "Co-op"
FROM geodata.uk_glx_open_retail_points rpp
inner join geodata.uk_glx_geodata_seamless_shopper_town_metrics sst on st_intersects(sst.geom_4326, rpp.geom_p_4326)
where sst.id = ${id};