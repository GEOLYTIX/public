SELECT
 id,
 dd_name,
 '#FFD60C' AS backgroundcolour,
  round(edu_access_schools * 100) AS edu_access_schools,
  round(edu_access_good_schools * 100) AS edu_access_good_schools,
  round(edu_access_adult_edu * 100) AS edu_access_adult_edu,
  round(edu_access_libraries * 100) AS edu_access_libraries,
  round(edu_school_quality * 100) AS edu_school_quality,
  round(hea_access_health_services * 100) AS hea_access_health_services,
  round(hea_hypertension_heart_failure * 100) AS hea_hypertension_heart_failure,
  round(hea_drugs_used_diabetes * 100) AS hea_drugs_used_diabetes,
  round(hea_antidepressants * 100) AS hea_antidepressants,
  round(hea_obesity * 100) AS hea_obesity,
  round(hea_dementia * 100) AS hea_dementia,
  round(eco_proximity_work_home * 100) AS eco_proximity_work_home,
  round(eco_hours_worked * 100) AS eco_hours_worked,
  round(eco_household_income * 100) AS eco_household_income,
  round(eco_vacant_commercial_units * 100) AS eco_vacant_commercial_units,
  round(eco_free_school_meals * 100) AS eco_free_school_meals,
  round(eco_unemployment * 100) AS eco_unemployment,
  round(eco_dist_nearest_shop * 100) AS eco_dist_nearest_shop,
  round(eco_dist_nearest_po * 100) AS eco_dist_nearest_po,
  round(eco_coop_se_co_per10k * 100) AS eco_coop_se_co_per10k
FROM coop.uk_coop_restrict_wellbeing_2020_oct
WHERE dd_name = '${loc}'

UNION ALL

SELECT 
  id,
  dd_name,
  null AS backgroundcolour,
  round(edu_access_schools * 100) AS edu_access_schools,
  round(edu_access_good_schools * 100) AS edu_access_good_schools,
  round(edu_access_adult_edu * 100) AS edu_access_adult_edu,
  round(edu_access_libraries * 100) AS edu_access_libraries,
  round(edu_school_quality * 100) AS edu_school_quality,
  round(hea_access_health_services * 100) AS hea_access_health_services,
  round(hea_hypertension_heart_failure * 100) AS hea_hypertension_heart_failure,
  round(hea_drugs_used_diabetes * 100) AS hea_drugs_used_diabetes,
  round(hea_antidepressants * 100) AS hea_antidepressants,
  round(hea_obesity * 100) AS hea_obesity,
  round(hea_dementia * 100) AS hea_dementia,
  round(eco_proximity_work_home * 100) AS eco_proximity_work_home,
  round(eco_hours_worked * 100) AS eco_hours_worked,
  round(eco_household_income * 100) AS eco_household_income,
  round(eco_vacant_commercial_units * 100) AS eco_vacant_commercial_units,
  round(eco_free_school_meals * 100) AS eco_free_school_meals,
  round(eco_unemployment * 100) AS eco_unemployment,
  round(eco_dist_nearest_shop * 100) AS eco_dist_nearest_shop,
  round(eco_dist_nearest_po * 100) AS eco_dist_nearest_po,
  round(eco_coop_se_co_per10k * 100) AS eco_coop_se_co_per10k
FROM coop.uk_coop_restrict_wellbeing_2020_oct
WHERE rm_format = '${postcode}';
