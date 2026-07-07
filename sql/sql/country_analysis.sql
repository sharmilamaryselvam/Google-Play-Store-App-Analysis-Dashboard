ALTER TABLE country_apps
ADD CONSTRAINT fk FOREIGN KEY(app_id) REFERENCES global_apps(app_id)

ALTER TABLE country_apps
ALTER COLUMN app_id NVARCHAR(200)

-- ============================================
-- Section 1 — Country Overview
-- ============================================

-- Q1. How many target countries are represented?
SELECT
    COUNT(DISTINCT country) AS Total_Countries
FROM country_apps;


-- Insight
-- The dataset covers 10 priority Play Store markets, enabling cross-country comparisons.




-- Q2. Which countries have the highest total installs?

SELECT
    country,
    SUM(installs) AS Total_Installs
FROM country_apps
GROUP BY country
ORDER BY Total_Installs DESC;

-- Insight
--Countries with higher installs represent larger addressable markets.



-- Q3. Which countries have the highest average app ratings?
SELECT
    country,
    CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Rating
FROM country_apps
GROUP BY country
ORDER BY Avg_Rating DESC;

--Insight
--Higher average ratings may indicate stronger user satisfaction or app quality.



-- Q4. Which countries generate the most user engagement?
SELECT
    country,
    SUM(reviews) AS Total_Reviews,
    SUM(ratings) AS Total_Ratings
FROM country_apps
GROUP BY country
ORDER BY Total_Reviews DESC;

-- Insight
-- Large review volumes indicate active users rather than just downloads.


-- ========================================
-- Section 2 — Market Comparison
-- ========================================


-- Q5. What percentage of apps are free vs paid in each country?

SELECT
        country,
        SUM(CASE WHEN free='True' THEN 1 ELSE 0 END) AS Free_Apps,
        SUM(CASE WHEN free='False' THEN 1 ELSE 0 END) AS Paid_Apps,
        CAST(
            SUM(CASE WHEN free='True' THEN 1 ELSE 0 END)*100.0/
            COUNT(*)
        AS DECIMAL(5,2)) AS Free_Percentage
FROM country_apps
GROUP BY country;

--Insight
--Shows the monetization preference within each market.

-- Q6. Which countries have the highest average paid app prices?
SELECT
        country,
        CAST(AVG(price) AS DECIMAL(8,2)) AS Avg_Paid_Price
FROM country_apps
WHERE free='False'
GROUP BY country
ORDER BY Avg_Paid_Price DESC;

--Insight
--Prices should be interpreted carefully because they are displayed in local currencies.

--Q7. Which genres dominate each country?

SELECT *
FROM (
    SELECT
        c.country,
        g.genre,
        COUNT(c.app_id) AS Apps,
        RANK() OVER (
            PARTITION BY c.country
            ORDER BY COUNT(c.app_id) DESC
        ) AS rn
    FROM country_apps AS c
    JOIN global_apps AS g
        ON c.app_id = g.app_id
    GROUP BY c.country, g.genre
) AS t
WHERE rn = 1;



--Insight
--Different markets show different category preferences.



-- ==============================================
-- Section 3 — User Behaviour
-- ==============================================

-- Q8. Which countries have the highest average installs per app?

SELECT
        country,
        CAST(AVG(installs) AS DECIMAL(18,2)) AS Avg_Installs
FROM country_apps
GROUP BY country
ORDER BY Avg_Installs DESC;

--Q9. Which countries have the highest average rating count?

SELECT
    country,
    AVG(ratings) AS Avg_Ratings
FROM country_apps
GROUP BY country
ORDER BY Avg_Ratings DESC;


-- Q10. Which countries have the highest average review count?

SELECT
        country,
        AVG(reviews) AS Avg_Reviews
FROM country_apps
GROUP BY country
ORDER BY Avg_Reviews DESC;


-- Q11. Does higher installation lead to more engagement?

SELECT
        country,
        SUM(installs) AS Installs,
        SUM(reviews) AS Reviews
FROM country_apps
GROUP BY country
ORDER BY Installs DESC;

--Insight
--Countries with larger and smaller install bases generally receive more reviews, suggesting higher user engagement.


-- ==============================================
-- Section 4 — Monetization
-- ==============================================


-- Q12. Which countries have the highest paid app adoption?
SELECT
        country,
        SUM(CASE WHEN free='False' THEN 1 ELSE 0 END) AS Paid_Apps,
        CAST(
        SUM(CASE WHEN free='False' THEN 1 ELSE 0 END)*100.0/
        COUNT(*)
        AS DECIMAL(5,2)
        ) AS Paid_Percentage
FROM country_apps
GROUP BY country
ORDER BY Paid_Percentage DESC;


-- Q13. Which genres command the highest paid prices in each country?

SELECT
        c.country,
        g.genre,
        CAST(AVG(c.price) AS DECIMAL(8,2)) AS Avg_Price
FROM country_apps as c
JOIN global_apps as g
  ON c.app_id = g.app_id
WHERE c.free='False'
GROUP BY c.country,g.genre
ORDER BY c.country,Avg_Price DESC;

-- Q14. Which countries have the highest average app prices?

SELECT
        country,
        CAST(AVG(price) AS DECIMAL(8,2)) AS Avg_App_Price
FROM country_apps
GROUP BY country
ORDER BY Avg_App_Price DESC;

-- ===============================================
--Section 5 — Market Opportunity
-- ===============================================

-- Q15. Which countries combine high installs with relatively fewer discovered apps?

SELECT
        country,
        COUNT(DISTINCT app_id) AS Apps,
        SUM(installs) AS Total_Installs,
        CAST(
            SUM(installs)*1.0/
            COUNT(DISTINCT app_id)
        AS DECIMAL(18,2)) AS Installs_Per_App
FROM country_apps
GROUP BY country
ORDER BY Installs_Per_App DESC;

--Insight

--Higher installs per discovered app may indicate attractive markets with strong demand relative to the sampled competition.

-- Q16. Which countries combine high ratings with fewer discovered apps?

SELECT
        country,
        COUNT(DISTINCT app_id) AS Apps,
        CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Rating
FROM country_apps
GROUP BY country
ORDER BY Avg_Rating DESC,Apps ASC;


-- Q17. Which genres perform exceptionally well in individual countries?

SELECT
        c.country,
        g.genre,
        CAST(AVG(c.score) AS DECIMAL(5,2)) AS Avg_Rating
FROM country_apps as c
JOIN global_apps as g
  ON c.app_id = g.app_id
GROUP BY c.country,g.genre
HAVING COUNT(*)>=10
ORDER BY c.country,Avg_Rating DESC;

--Insight
--These genre-country combinations may represent localized opportunities.

-- Q18. In which countries do paid apps achieve the highest ratings?

SELECT
        country,
        CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Paid_Rating
FROM country_apps
WHERE free='False'
GROUP BY country
ORDER BY Avg_Paid_Rating DESC;


-- Q19. In which countries do free apps achieve the highest ratings?

SELECT
        country,
        CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Free_Rating
FROM country_apps
WHERE free='True'
GROUP BY country
ORDER BY Avg_Free_Rating DESC;


-- Q20. Market Opportunity Score (my favorite)


SELECT
country,
COUNT(DISTINCT app_id) AS Apps,
SUM(installs) AS Total_Installs,
CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Rating,
SUM(reviews) AS Total_Reviews
FROM country_apps
GROUP BY country
ORDER BY Total_Installs DESC, Avg_Rating DESC, Total_Reviews DESC;



-- What do users in each market actually download

SELECT *
FROM (
    SELECT
        c.country,
        g.genre,
        SUM(c.installs) AS Total_Installs,
        RANK() OVER (
            PARTITION BY c.country
            ORDER BY SUM(c.installs) DESC
        ) AS rn
    FROM country_apps c
    JOIN global_apps g
        ON c.app_id = g.app_id
    GROUP BY c.country, g.genre
) t
WHERE rn = 1;

-- Which apps have a strong global presence

SELECT TOP 20
    app_id,
    COUNT(country) AS Countries,
    AVG(score) AS Avg_Rating,
    SUM(installs) AS Total_Installs
FROM country_apps
GROUP BY app_id
HAVING COUNT(country) = 10
ORDER BY Total_Installs DESC;


-- Which apps are country-specific successes

SELECT TOP 20
    g.title,
    c.country,
    c.installs
FROM country_apps as c
JOIN global_apps as g
  ON c.app_id = g.app_id
ORDER BY c.installs DESC;


-- Which country has the highest demand for each genre

SELECT *
FROM (
    SELECT
      
        c.country,
          g.genre,
        SUM(c.installs) AS Installs,
        ROW_NUMBER() OVER(
            PARTITION BY g.genre
            ORDER BY SUM(c.installs) DESC
        ) rn
    FROM country_apps c
    JOIN global_apps g
        ON c.app_id = g.app_id
    GROUP BY c.country, g.genre
)t
WHERE rn=1;

--Business Recommendation

--Markets with high installs, strong user ratings, and high engagement should be prioritized for
--expansion, while markets with relatively fewer discovered apps but strong installs per app may present attractive growth opportunities.



SELECT local_tcp_port
FROM sys.dm_exec_connections
WHERE session_id = @@SPID;

SELECT
    SERVERPROPERTY('ServerName') AS ServerName,
    SERVERPROPERTY('InstanceName') AS InstanceName;


EXEC xp_readerrorlog 0, 1, N'Server is listening on';



