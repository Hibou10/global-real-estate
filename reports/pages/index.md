# 🌍 Global Real Estate 

The global real estate market shows significant variations between countries.  
Use the dropdown below to explore national housing trends — including average house prices, rent levels, and mortgage rates over time.

---

```sql countries
SELECT DISTINCT country 
FROM supabase.housing
ORDER BY country;

```

<Dropdown 
    data={countries} 
    name=selected_country 
    value=country
    title="Country" 
    defaultValue="Germany"
/>


```sql country_housing
SELECT 
  CASE 
    WHEN country = 'UAE' THEN 'United Arab Emirates'
    WHEN country = 'UK' THEN 'United Kingdom'
    WHEN country = 'USA' THEN 'United States'
    WHEN country = 'South Korea' THEN 'Korea'
    ELSE country
  END AS
  country,
  year,
  ROUND(AVG(avg_house_price_index), 2) AS avg_house_price_index,
  ROUND(AVG(avg_rent_index), 2) AS avg_rent_index,
  ROUND(AVG(avg_mortgage_rate), 2) AS avg_mortgage_rate
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'
GROUP BY country ,year
ORDER BY year;
```

🏠 Housing Market Trends in {inputs.selected_country.value}

<Grid cols=2>
<AreaMap 
  data={country_housing} 
  areaCol=country 
  geoJsonUrl="https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_110m_admin_0_countries.geojson" 
  geoId=name
  title={`🗺️  ${inputs.selected_country.value}`} 
  height=200 
  colorScale={{
    domain: [0, 1],
    range: ["#c0c0c0", "#003366"],  
    nullColor: "#f2f2f2"
  }}
  />

<LineChart 
  data={country_housing} 
  x=year 
  y=avg_house_price_index 
  title="🏡 Average House Price Index Over Time" />
</Grid>

<Grid cols=2>
<LineChart 
  data={country_housing} 
  x=year 
  y=avg_rent_index 
  title="💰 Average Rent Index Over Time" />

<LineChart 
  data={country_housing} 
  x=year 
  y=avg_mortgage_rate 
  title="📉 Average Mortgage Rate (%) Over Time" />
</Grid>




