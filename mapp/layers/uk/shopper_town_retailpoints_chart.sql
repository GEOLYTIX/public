select
    (select
    count(a.id)
    from
        geodata.uk_glx_open_retail_points a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
    where
        b.id = ${id}
        and st_intersects(b.geom_4326, a.geom_p_4326)
        and a.retailer = 'Sainsburys') as "Sainsburys",

    (select
    count(a.id)
    from
        geodata.uk_glx_open_retail_points a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
    where
        b.id = ${id}
        and st_intersects(b.geom_4326, a.geom_p_4326)
        and a.retailer = 'Asda') as "Asda",

    (select
    count(a.id)
    from
        geodata.uk_glx_open_retail_points a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
    where
        b.id = ${id}
        and st_intersects(b.geom_4326, a.geom_p_4326)
        and a.retailer = 'Tesco') as "Tesco",

    (select
    count(a.id)
    from
        geodata.uk_glx_open_retail_points a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
    where
        b.id = ${id}
        and st_intersects(b.geom_4326, a.geom_p_4326)
        and a.retailer = 'Morrisons') as "Morrisons",

    (select
    count(a.id)
    from
        geodata.uk_glx_open_retail_points a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
    where
        b.id = ${id}
        and st_intersects(b.geom_4326, a.geom_p_4326)
        and a.retailer = 'Waitrose') as "Waitrose",

    (select
    count(a.id)
    from
        geodata.uk_glx_open_retail_points a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
    where
        b.id = ${id}
        and st_intersects(b.geom_4326, a.geom_p_4326)
        and a.retailer = 'Lidl') as "Lidl",

    (select
    count(a.id)
    from
        geodata.uk_glx_open_retail_points a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
    where
        b.id = ${id}
        and st_intersects(b.geom_4326, a.geom_p_4326)
        and a.retailer = 'Aldi') as "Aldi",

    (select
    count(a.id)
    from
        geodata.uk_glx_open_retail_points a,
        geodata.uk_glx_geodata_seamless_shopper_town_metrics b 
    where
        b.id = ${id}
        and st_intersects(b.geom_4326, a.geom_p_4326)
        and a.retailer = 'Co-op') as "Co-op";      