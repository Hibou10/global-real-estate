SELECT
  "Country" AS country,
  "Year"::INT AS year,
  REPLACE("House Price Index", '.', '')::NUMERIC / 1e13  AS house_price_index,
  REPLACE("Rent Index", '.', '')::NUMERIC / 1e13  AS rent_index,
  REPLACE("Affordability Ratio", '.', '')::NUMERIC / 1e13  AS affordability_ratio,
  REPLACE("Mortgage Rate (%)", '.', '')::NUMERIC / 1e13  AS mortgage_rate,
  REPLACE("Inflation Rate (%)", '.', '')::NUMERIC / 1e13  AS inflation_rate,
  REPLACE("GDP Growth (%)", '.', '')::NUMERIC / 1e13  AS gdp_growth,
  REPLACE("Population Growth (%)", '.', '')::NUMERIC / 1e13  AS population_growth,
  REPLACE("Urbanization Rate (%)", '.', '')::NUMERIC / 1e13  AS urbanization_rate,
  REPLACE("Construction Index", '.', '')::NUMERIC / 1e13  AS construction_index
FROM real_estate_data
WHERE "Country" IS NOT NULL
