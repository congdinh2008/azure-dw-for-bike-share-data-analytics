IF OBJECT_ID('dbo.fact_trips') IS NOT NULL
BEGIN
  DROP TABLE dbo.fact_trips;
END

CREATE TABLE fact_trips(
    trip_id VARCHAR(50),
    rider_id INT,
    date_id INT,
    start_at DATETIME2,
    end_at DATETIME2,
    start_station_id VARCHAR(50),
    end_station_id VARCHAR(50),
    duration INT,
    rider_age_ride_start INT
);

INSERT INTO fact_trips
SELECT
    st.trip_id,
    st.rider_id, 
    FORMAT(CAST(st.start_at AS DATETIME2),'yyyyMMdd'),
    st.start_at,
    st.end_at,
    st.start_station_id, 
    st.end_station_id,
    DATEDIFF(MINUTE,CAST(st.start_at AS DATETIME2),CAST(st.end_at AS DATETIME2)) AS duration,
    DATEDIFF(YEAR, sr.birthday,
        CONVERT(DATETIME, SUBSTRING([start_at], 1, 19),120)) - (
            CASE WHEN MONTH(sr.birthday) > MONTH(CONVERT(DATETIME, SUBSTRING([start_at], 1, 19),120))
            OR MONTH(sr.birthday) =
                MONTH(CONVERT(DATETIME, SUBSTRING([start_at], 1, 19),120))
            AND DAY(sr.birthday) >
                DAY(CONVERT(DATETIME, SUBSTRING([start_at], 1, 19),120))
            THEN 1 ELSE 0 END
    ) AS rider_age_ride_start
FROM staging_trips st
JOIN dim_dates dd ON FORMAT(CAST(st.start_at AS DATETIME2),'yyyyMMdd') = dd.date_id
JOIN staging_riders sr ON st.rider_id = sr.rider_id

SELECT TOP 100 * FROM fact_trips;