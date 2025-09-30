WITH stg_facebook AS (
    SELECT
        date,
        'Facebook Ads' AS platform,
        campaign_name,
        ad_set_name,
        spend,
        impressions,
        clicks,
        conversions,
        reach,
        frequency,
        CAST(NULL AS NUMERIC) AS conversion_value,
        CAST(NULL AS FLOAT64) AS ctr,
        CAST(NULL AS NUMERIC) AS avg_cpc,
        CAST(NULL AS INT64) AS likes,
        CAST(NULL AS INT64) AS comments,
        CAST(NULL AS INT64) AS shares
    FROM {{ ref('01_facebook_ads') }}
),

stg_google AS (
    SELECT
        date,
        'Google Ads' AS platform,
        ad_group_name AS campaign_name,
        ad_group_name AS ad_set_name,
        cost AS spend,
        impressions,
        clicks,
        conversions,
        CAST(NULL AS INT64) AS reach,
        CAST(NULL AS NUMERIC) AS frequency,
        conversion_value,
        ctr,
        avg_cpc,
        CAST(NULL AS INT64) AS likes,
        CAST(NULL AS INT64) AS comments,
        CAST(NULL AS INT64) AS shares
    FROM {{ ref('02_google_ads') }}
),

stg_tiktok AS (
    SELECT
        date,
        'TikTok Ads' AS platform,
        campaign_name,
        CAST(NULL AS STRING) AS ad_set_name,
        cost AS spend,
        impressions,
        clicks,
        conversions,
        CAST(NULL AS INT64) AS reach,
        CAST(NULL AS NUMERIC) AS frequency,
        CAST(NULL AS NUMERIC) AS conversion_value,
        CAST(NULL AS FLOAT64) AS ctr,
        CAST(NULL AS NUMERIC) AS avg_cpc,
        likes,
        comments,
        shares
    FROM {{ ref('03_tiktok_ads') }}
)

-- UNION of all staged models
SELECT * FROM stg_facebook
UNION ALL
SELECT * FROM stg_google
UNION ALL
SELECT * FROM stg_tiktok