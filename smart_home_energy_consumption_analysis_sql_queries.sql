SELECT * FROM consumers LIMIT 20;

-- Q1.: What are the key statistical measures (mean, median, quartiles, range) that describe energy consumption distribution?
-- Significance:
-- This establishes a baseline understanding of energy usage behavior across all appliances and homes. Knowing central tendency and spread helps identify what “normal” consumption looks like and sets thresholds for detecting anomalies or inefficiencies later.
WITH ordered_energy AS (
    SELECT
        `Energy Consumption (kWh)` AS energy_kwh,
        ROW_NUMBER() OVER (ORDER BY `Energy Consumption (kWh)`) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM energy_data
)
SELECT
    AVG(energy_kwh) AS mean_energy_kwh,
    MIN(energy_kwh) AS min_energy_kwh,
    MAX(energy_kwh) AS max_energy_kwh,
    MAX(energy_kwh) - MIN(energy_kwh) AS range_energy_kwh,
    MAX(CASE WHEN rn = FLOOR(0.25 * (total_rows + 1)) THEN energy_kwh END) AS q1,
    MAX(CASE WHEN rn = FLOOR(0.50 * (total_rows + 1)) THEN energy_kwh END) AS median,
    MAX(CASE WHEN rn = FLOOR(0.75 * (total_rows + 1)) THEN energy_kwh END) AS q3
FROM ordered_energy;

-- Q2.: What’s the distribution of household sizes in the dataset?
-- Significance:
-- Household size is a core explanatory variable for energy demand. Understanding its distribution ensures later comparisons (e.g., per-person usage) are meaningful and not biased by over- or under-represented household types.
-- For Consumption recount count per Household 
SELECT
    `Household Size` AS household_size,
    COUNT(*) AS number_of_records,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_total
FROM energy_data
GROUP BY `Household Size`
ORDER BY household_size;

-- For Unique Consumer HomeID or Household 
SELECT
    `Household Size` AS household_size,
    COUNT(DISTINCT `Home ID`) AS number_of_unique_households,
    ROUND(
        COUNT(DISTINCT `Home ID`) * 100.0 / SUM(COUNT(DISTINCT `Home ID`)) OVER (),
        2
    ) AS percentage_of_total
FROM energy_data
GROUP BY `Household Size`
ORDER BY household_size;

-- Q3.: What is the total energy consumption for the entire dataset and the Top 10 Home IDs with the highest consumption?
-- Significance:
-- This identifies overall system load and highlights high-impact households that may drive a disproportionate share of energy usage—important for demand management, audits, or targeted efficiency programs.
SELECT
    `Home ID`,
    ROUND(SUM(`Energy Consumption (kWh)`), 2) AS total_energy_kwh
FROM energy_data
GROUP BY `Home ID`
ORDER BY total_energy_kwh DESC
LIMIT 10;

-- Q4.: What is the seasonal distribution of energy consumption?
-- Significance:
-- Seasonal aggregation reveals weather-driven consumption patterns, validating expected trends (e.g., higher winter heating or summer cooling) and supporting seasonal forecasting and infrastructure planning.
SELECT
    `Season`,
    COUNT(*) AS records,
    ROUND(SUM(`Energy Consumption (kWh)`), 3) AS total_energy_kwh,
    ROUND(AVG(`Energy Consumption (kWh)`), 3) AS avg_energy_kwh
FROM energy_data
GROUP BY `Season`
ORDER BY total_energy_kwh DESC;

-- Q5.: What is the mean energy consumption (kWh) per household across all records vs. per household size?
-- Significance:
-- This shows how total household demand scales with household size, helping distinguish whether increases are linear or disproportionate as more occupants are added.
SELECT
    'All Households' AS category,
    ROUND(AVG(total_energy_per_home), 2) AS mean_energy_per_household_kwh
FROM (
    SELECT
        `Home ID`,
        SUM(`Energy Consumption (kWh)`) AS total_energy_per_home
    FROM energy_data
    GROUP BY `Home ID`
) a

UNION ALL

SELECT
    CONCAT('Household Size ', `Household Size`) AS category,
    ROUND(AVG(total_energy_per_home), 2)
FROM (
    SELECT
        `Home ID`,
        `Household Size`,
        SUM(`Energy Consumption (kWh)`) AS total_energy_per_home
    FROM energy_data
    GROUP BY `Home ID`, `Household Size`
) b
GROUP BY `Household Size`
ORDER BY category;

-- Q6.: What is the mean energy consumption for households of various sizes (1–5 persons)?
-- Significance:
-- By standardizing household sizes, this enables fair comparison across homes and helps utilities or policymakers design size-specific efficiency benchmarks or tariffs.
-- For Average Consumption by Household Across Dataset
SELECT
    `Household Size`,
    ROUND(AVG(total_energy_per_home), 3) AS mean_energy_per_household_kwh
FROM (
    SELECT
        `Home ID`,
        `Household Size`,
        AVG(`Energy Consumption (kWh)`) AS total_energy_per_home
    FROM energy_data
    WHERE `Household Size` BETWEEN 1 AND 5
    GROUP BY `Home ID`, `Household Size`
) household_totals
GROUP BY `Household Size`
ORDER BY `Household Size`;

-- Q7.: How does average energy per person vary across different household sizes?
-- Significance:
-- This directly tests for economies of scale in energy use—whether larger households are more energy-efficient per person than smaller ones, a key behavioral and sustainability insight.
SELECT
    `Household Size`,
    ROUND(AVG(energy_per_person), 2) AS avg_energy_per_person_kwh
FROM (
    SELECT
        `Home ID`,
        `Household Size`,
        SUM(`Energy Consumption (kWh)`) / `Household Size` AS energy_per_person
    FROM energy_data
    WHERE `Household Size` > 0
    GROUP BY `Home ID`, `Household Size`
) household_energy
GROUP BY `Household Size`
ORDER BY `Household Size`;

-- Q8.: Are High Energy Flags more frequent in Summer or Winter compared to other seasons?
-- Significance:
-- Analyzing the High Energy Flag by season helps identify periods of stress on the energy system, which may correspond to extreme temperatures, peak demand risks, or higher probability of inefficient usage.
SELECT
    `Season`,
    COUNT(*) AS total_records,
    SUM(`High Energy Flag`) AS high_energy_count,
    ROUND(
        SUM(`High Energy Flag`) * 100.0 / COUNT(*),
        2
    ) AS high_energy_percentage
FROM energy_data
GROUP BY `Season`
ORDER BY high_energy_percentage DESC;

-- Q8 b.: How does energy usage vary across seasons?
SELECT
    Season,
    COUNT(*) AS Total_Records,
    SUM(`Energy Consumption (kWh)`) AS Total_Energy_kWh,
    AVG(`Energy Consumption (kWh)`) AS Avg_Energy_kWh,
    MIN(`Energy Consumption (kWh)`) AS Min_Energy_kWh,
    MAX(`Energy Consumption (kWh)`) AS Max_Energy_kWh
FROM
    energy_data
GROUP BY
    Season
ORDER BY
    Avg_Energy_kWh DESC;
    
-- Q9.: What is the peak usage hour, and at what hour does the dataset show maximum energy consumption?
-- Significance:
-- This identifies daily demand peaks, critical for load balancing, grid reliability, and time-of-use pricing strategies. SQL handles hourly aggregation very efficiently.
SELECT
    `Hour`,
    ROUND(SUM(`Energy Consumption (kWh)`), 2) AS total_energy_kwh
FROM energy_data
GROUP BY `Hour`
ORDER BY total_energy_kwh DESC;

-- Q10.: How do energy consumption patterns differ between weekdays and weekends?
-- Significance:
-- This captures behavioral patterns tied to human activity (workdays vs leisure days), helping differentiate structural energy demand from lifestyle-driven usage.
SELECT
    CASE
        WHEN DAYOFWEEK(`Date`) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS number_of_records,
    ROUND(SUM(`Energy Consumption (kWh)`), 3) AS total_energy_kwh,
    ROUND(AVG(`Energy Consumption (kWh)`), 3) AS avg_energy_kwh
FROM energy_data
GROUP BY day_type
ORDER BY day_type;

