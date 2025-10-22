# 🌆 Global Urbanization 

Urbanization refers to the increasing concentration of populations in cities and urban areas.  
It is one of the most powerful forces shaping housing demand, infrastructure, and the real estate market.  
As more people move to cities, property prices, rent levels, and construction activity often rise — sometimes faster than income growth.  

This dashboard explores the **relationship between urbanization, construction, and housing affordability** across countries and years.  
It helps reveal how quickly cities are expanding and how this impacts the real estate sector.

---


```sql urbanization_overview
SELECT 
  country,
  ROUND(AVG(avg_urbanization_rate), 2) AS urbanization_rate,
  ROUND(AVG(avg_construction_index), 2) AS construction_index,
  ROUND(AVG(avg_house_price_index), 2) AS house_price_index,
  ROUND(AVG(avg_rent_index), 2) AS rent_index,
  ROUND(
    (AVG(avg_urbanization_rate) - LAG(AVG(avg_urbanization_rate)) OVER (ORDER BY AVG(avg_urbanization_rate))) 
    / LAG(AVG(avg_urbanization_rate)) OVER (ORDER BY AVG(avg_urbanization_rate)) * 100, 
  2) AS yoy_change

FROM supabase.housing
GROUP BY country
ORDER BY urbanization_rate DESC;
```

<DataTable data={urbanization_overview}> 
    <Column id=country title="Country" /> 
    <Column id=urbanization_rate fmt=pct title="Urbanization Rate" /> <Column id=construction_index fmt=num1 title="Construction Index" /> <Column id=house_price_index fmt=num1 title="House Price Index" /> <Column id=yoy_change contentType=delta fmt=pct title="Y/Y Urbanization Change" /> 
</DataTable>