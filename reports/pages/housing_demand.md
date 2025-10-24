## 🌍 Population, Construction & Urbanization — {inputs.selected_country}


```sql countries
SELECT DISTINCT country
FROM supabase.housing
ORDER BY country;
```

<Dropdown data={countries} name=selected_country value=country title="Select Country" defaultValue="Germany" />

```sql growth_data
SELECT 
  year,
  'Population Growth' AS category,
  ROUND(AVG(avg_population_growth), 2) AS value
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'
GROUP BY year

UNION ALL

SELECT 
  year,
  'Construction Index' AS category,
  ROUND(AVG(avg_construction_index), 2)
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'
GROUP BY year

UNION ALL

SELECT 
  year,
  'Urbanization Rate' AS category,
  ROUND(AVG(avg_urbanization_rate), 2)
FROM supabase.housing
WHERE country = '${inputs.selected_country.value}'
GROUP BY year;
```

<AreaChart 
  data={growth_data} 
  x=year 
  y=value 
  series=category 
  stack=true 
  legend=true 
  yFmt=number />