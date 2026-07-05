# Google Play Store Market Analysis

An end-to-end Data Analytics project analyzing 11,000+ Google Play Store applications across 10 countries to uncover market trends, developer competition, monetization strategies, and expansion opportunities using Python, SQL, and Power BI.

## Project Overview

The Google Play Store hosts millions of applications competing across different countries, genres, and business models. For developers and publishers, understanding market trends is essential for deciding:

Which categories are saturated?
Which markets offer the best expansion opportunities?
Which monetization strategy performs best?
What characteristics are associated with successful apps?

This project answers these business questions by analyzing app metadata and country-level statistics from ten major Android markets.

## Business Problem

A mobile app publisher wants to expand into international markets but has limited resources. They need data-driven insights to answer the following questions:

* Which app categories are most competitive?
* Which developers dominate the market?
* Which countries generate the highest demand?
* How do user ratings and engagement vary across markets?
* Which monetization strategies are most common?
* Which countries present the best expansion opportunities?
## Dataset

**Source:** Kaggle – Google Play Store App Dataset (2026)

The analysis uses two datasets:

- app_main - Global apps Dataset
- country_apps_stats - Coutry specific Dataset

## Tools used

| Tool            | Purpose                     |
| --------------- | --------------------------- |
| Python (Pandas) | Data Cleaning & Preparation |
| SQL Server      | Business Analysis           |
| Power BI        | Dashboard & Visualization   |
| GitHub          | Version Control & Portfolio |

## Data Cleaning

Performed using Python (Pandas).

Tasks Completed
- Removed duplicate records
- Standardized genre names
- Handled missing values using business-aware decisions
- Removed less than 1% incomplete records
- Preserved missing ratings/reviews where they represented unavailable information
- Cleaned global and country datasets independently to avoid introducing artificial relationships

 ## SQL Business Analysis

The analysis was divided into two major parts.

## Global App Analysis
### Executive Overview
- Market size
- Free vs Paid apps
- Average ratings
- Average installs
  
### Genre Analysis
- Largest app categories
- Highest rated genres
- Most installed genres
- Most reviewed genres
  
### Developer Analysis
- Top publishers
- Highest installed developers
- Highest engagement

### Monetization Analysis
- Free vs Paid
- Ad-supported apps
- In-App Purchase adoption
- Paid pricing strategy

### Success Analysis
- Top installed apps
- Highest rated apps
- Most reviewed apps
## Country Market Analysis
### Country Overview
- Largest markets
- Highest ratings
- User engagement
### Market Comparison
- Free vs Paid by country
- Paid pricing comparison
- Popular genres
### User Behaviour
- Installs
- Ratings
- Reviews
### Market Opportunity
- High-demand markets
- High-rated markets
- Genre-country opportunities

## Dashboard

The Power BI dashboard consists of three interactive pages.

### Executive Overview

<img width="1121" height="717" alt="image" src="https://github.com/user-attachments/assets/fca94806-7cb1-4aa2-9273-8195ffb3ec4a" />


images/page1.png

### Highlights:

- Overall Play Store ecosystem
- Genre distribution
- Developer landscape
- Monetization overview
- Country Market Analysis

<img width="1120" height="722" alt="image" src="https://github.com/user-attachments/assets/ace4c4b9-0651-432d-b253-372c890a279a" />


images/page2.png

### Highlights:

- Market comparison
- Country demand
- User engagement
- Genre preferences
- Market opportunities
- Business Insights & Recommendations

<img width="1142" height="726" alt="image" src="https://github.com/user-attachments/assets/d6ac0c10-bdb5-403c-a883-47810dfbc0f3" />


images/page3.png

### Highlights:

- Top-performing apps
- Leading developers
- Success factors
- Monetization strategies
- Business recommendations

### Key Business Insights
### Market Landscape
- Finance, Education, and Productivity contain the largest number of published apps.
- Communication and Tools dominate global install counts.
### User Satisfaction
- Highly populated genres are not always the highest rated.
- Smaller niche genres often achieve higher average ratings.
### Developer Competition
- Google, Meta, and Samsung dominate install volume.
- Strong developer ecosystems contribute significantly to user adoption.
### Monetization
- Free apps dominate the Play Store ecosystem.
- In-app purchases are adopted more frequently than ad-supported monetization.
- Apps with in-app purchases show slightly higher average ratings.
### Country-Level Insights
- User preferences vary significantly across countries.
- Free apps dominate every market.
- Paid app pricing differs considerably due to local currency differences.
- Several markets demonstrate strong engagement despite lower overall install volumes, suggesting opportunities for niche expansion.

### Business Recommendations

Based on the analysis:

- Focus on Communication, Tools, and Productivity for large-scale user acquisition.
- Use localized genre strategies instead of applying the same portfolio across all markets.
- Consider in-app purchases as the primary monetization strategy.
- Evaluate market opportunities using both user engagement and competition rather than install counts alone.
- Expand into markets that combine strong engagement with relatively lower competition.

  
