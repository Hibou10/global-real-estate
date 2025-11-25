SELECT
  country,
  year,
  ROUND(AVG(house_price_index), 2) AS avg_house_price_index,
  ROUND(AVG(rent_index), 2) AS avg_rent_index,
  ROUND(AVG(house_price_index / NULLIF(rent_index, 0)), 2) AS price_to_rent_ratio,
  ROUND(AVG(affordability_ratio), 2) AS avg_affordability_ratio,
  ROUND(AVG(mortgage_rate), 2) AS avg_mortgage_rate,
  ROUND(AVG(inflation_rate), 2) AS avg_inflation_rate,
  ROUND(AVG(gdp_growth), 2) AS avg_gdp_growth,
  ROUND(AVG(population_growth), 2) AS avg_population_growth,
  ROUND(AVG(urbanization_rate), 2) AS avg_urbanization_rate,
  ROUND(AVG(construction_index), 2) AS avg_construction_index
FROM {{ ref('clean_real_estate') }}
GROUP BY country, year
ORDER BY country, year
