select "NOMBRE", "SEGUIDORES", "TP", "PAÍS", "TEMA DE INFLUENCIA", "ALCANCE POTENCIAL", "GUARDAR", "INVITAR A LA CAMPAÑA", channel_name, total_subscribers, total_views, total_videos
FROM youtube_data.youtube_data;

----Remove unnecessary columns
----Extract the youtube channel names from the first column
----Rename the column names

select "NOMBRE", total_subscribers, total_views, total_videos from youtube_data yd;

---CHARINDEX FUNCTION

----select STRPOS ("NOMBRE", '@'), "NOMBRE" from youtube_data yd;

---SUBSTRING

select substring("NOMBRE", 1, STRPOS ("NOMBRE", '@')) from youtube_data yd;

select substring("NOMBRE", 1, STRPOS ("NOMBRE", '@') -1) from youtube_data yd;

create view view_uk_youtubers_2024 as

select cast(substring("NOMBRE", 1, STRPOS ("NOMBRE", '@') -1) as varchar(100)) as channel_name, total_subscribers,
total_views, total_videos from youtube_data yd;

SELECT channel_name, total_subscribers, total_views, total_videos
FROM youtube_data.view_uk_youtubers_2024;

---## data quality checks

--- 1. The data needs to be 100 records of youtube channels - row count test
---- 2. The data needs 4 fields - column count test
----3. The channels column must be string format and the other columns must be numerical data types - data type check
----4. Each record must be unique in the dataset - duplicate count test

-- Row count - 100
---Column count - 4

--Data types
--Channel_name  = VARCHAR
--total_subscribers = INTEGER
---total_views =  INTEGER
---total_videos = INTEGER

--Duplicate count = 0

--1. The data needs to be 100 records of youtube channels - row count test

select count(*) as no_of_rows from view_uk_youtubers_2024 vuy;

---2. The data needs 4 fields - column count test

select count(column_name) as no_of_columns from information_schema.columns
where table_name = 'view_uk_youtubers_2024';

--- 3. The channels column must be string format and the other columns must be numerical data types - data type check

select column_name, data_type  from information_schema.columns
where table_name = 'view_uk_youtubers_2024';

----4. Each record must be unique in the dataset - duplicate count test

select channel_name, count(*) as duplicate_count from view_uk_youtubers_2024 vuy 
group by channel_name
having count(*) > 1;

select * from view_uk_youtubers_2024 vuy
order by vuy.total_views desc;








