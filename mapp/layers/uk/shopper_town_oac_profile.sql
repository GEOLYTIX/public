SELECT
    oac_sg_1,
    oac_sg_2,
    oac_sg_3,
    oac_sg_4,
    oac_sg_5,
    oac_sg_6,
    oac_sg_7,
    oac_sg_8,
    (select round(avg(oac_sg_1)) from geodata.uk_glx_geodata_seamless_shopper_town_metrics) as _oac_sg_1,
    (select round(avg(oac_sg_2)) from geodata.uk_glx_geodata_seamless_shopper_town_metrics) as _oac_sg_2,
    (select round(avg(oac_sg_3)) from geodata.uk_glx_geodata_seamless_shopper_town_metrics) as _oac_sg_3,
    (select round(avg(oac_sg_4)) from geodata.uk_glx_geodata_seamless_shopper_town_metrics) as _oac_sg_4,
    (select round(avg(oac_sg_5)) from geodata.uk_glx_geodata_seamless_shopper_town_metrics) as _oac_sg_5,
    (select round(avg(oac_sg_6)) from geodata.uk_glx_geodata_seamless_shopper_town_metrics) as _oac_sg_6,
    (select round(avg(oac_sg_7)) from geodata.uk_glx_geodata_seamless_shopper_town_metrics) as _oac_sg_7,
    (select round(avg(oac_sg_8)) from geodata.uk_glx_geodata_seamless_shopper_town_metrics) as _oac_sg_8
FROM geodata.uk_glx_geodata_seamless_shopper_town_metrics
WHERE id = ${id};