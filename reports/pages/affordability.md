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