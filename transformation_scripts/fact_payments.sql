IF OBJECT_ID('dbo.fact_payments') IS NOT NULL
BEGIN
  DROP TABLE dbo.fact_payments;
END

CREATE TABLE fact_payments (
	[payment_id] 	BIGINT,
	[amount] 		FLOAT,
	[rider_id] 		BIGINT,
	[date_id] 		INT
);

INSERT INTO fact_payments (
	[payment_id],
	[amount],
	[rider_id],
	[date_id]
)
SELECT
    sp.[payment_id],
    sp.[amount],
    sp.[rider_id],
    dd.[date_id]
FROM [dbo].[staging_payments] sp
JOIN dim_dates dd ON dd.date = sp.date;

SELECT TOP (100) * FROM [dbo].[fact_payments]