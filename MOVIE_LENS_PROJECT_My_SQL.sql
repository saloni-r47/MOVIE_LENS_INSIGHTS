
-- =====================================================
-- PROJECT INFORMATION
-- =====================================================
-- Name: Saloni Rathi
-- Project:  Using MySQL
-- Role: Data Analyst
-- Tool: MySQL
-- Database: MOVIELENS
-- Datasets: movies.csv, ratings.csv
-- SQL Questions: 15
-- Difficulty Levels: Basic, Intermediate, Advanced
--
-- Project Objective:
-- To analyze MOVIE_LENS data using SQL and demonstrate
-- practical skills in data querying, aggregation,
-- JOINs, CTEs, window functions, and data analysis.
-- =====================================================
# MOVIELENS SQL DATA ANALYSIS — PROJECT OVERVIEW

/*This project analyzes the MovieLens movie-rating dataset using MySQL to uncover meaningful patterns in movie popularity, audience ratings,
 user behavior, genre performance, and rating activity over time.

The analysis uses two datasets — `movies.csv` and `ratings.csv` — and consists of 15 SQL questions ranging from basic to advanced analytical problems.
 The project demonstrates practical data-analyst skills including data aggregation, filtering, `JOINs`, subqueries, `GROUP BY`, 
 `HAVING`, Common Table Expressions (CTEs), and SQL window functions.

The analysis focuses on questions such as identifying highly rated and highly rated-volume movies, understanding the distribution of ratings,
 finding the most active users, comparing user-level ratings with the overall platform average, examining rating activity over time,
 ranking movies within genres, calculating cumulative averages, and analyzing month-over-month changes in rating activity.

Overall, the project demonstrates how SQL can be used not only to retrieve data, 
but also to transform raw movie-rating records into actionable analytical insights about movie popularity, 
audience preferences, user behavior, and platform activity.*/

USE movielens;
-- Q1: Top 10 highest rated movies with at least 50 ratings
SELECT 
M.MOVIEID,
M.TITLE,
ROUND(AVG(R.RATING),2) AS AVG_RATINGS,
COUNT(R.RATING) AS NUM_RATINGS
FROM MOVIES as M
JOIN RATINGS AS  R ON M.MOVIEID = R.MOVIEID
GROUP BY M.MOVIEID , M.TITLE
HAVING COUNT(R.RATING)>= 50
ORDER BY AVG_RATINGS DESC
LIMIT 10;


-- Insight:	The	Shawshank	Redemption	(1994)	leads	with	a	4.43	average	across	317	ratings,	followed	by
-- 	The	Godfather	(4.29,	192	ratings) and	Fight	Club	(4.27,	218	ratings).	All	ten	movies	are	decades-old	classics
-- from	the	crime/drama	genre	—	showing	that	high	volume	plus high	average	rating	tends
-- to	favor	well-established , critically acclaimed	films	rather	than	recent	releases


-- Q2: Find the 10 most-rated movies overall, ranked by number of ratings received.
SELECT 
M.MOVIEID,
M.TITLE,
COUNT(R.RATING) AS NUM_RATINGS
FROM MOVIES AS M
JOIN RATINGS AS R ON M.MOVIEID = R.MOVIEID
GROUP BY M.MOVIEID , M.TITLE
ORDER BY NUM_RATINGS DESC
LIMIT 10;


-- Insight:	Forrest	Gump	(329	ratings),	The	Shawshank	Redemption	(317)	and	Pulp	Fiction	(307) are	the	most-rated	titles.	Popularity
-- 	(volume) and	quality	(Q1)	overlap	for	Shawshank,	but	Forrest	Gump, the	single	most-rated	film,	didn't	make	
-- the	Q1	list	—	proving	that	"most	rated" and	"best	rated"	are	different	questions.

-- Q3: Show the distribution of ratings across the platform - i.e. how many times each rating value (0.5 to 5.0) was given.
SELECT 
RATING,
COUNT(*) AS NUM_TIME_GIVEN
FROM RATINGS 
GROUP BY RATING
ORDER BY RATING;


-- Insight:	Whole-number	ratings	dominate:	4.0	is	the	single	most	common	score	(26,818	times),	followed	by	3.0	(20,047)	
-- and	5.0	(13,211). Half-star	ratings	(0.5,	1.5,	2.5,	3.5) are	all	noticeably	less frequent than their neighboring whole numbers,	
-- suggesting	users	default	to	round numbers	when	rating.


-- Q:4  Find the top 10 most active users, ranked by the number of ratings they have submitted.
SELECT 
USERID,
COUNT(*) AS  NUM_RATINGS
FROM RATINGS
GROUP BY USERID
ORDER BY NUM_RATINGS DESC
LIMIT 10;

-- Insight:	User	414	is	by	far	the	most	active,	with	2,698	ratings	—	more	than	double	the	next	most	active	user
-- (599,	with	2,478).	The	top	10 users	alone	account	for	roughly	17,400	of	the	platform's	100,836	ratings	(about	17%),	showing	
-- a	classic	"power	user"	pattern	where	a	small group	drives	a	disproportionate	share	of	activity


-- Q:5 List all movies that belong to the "Comedy" genre. 
SELECT * FROM movies
WHERE GENRES LIKE '%COMEDY%';

-- Insight:	3,756	movies	are	tagged	Comedy	— about	38.6% of the entire	9,742-movie	catalog, making	it	the	single	most 
-- common genre tag in the dataset.

-- Q:6  AVERAGE RATING FOR EACH INDIVIDUAL GENRE
SELECT 
GENRES,
ROUND(AVG(R.RATING),2) AS AVG_RATINGS,
COUNT(*) AS NUM_RATINGS
FROM MOVIES AS GM
JOIN RATINGS AS R ON GM.MOVIEID = R.MOVIEID
GROUP BY GENRES
ORDER BY AVG_RATINGS DESC;

-- Insight:	Film-Noir	has	the	highest	average	rating	(3.92),	followed	by	War	(3.81)	and	Documentary	(3.80).	Horror	sits	at	the	bottom	
-- (3.26), with	Comedy	(3.38)	and	Children	(3.41)	also	below	average	—	niche,	less-frequently-made	genres	tend	to	be	rated	higher,
-- likely	because only	genuinely	dedicated	fans	seek	them	out	and	rate	them.

-- Q7: Popular but relatively poorly rated movies
-- More than 100 ratings and average rating below 3.0

SELECT 
    M.MOVIEID,
    M.TITLE,
    ROUND(AVG(R.RATING), 2) AS AVG_RATING,
    COUNT(R.RATING) AS NUM_RATINGS
FROM MOVIES AS M
JOIN RATINGS AS R 
    ON M.MOVIEID = R.MOVIEID
GROUP BY M.MOVIEID, M.TITLE
HAVING COUNT(R.RATING) > 100
   AND AVG(R.RATING) < 3.0
ORDER BY AVG_RATING ASC;

-- Insight:
-- The analysis identifies movies that have received more than 100 ratings
-- but maintain an average rating below 3.0. These titles have substantial
-- audience attention despite relatively weaker average ratings, showing
-- that popularity does not necessarily indicate strong audience satisfaction.


-- Q:8 For each user, calculate their average rating and compare it to the platform's overall average rating .
SELECT 
USERID,
ROUND(AVG(RATING),2) AS USER_AVG_RATING,
(SELECT	ROUND(AVG(rating),	2)	FROM	ratings)	AS	overall_avg_rating,
 ROUND(AVG(rating)	-	(SELECT	AVG(rating)	FROM	ratings),	2)	AS	diff_from_overall
 FROM	ratings 
 GROUP	BY	userId 
 ORDER	BY	diff_from_overall;
 
 -- Insight:	The	platform-wide	average	rating	is	3.50.	The	most	generous	user	(userId	53)	averages	a	perfect	5.00	
 -- (+1.50	above	the	platform), while	the	most	critical	user	(userId	442)	averages	just	1.28	(‑2.23	below).	This	wide	
 -- spread	confirms	that	raters	have	very	different	personal "calibration,"	which	matters	if	you	were	building	a	recommendation	
 -- system	—	raw	averages	need	to	be	adjusted	per	user.
 
 
 -- Q:9 Number	of	ratings	submitted	per	year
 SELECT YEAR(FROM_UNIXTIME(timestamp))	AS	rating_year,
 COUNT(*)	AS	num_ratings 
 FROM	ratings 
 GROUP	BY	rating_year 
 ORDER	BY	rating_year;
 
 
--  Insight: Ratings	activity is	uneven	across	time: the	year 2000 saw	a huge spike	of	10,061	ratings	(likely	a	bulk	data-collection	event),
-- while 2017	was	the	most	active	recent	year	with	8,198.	The	earliest	and	latest	years	(1996	and	1998)	recorded	far	fewer	ratings,
-- consistent	with the	platform	ramping	up	and	the	dataset's	collection	window	tapering	off	toward	the	end.
 
 
 -- Q:10 Movies	belonging	to	more	than	3	genres
 SELECT
 movieId, 
 title,
 COUNT(*)	AS	genre_count
 FROM	movies
 GROUP	BY	movieId,	title 
 HAVING	COUNT(*)	>	3 
 ORDER	BY	genre_count	DESC;
 
 
 -- Insight:	1,335	movies	(about	13.7%	of	the	catalog)	carry	more	than	3	genre	tags.	Rubber	(2010)	is	the	most	heavily	tagged
 -- film	with	10 genres,	followed	by	family/animation	crossover	titles	like	Who	Framed	Roger	Rabbit?	and	Enchanted	—	movies	that	
 -- blend	comedy,	fantasy, and	family	appeal	tend	to	accumulate	the	most	genre	tags.
 
 
 -- Q:11 Rank	movies	within	each	genre	by	average	rating
 -- Note:	filtered	to	movies	with	>=	30	ratings	so	the	ranking	is	statistically	meaningful
WITH  movies as( 
	SELECT
	 gm.genre,
	 gm.movieId,
	 gm.title,
	 ROUND(AVG(r.rating),	2)	AS	avg_rating,
	 COUNT(*)	AS	num_ratings 
	 FROM movies as 	gm
	 JOIN	ratings as 	r	ON	gm.movieId	=	r.movieId 
	 GROUP	BY	gm.genre,	gm.movieId,	gm.title 
	 HAVING	COUNT(*)>=	30 )
SELECT
genre,
title, 
avg_rating,
num_ratings, 
RANK()	OVER	(PARTITION	BY	genre	ORDER	BY	avg_rating	DESC)	AS	genre_rank 
FROM	movies 
ORDER	BY	genre,	genre_rank;

-- Insight:	Within	the	Comedy	genre	(min.	30	ratings),	Dr.	Strangelove	(1964)	ranks	#1	(4.27	avg,	97	ratings),	ahead	of	The	Princess
-- Bride (#2,	4.23)	and	Pulp	Fiction	(#3,	4.20).	This	shows	that	partitioned	ranking	surfaces	genre-specific	standouts	that	a	
-- single	overall	"top	rated" list	(Q1)	would	miss.

-- Q12:	Cumulative	average	rating,	ordered	chronologically	by	timestamp
 SELECT 
 userId,
 movieId,
 rating, 
 FROM_UNIXTIME(timestamp)	AS	rated_at, 
 ROUND( AVG(rating)	OVER	(ORDER	BY	timestamp ROWS	BETWEEN	UNBOUNDED	PRECEDING	AND	CURRENT	ROW), 4 )	AS	running_avg_rating 
 FROM	ratings
 ORDER	BY	timestamp;
 
 -- Insight:	The	very	first	rating	recorded	(1996)	starts	the	running	average	at	4.00,	which	briefly	swings	as	more	early	ratings	come
 -- in,	then stabilizes.	By	the	final	rating	in	the	dataset	(2018),	the	cumulative	average	settles	at	3.5016	—	matching	the	platform-wide	
 -- average	almost exactly,	which	confirms	the	dataset	is	internally	consistent	and	large	enough	for	the	running	average	to	converge.
 
 
-- Q:13 	Users	who	rate	at	least	1	point	above	or	below	the	platform	average
SELECT
userId,
ROUND(AVG(rating),	2)	AS	user_avg_rating,
ROUND(AVG(rating)	-	(SELECT	AVG(rating)	FROM	ratings),	2)	AS	deviation 
FROM	ratings 
GROUP	BY	userId 
HAVING	ABS(AVG(rating)	-	(SELECT	AVG(rating)	FROM	ratings))	>	1 
ORDER	BY	deviation	DESC;

-- Insight:	24	out	of	610	users	(about	3.9%)	deviate	by	more	than	a	full	point	from	the	platform	average	of	3.50	—	a	mix	of	
-- consistently	very generous	raters	(up	near	5.0)	and	consistently	harsh	critics	(as	low	as	1.28).	Flagging	these	users	would	be	a	
-- useful	first	step	before	building any	rating-based	recommendation	model,	since	their	scores	may	need	normalization.



-- Q14: Top 3 most-rated movies per genre

WITH genre_counts AS (
    SELECT
        M.GENRES,
        M.MOVIEID,
        M.TITLE,
        COUNT(R.RATING) AS NUM_RATINGS
    FROM MOVIES AS M
    JOIN RATINGS AS R
        ON M.MOVIEID = R.MOVIEID
    GROUP BY
        M.GENRES,
        M.MOVIEID,
        M.TITLE
),

ranked_movies AS (
    SELECT
        GENRES,
        MOVIEID,
        TITLE,
        NUM_RATINGS,
        ROW_NUMBER() OVER (
            PARTITION BY GENRES
            ORDER BY NUM_RATINGS DESC
        ) AS RN
    FROM genre_counts
)

SELECT
    GENRES,
    MOVIEID,
    TITLE,
    NUM_RATINGS
FROM ranked_movies
WHERE RN <= 3
ORDER BY
    GENRES,
    NUM_RATINGS DESC;
    -- Insight:
-- The analysis identifies the three most-rated movies within each genre.
-- This shows that rating popularity varies by genre, with certain movies
-- consistently attracting substantially more audience ratings than other
-- titles in the same genre. Ranking movies separately within each genre
-- provides a more meaningful view of genre-specific popularity than using
-- one overall popularity ranking.
    
 -- Q15:	Month-over-month	%	change	in	the	number	of	ratings	submitted
 WITH	monthly_counts AS	(
 SELECT 
 DATE_FORMAT(FROM_UNIXTIME(timestamp),	'%Y-%m')	AS	rating_month, 
 COUNT(*)	AS	num_ratings 
 FROM	ratings
 GROUP	BY	rating_month
 ) 

 SELECT 
 rating_month,
 num_ratings, 
 LAG(num_ratings)	OVER	(ORDER	BY	rating_month)	AS	prev_month_ratings,
 ROUND( (num_ratings	-	LAG(num_ratings)	OVER	(ORDER	BY	rating_month)) /	LAG(num_ratings)	OVER	(ORDER	BY	rating_month)	*	100, 2 )	AS	pct_change
 FROM	monthly_counts 
 ORDER	BY	rating_month;
 
 -- Insight:	The	dataset	spans	267	distinct	months	of	activity	with	highly	volatile	month-over-month	swings	—	some	months	jump
 -- by	100300%	(e.g.	a	+313%	spike	in	May	2018)	while	others	fall	by	50–75%	the	very	next	month.	This	spiky	pattern	is	typical	
 -- of	an	activity	log driven	by	occasional	bulk	imports	and	individual	binge-rating	sessions	rather	than	steady	daily	usage.
 
 # OVERALL INSIGHTS

/*The MovieLens analysis provides a comprehensive view of movie popularity, audience ratings, user behavior, genre performance, and rating activity over time.

* **Movie popularity and rating quality are distinct measures.** The most-rated movies are not necessarily the highest-rated movies. For example,
 Forrest Gump has the highest rating volume, while The Shawshank Redemption leads the high-average-rating analysis. 
 This shows why both rating volume and average rating should be considered when evaluating movie performance.

* **Highly rated movies tend to be established titles.** Among movies with at least 50 ratings, 
The Shawshank Redemption has the highest average rating at 4.43, followed by The Godfather and Fight Club. 
This indicates strong audience reception for several well-established films.

* **Whole-number ratings are more common than half-star ratings.** A rating of 4.0 is the most frequently submitted score, 
followed by 3.0 and 5.0. This indicates a clear preference for rounded rating values within the dataset.

* **Rating activity is concentrated among highly active users.** User 414 is the most active user with 2,698 ratings, 
while the top 10 users together contribute a substantial share of the platform's 100,836 ratings. This demonstrates a noticeable power-user pattern.

* **Comedy is highly represented in the movie catalog.** The dataset contains 3,756 movies tagged with Comedy,
 making it one of the most prominent genre classifications in the catalog.

* **Genre-level ratings vary considerably.** Film-Noir has the highest average rating at 3.92, 
followed by War and Documentary, while Horror has the lowest average among the analyzed genre groups at 3.26. 
This demonstrates that audience ratings differ across genre categories.

* **Popularity does not automatically imply high audience satisfaction.** 
The  Q7 analysis examines movies with more than 100 ratings and an average rating below 3.0. 
This separates movies with substantial rating volume from movies with strong average audience reception and provides a
useful way to identify titles with high attention but comparatively weaker ratings.

* **Users have substantially different rating tendencies.** The overall platform average is approximately 3.50, 
while individual users can have significantly higher or lower personal averages. 
This indicates that user-specific rating behavior should be considered when comparing ratings across users.

* **Only a small proportion of users strongly deviate from the platform average.** 
The analysis identifies 24 out of 610 users whose average rating differs from the overall average by more than one point. 
Such differences demonstrate the importance of considering individual rating calibration in user-level analysis.

* **Movie classification is often multi-genre.** A significant number of movies belong to more than three genre categories,
 showing that many titles cannot be represented adequately by a single genre.

* **Genre-specific ranking provides a more detailed view of movie performance.** 
The Q11 analysis ranks movies within individual genres using average rating and a minimum threshold of 30 ratings. 
The  Q14 analysis similarly identifies the three most-rated movies within each genre. 
Together, these analyses show that movie performance can differ substantially depending on whether quality or popularity is being measured.

* **Rating activity changes significantly over time.** Annual and monthly analyses show substantial variation in the number of ratings submitted.
 The monthly analysis particularly demonstrates sharp increases and decreases between consecutive months rather than a smooth pattern of activity.

* **The cumulative average rating stabilizes over time.** 
The running average begins with greater movement in the early records and gradually converges toward approximately 3.50 by the end of the dataset, 
consistent with the overall platform average.

## Final Takeaway

Overall, the MovieLens dataset demonstrates that movie analytics requires multiple perspectives.
 Rating volume measures popularity, average rating measures audience reception, 
 genre analysis provides contextual comparisons, user-level analysis reveals differences in rating behavior,
 and time-based analysis shows how platform activity changes over time.

The project demonstrates how MySQL can transform raw movie and rating records into structured analytical insights using JOINs, 
aggregation, filtering, subqueries, CTEs, and window functions. 
These techniques can support practical applications such as movie recommendation analysis, audience behavior analysis, popularity analysis, 
and user-rating normalization.
