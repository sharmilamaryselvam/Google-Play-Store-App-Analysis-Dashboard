
-- Google Play Store Global App Analysis (SQL)

-- Business Objective

-- Analyze the Google Play Store ecosystem to understand market size, competition, monetization strategies, developer landscape, and factors associated with app success.

-- Section 1 — Executive Overview

-- Q1. How large is the Play Store ecosystem?

UPDATE global_apps
SET genre = 'Education'
WHERE genre = 'Educational'



SELECT
    COUNT(*) AS Total_Apps,
    COUNT(DISTINCT developer) AS Total_Developers,
    COUNT(DISTINCT genre) AS Total_Genres
FROM global_apps;




-- Q2. What is the average app quality and popularity?


SELECT
    CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Rating,
    CAST(AVG(installs) AS DECIMAL(18,2)) AS Avg_Installs,
    CAST(AVG(reviews) AS DECIMAL(18,2)) AS Avg_Reviews
FROM global_apps;




-- Q3. What percentage of apps are free vs paid?


SELECT
    CASE
        WHEN free = 'True' THEN 'Free'
        ELSE 'Paid'
    END AS App_Type,

    COUNT(*) AS Apps,

    CAST(
        COUNT(*)*100.0/
        SUM(COUNT(*)) OVER() AS
        DECIMAL(10,2)
    ) AS Percentage
FROM global_apps
GROUP BY free;



-- Section 2 — Genre Analysis

-- Q4. Which genres contain the most apps?


SELECT
    genre,
    COUNT(*) AS Total_Apps,
    CAST(COUNT(*) * 100.0/(SELECT COUNT(*) FROM global_apps) AS DECIMAL(5,2))AS Percentage
FROM global_apps
GROUP BY genre
ORDER BY Total_Apps DESC;

--Finance, Education and Productivity has the most app



-- Q5. Which genres have the highest average rating?


SELECT
    genre,
    CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Rating
FROM global_apps
GROUP BY genre
HAVING COUNT(score) >= 10
ORDER BY Avg_Rating DESC;

-- Word-73 (0.66%), puzzle-240 (2.15%) and action-152 (1.36%) genres are having highest average rating. 
--Finance, Education, Productiviy which are having most apps are in the bottm 10 ratings. 
--Genres with the largest number of apps are not necessarily the highest rated, 
--indicating that market saturation does not guarantee higher user satisfaction.



-- Q6. Which genres receive the most installs?


SELECT
    genre,
    SUM(installs) AS Total_Installs
FROM global_apps
GROUP BY genre
ORDER BY Total_Installs DESC;

-- Tools, Communication and Productivity having highest installs. 
--High-rated genres are not necessarily the most installed, 
--indicating that popularity and user satisfaction measure different aspects of app success.




-- Q7. Which genres generate the most user engagement?


SELECT
    genre,
    SUM(ratings) AS Total_Ratings,
    SUM(reviews) AS Total_Reviews
FROM global_apps
GROUP BY genre
ORDER BY Total_Reviews DESC;

-- Coomunication, Social, Finance having having hishest review. Most rated apps, install, no of apps are having averege engagement with users


-- Q8. Which genres charge the highest prices?


SELECT
    genre,
    CAST(AVG(price) AS DECIMAL(8,2)) AS Avg_Paid_Price
FROM global_apps
WHERE free = 'False'
GROUP BY genre
ORDER BY Avg_Paid_Price DESC;

--Video Players & Editors, LifeStyle, Business are having highes paid price. 




-- Section 3 — Developer Analysis

-- Q9. Which developers publish the most apps?


SELECT TOP 10
    developer,
    COUNT(*) AS Total_Apps
FROM global_apps
GROUP BY developer
ORDER BY Total_Apps DESC;




-- Q10. Which developers maintain highly rated portfolios?


SELECT 
    developer,
    COUNT(*) AS Total_Apps,
    CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Rating
FROM global_apps
GROUP BY developer
HAVING COUNT(*) >= 3
ORDER BY Avg_Rating DESC;

-- Only one developer having high rated (Top 10 )profile with high app published. Publishing high No. of apps doesn't mean high rated profile




-- Q11. Which developers attract the most installs?


SELECT 
    developer,
    SUM(installs) AS Total_Installs
FROM global_apps
GROUP BY developer
ORDER BY Total_Installs DESC;

--Google, Samsung, Meta attract the installs. So developers play the crucial roles in installation.




-- Q12. Which developers receive the most reviews?


SELECT TOP 10
    developer,
    SUM(reviews) AS Total_Reviews
FROM global_apps
GROUP BY developer
ORDER BY Total_Reviews DESC;


-- Google, Meta, Instagram having lots of reviews. Apps with larger install bases also tend to receive more reviews, 
--suggesting a positive relationship between adoption and user engagement.



-- Section 4 — Monetization Analysis

-- Q13. What monetization models are most common?


SELECT

        SUM(CASE WHEN ad_supported=1 THEN 1 END) AS Ad_Supported,

        SUM(CASE WHEN ad_supported=0 THEN 1 END) AS No_Ads,

        SUM(CASE WHEN in_app_purchases=1 THEN 1 END) AS In_App_Purchases,

        SUM(CASE WHEN in_app_purchases=0 THEN 1 END) AS No_In_App_Purchases

FROM global_apps;

-- Apps without ads is higher than with ads. No of apps having In_app_purchase is higher




-- Q14. What is the average paid app price?


SELECT

CAST(AVG(price) AS DECIMAL(8,2)) AS Avg_Paid_Price

FROM global_apps

WHERE free='False';




-- Q15. Do paid apps receive better ratings?


SELECT

        CASE
        WHEN free= 'True' THEN 'Free'
        ELSE 'Paid'
        END AS App_Type,

        CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Rating

FROM global_apps

GROUP BY free;

--Free apps have a slightly higher average rating than paid apps; 
--however, the difference is only about 0.1 points, suggesting that pricing alone has little influence on user satisfaction.



-- Q16. Do ad-supported apps receive better ratings?


SELECT
        CASE
            WHEN ad_supported=1 THEN 'Ads'
            ELSE 'No Ads'
        END AS Monetization,
        CAST(AVG(score) AS DECIMAL(5,2)) AS Avg_Rating
FROM global_apps
GROUP BY ad_supported;

--Ad-supported apps show a slightly higher average rating, although the difference is small. Yes, ad supported apps having better ratings


-- Q17. Do apps with in-app purchases receive better ratings?


SELECT
        CASE
            WHEN in_app_purchases=1 THEN 'IAP'
            ELSE 'No IAP'
        END,
        CAST(AVG(score) AS DECIMAL(5,2)) as Avg_ratings
FROM global_apps
GROUP BY in_app_purchases;

--Apps offering in-app purchases achieve a noticeably higher average rating (4.0 vs 3.5),
--suggesting that successful freemium apps may deliver greater ongoing value and engagement for users.



-- Section 5 — Success Analysis

-- Q18. Top 10 highest-rated apps


SELECT TOP 10
       title,
       score,
       ratings,
       reviews,
       genre,
       developer,
       in_app_purchases,
       ad_supported,price
FROM global_apps
ORDER BY score DESC, ratings DESC;

--Several Finance applications appear among the highest-rated apps, suggesting strong user satisfaction within this category. 
--However, ratings should be interpreted alongside review volume and install counts.




-- Q19. Top 10 most-installed apps


SELECT TOP 10
        title,
        installs,
        genre,
        developer,
        in_app_purchases,
        ad_supported,price
FROM global_apps
ORDER BY installs DESC;


--Large technology companies such as Google and Meta dominate install counts, likely due to 
--their established ecosystems and pre-installed applications.
--Communication, Productivity, Tools and Social applications dominate global installs because they satisfy everyday user needs.



-- Q20. Top 10 most-reviewed apps


SELECT TOP 10

        title,
        reviews,
        genre,
        developer,
        in_app_purchases,
        ad_supported,price

FROM global_apps

ORDER BY reviews DESC;

-- Social, communication , music, video player from well known developers having highest reviews. So they being engaged with users.
-- All of them are providing IAP, above half of them having ads and they are free



-- Genres most relied on ads
SELECT
    genre,
    COUNT(*) AS total_apps,
    SUM(CASE WHEN ad_supported=1 THEN 1 ELSE 0 END) AS ad_supported_apps,
    CAST(
        SUM(CASE WHEN ad_supported=1 THEN 1 ELSE 0 END)*100.0/
        COUNT(*)
        AS DECIMAL(5,2)
    ) AS ad_percentage
FROM global_apps
GROUP BY genre
ORDER BY ad_percentage DESC;

-- Genres most relied on in-app-purchase

SELECT
    genre,
    COUNT(*) AS total_apps,
    SUM(CASE WHEN in_app_purchases=1 THEN 1 ELSE 0 END) AS iap_supported_apps,
    CAST(
        SUM(CASE WHEN in_app_purchases=1 THEN 1 ELSE 0 END)*100.0/
        COUNT(*)
        AS DECIMAL(5,2)
    ) AS iap_percentage
FROM global_apps
GROUP BY genre
ORDER BY iap_percentage DESC;





-- ============================================
-- Key Business Findings
-- ============================================


--1. Free apps dominate the Play Store ecosystem.

--2. Finance, Education and Productivity contain the highest number of published apps.

--3. High app volume does not necessarily translate into higher user ratings.

--4. Google and Meta dominate installs and user engagement.

--5. Communication and Productivity generate the largest install volumes.

--6. Finance apps appear frequently among the highest-rated applications.

--7. Ad-supported apps show only a marginal rating advantage.

--8. Apps with in-app purchases have substantially higher average ratings than those without.

--9. Premium app pricing varies considerably across genres.

--10. Different success metrics (installs, ratings, reviews) highlight different market leaders.
