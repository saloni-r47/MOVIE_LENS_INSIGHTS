# 🎬 MovieLens SQL Data Analysis Project

## 📌 Project Overview

This project analyzes the **MovieLens movie-rating dataset** using **MySQL** to uncover meaningful patterns in movie popularity, audience ratings, user behavior, genre performance, and rating activity over time.

The project uses two datasets:

- `movies.csv`
- `ratings.csv`

The analysis consists of **15 SQL questions**, ranging from **basic to advanced** analytical problems.

The project demonstrates practical SQL and data-analysis skills including **data aggregation, filtering, JOINs, GROUP BY, HAVING, subqueries, Common Table Expressions (CTEs), and window functions**.

---

## 🎯 Project Objective

The main objective of this project is to transform raw movie-rating data into meaningful analytical insights using SQL.

The analysis focuses on:

- Movie popularity
- Movie rating quality
- Rating distribution
- User activity
- Genre-level performance
- User rating behavior
- Rating activity over time
- Movie ranking within genres
- Cumulative rating analysis
- Month-over-month rating activity

---

## 🛠️ Tools & Technologies

| Tool / Technology     | Purpose                             |
| --------------------- | ----------------------------------- |
| **MySQL**             | Database and SQL analysis           |
| **MySQL Workbench**   | SQL development and query execution |
| **SQL**               | Data analysis and querying          |
| **MovieLens Dataset** | Source data                         |
| **CSV**               | Dataset format                      |

---

## 📂 Dataset

The project uses two MovieLens datasets.

### `movies.csv`

Contains movie information including:

- `movieId`
- `title`
- `genres`

### `ratings.csv`

Contains movie-rating activity including:

- `userId`
- `movieId`
- `rating`
- `timestamp`

The timestamp field is converted into readable date/time information for time-based analysis.

---

## 🗄️ Database

**Database Name:**

```sql
MOVIELENS
```

The project uses the `movies` and `ratings` tables for analysis.

---

# 📊 Analysis Performed

The project contains **15 SQL analytical questions** divided into three levels.

---

## 🟢 Basic Analysis

### Q1. Top 10 Highest-Rated Movies

Identify the top 10 highest-rated movies among movies that have received at least 50 ratings.

This analysis uses:

- `JOIN`
- `AVG()`
- `COUNT()`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`

---

### Q2. Most-Rated Movies

Find the 10 movies that received the highest number of ratings.

This separates **rating popularity** from average rating quality.

---

### Q3. Rating Distribution

Analyze how frequently each rating value from **0.5 to 5.0** was given across the platform.

This helps understand the overall rating behavior of users.

---

### Q4. Most Active Users

Identify the top 10 users based on the number of ratings they submitted.

This reveals the concentration of rating activity among highly active users.

---

### Q5. Comedy Movies

Identify all movies belonging to the **Comedy** genre.

---

### Q6. Average Rating by Genre

Calculate the average rating and number of ratings for each genre grouping.

This allows comparison of rating performance across genre categories.

---

# 🟡 Intermediate Analysis

### Q7. Popular but Poorly Rated Movies

Identify movies that:

- Have received more than 100 ratings
- Have an average rating below 3.0

This demonstrates that high popularity does not necessarily mean high audience satisfaction.

---

### Q8. User Rating Behavior vs Platform Average

Calculate each user's:

- Average rating
- Overall platform average
- Difference between the user's average and the platform average

This helps identify differences in individual rating tendencies.

---

### Q9. Ratings Submitted Per Year

Analyze the number of ratings submitted in each year.

The Unix timestamp is converted into a year using MySQL date/time functions.

---

### Q10. Movies With More Than Three Genres

Identify movies associated with more than three genre classifications.

This provides insight into movies with broader genre categorization.

---

# 🔴 Advanced Analysis

### Q11. Rank Movies Within Each Genre

Rank movies within each genre according to their average rating.

Only movies with at least 30 ratings are considered.

This analysis demonstrates the use of:

```sql
RANK() OVER (
    PARTITION BY genre
    ORDER BY avg_rating DESC
)
```

---

### Q12. Cumulative Average Rating

Calculate the cumulative average rating chronologically using the rating timestamp.

This demonstrates the use of a window function with an explicit frame:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

The analysis shows how the cumulative average changes as more ratings are added.

---

### Q13. Users With Significant Rating Deviations

Identify users whose average rating differs from the overall platform average by more than one point.

This helps identify users with substantially different rating tendencies.

---

### Q14. Top 3 Most-Rated Movies Per Genre

Identify the three most-rated movies within each genre.

This uses:

- CTEs
- `ROW_NUMBER()`
- `PARTITION BY`
- `ORDER BY`

The ranking is performed separately for each genre.

---

### Q15. Month-over-Month Change in Rating Activity

Calculate the monthly number of ratings and compare each month with the previous month.

The analysis uses:

```sql
LAG()
```

to retrieve the previous month's rating count and calculate the percentage change.

---

# 🧠 SQL Concepts Demonstrated

This project demonstrates the following SQL concepts.

### Basic SQL

- `SELECT`
- `WHERE`
- `ORDER BY`
- `LIMIT`
- `DISTINCT`

### Filtering & Aggregation

- `COUNT()`
- `AVG()`
- `GROUP BY`
- `HAVING`

### Joins

- `INNER JOIN`

### Subqueries

- Scalar subqueries
- Subqueries used for comparison with overall averages

### Common Table Expressions

- `WITH`
- Multiple CTE-based analytical queries

### Window Functions

- `OVER()`
- `PARTITION BY`
- `ORDER BY`
- `RANK()`
- `ROW_NUMBER()`
- `LAG()`
- Running / cumulative calculations
- Window frames

### Date & Time Analysis

- `YEAR()`
- `FROM_UNIXTIME()`
- `DATE_FORMAT()`

---

# 📈 Key Insights

## 🎬 Popularity and Rating Quality Are Different

The analysis shows that the most-rated movies are not necessarily the highest-rated movies.

For example, **Forrest Gump** has the highest rating volume in the analysis, while **The Shawshank Redemption** leads the high-average-rating analysis.

This demonstrates why both **rating volume** and **average rating** should be considered when analyzing movie performance.

---

## ⭐ Highly Rated Movies

Among movies with at least 50 ratings, **The Shawshank Redemption** has the highest average rating at **4.43**, followed by **The Godfather** and **Fight Club**.

---

## 👥 Rating Activity Is Concentrated Among Active Users

The project identifies a noticeable concentration of rating activity among highly active users.

User **414** is identified as the most active user with **2,698 ratings**.

---

## 🎭 Genre Performance Varies

Average ratings differ across genre categories.

In the analysis, **Film-Noir** has the highest average rating at **3.92**, followed by **War** and **Documentary**, while **Horror** has the lowest average among the analyzed genre groups at **3.26**.

---

## 📊 Popularity Does Not Always Mean High Satisfaction

The analysis specifically identifies movies with more than 100 ratings but an average rating below 3.0.

This demonstrates that a movie can receive substantial audience attention without having a high average rating.

---

## 👤 Users Have Different Rating Tendencies

The platform-wide average rating is approximately **3.50**.

Individual users can have substantially higher or lower average ratings, demonstrating differences in personal rating behavior.

---

## 🏆 Genre-Specific Ranking Provides More Context

Ranking movies within individual genres provides a more detailed view of movie performance than relying on a single overall ranking.

The project uses window functions to perform these genre-specific rankings.

---

## 📅 Rating Activity Changes Over Time

Annual and monthly analyses show significant variation in rating activity.

The month-over-month analysis demonstrates that rating activity can change substantially between consecutive months.

---

## 📈 Cumulative Average Converges Over Time

The cumulative average rating changes more significantly during the early records and gradually stabilizes as more ratings are included.

By the end of the dataset, the cumulative average approaches approximately **3.50**, consistent with the overall platform average.

---

# 💡 Overall Takeaway

The MovieLens dataset demonstrates that movie analytics requires multiple perspectives.

**Rating volume** measures popularity.

**Average rating** measures audience reception.

**Genre analysis** provides contextual comparisons.

**User-level analysis** reveals differences in rating behavior.

**Time-based analysis** shows how rating activity changes over time.

Together, these analyses demonstrate how SQL can transform raw movie-rating records into structured analytical insights.

---

# 📁 Project Structure

```text
MOVIELENS-MYSQL-PROJECT/
│
├── README.md
│
├── SQL/
│   └── MOVIE_LENS_PROJECT_My_SQL.sql
│
├── Dataset/
│   ├── movies.csv
│   └── ratings.csv
│
└── Screenshots/
    ├── Q1.png
    ├── Q2.png
    ├── Q3.png
    ├── ...
    └── Q15.png
```

> The folder structure above represents the recommended organization of the GitHub repository. Create only the folders/files that you actually upload.

---

# 🚀 How to Run the Project

## Step 1 — Install MySQL

Install **MySQL Server** and **MySQL Workbench**.

---

## Step 2 — Create the Database

Create the MovieLens database:

```sql
CREATE DATABASE MOVIELENS;
```

Then select it:

```sql
USE MOVIELENS;
```

---

## Step 3 — Import the Datasets

Import the following CSV files into their respective tables:

```text
movies.csv
ratings.csv
```

Make sure the table names and column names match the SQL queries.

---

## Step 4 — Open the SQL Project

Open:

```text
MOVIE_LENS_PROJECT_My_SQL.sql
```

in MySQL Workbench.

---

## Step 5 — Execute the Queries

Run the SQL queries from Q1 through Q15 to reproduce the analysis.

Each question contains an analytical query followed by an interpretation of the result.

---

# 📌 Project Highlights

- **15 SQL analytical questions**
- Basic, intermediate, and advanced analysis
- Movie popularity analysis
- Rating distribution analysis
- User behavior analysis
- Genre analysis
- Time-based analysis
- CTE-based analysis
- Window-function analysis
- Ranking analysis
- Running average analysis
- Month-over-month analysis

---

# 🎓 Skills Demonstrated

Through this project, the following practical data-analysis skills are demonstrated:

- SQL Querying
- Data Aggregation
- Data Filtering
- Data Joining
- Grouped Analysis
- Subquery Analysis
- CTEs
- Window Functions
- Ranking
- Time-Series Analysis
- User Behavior Analysis
- Analytical Problem Solving
- Insight Generation

---

# 📌 Project Type

**Data Analytics | SQL | MySQL | MovieLens Dataset**

---

## 👨‍💻 Author

**[Saloni Rathi]**

**Role:** Data Analyst

**Tool:** MySQL
