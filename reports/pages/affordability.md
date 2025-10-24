# 🏙️ Global Real Estate Affordability 
Housing affordability measures how easily people can afford to buy or rent a home.
It reflects the relationship between house prices, income, rent levels, and mortgage rates — showing the financial pressure that households face in different countries.
Housing affordability varies dramatically around the world.  
This dashboard compares property prices, rent levels, and income to reveal how affordable housing is in each country.

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

```sql pie_query
SELECT 'House Price Index' AS category, ROUND(AVG(avg_house_price_index), 2) AS value
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'
UNION ALL
SELECT 'Rent Index' AS category, ROUND(AVG(avg_rent_index), 2) AS value
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'
UNION ALL
SELECT 'Mortgage Rate' AS category, ROUND(AVG(avg_mortgage_rate), 2) AS value
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'
UNION ALL
SELECT 'Affordability Ratio' AS category, ROUND(AVG(avg_affordability_ratio), 2) AS value
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'
```



```sql pie_data
SELECT category AS name, value
FROM ${pie_query};
```

<ECharts config={
    {
        tooltip: {
            formatter: '{b}: {c} ({d}%)'
        },
        series: [
        {
            type: 'pie',
            data: [...pie_data],
        }
      ]
      }
    }
/>

---

### 🧾 Housing Metrics: {inputs.selected_country.value}

```sql country_details
SELECT 
  'House Price Index' AS Metric, 
  ROUND(AVG(avg_house_price_index), 2) AS "Average Value",
  'Index' AS Unit,
  CASE 
    WHEN AVG(avg_house_price_index) > 1200 THEN 'High property prices in ' || '${inputs.selected_country.value}.'
    WHEN AVG(avg_house_price_index) BETWEEN 800 AND 1200 THEN 'Moderate property prices in ' || '${inputs.selected_country.value}.'
    ELSE 'Relatively low property prices in ' || '${inputs.selected_country.value}.'
  END AS Explanation
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'

UNION ALL

SELECT 
  'Rent Index',
  ROUND(AVG(avg_rent_index), 2),
  'Index',
  CASE 
    WHEN AVG(avg_rent_index) > 1200 THEN 'High rental costs in ' || '${inputs.selected_country.value}.'
    WHEN AVG(avg_rent_index) BETWEEN 800 AND 1200 THEN 'Moderate rent levels in ' || '${inputs.selected_country.value}.'
    ELSE 'Affordable rent levels in ' || '${inputs.selected_country.value}.'
  END
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'

UNION ALL

SELECT 
  'Mortgage Rate',
  ROUND(AVG(avg_mortgage_rate), 2),
  '%',
  CASE 
    WHEN AVG(avg_mortgage_rate) > 1000 THEN 'Very high mortgage rates in ' || '${inputs.selected_country.value}.'
    WHEN AVG(avg_mortgage_rate) BETWEEN 500 AND 1000 THEN 'Moderate mortgage rates in ' || '${inputs.selected_country.value}.'
    ELSE 'Low mortgage rates in ' || '${inputs.selected_country.value}.'
  END
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'

UNION ALL

SELECT 
  'Affordability Ratio',
  ROUND(AVG(avg_affordability_ratio), 2),
  'Index',
  CASE 
    WHEN AVG(avg_affordability_ratio) > 1200 THEN 'Housing less affordable in ' || '${inputs.selected_country.value}.'
    WHEN AVG(avg_affordability_ratio) BETWEEN 800 AND 1200 THEN 'Housing moderately affordable in ' || '${inputs.selected_country.value}.'
    ELSE 'Housing more affordable in ' || '${inputs.selected_country.value}.'
  END
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}';


```


<DataTable 
    data={country_details} 
    rows=all> <Column 
    id=Metric 
    title="Metric" /> 
    <Column id="Average Value" title="Average Value" fmt=number /> 
    <Column id=Unit title="Unit" /> 
    <Column id=Explanation title="Interpretation" /> 
    </DataTable> 


