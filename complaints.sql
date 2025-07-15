  /* Description:
    This SQL script prepares complaint data for Tableau analysis by:
      - Removing duplicate complaint entries (keeping most recent by Date Received)
      - Filling missing values in key columns (Product and Company Response)
      - Calculating a new field: response_days (company response time)
      - Removing invalid rows with null or negative response times

  Dataset: complaints.csv
  Final Table: cleaned_complaints

  Cleaning Steps:
    1. Remove duplicate based on "Complaint ID", keeping the latest "Date Received"
    2. Fill NULL values:
         - "Product"            → 'Unknown'
         - "Company response to consumer" → 'No Response'
    3. Compute "response_days" = "Date Submitted" - "Date Received"
    4. Remove rows where "response_days" is NULL or negative
*/

-- Step 1: Remove duplicate complaints, keeping the most recent by Date Received
CREATE TEMP TABLE cleaned_data AS
SELECT * FROM (
  SELECT *,
         ROW_NUMBER() OVER (
           PARTITION BY "Complaint ID"
           ORDER BY "Date Received" DESC
         ) AS rn
  FROM raw_complaints
) sub
WHERE rn = 1;

-- Step 2: Fill missing values
UPDATE cleaned_data
SET "Company response to consumer" = 'No Response'
WHERE "Company response to consumer" IS NULL;

UPDATE cleaned_data
SET "Product" = 'Unknown'
WHERE "Product" IS NULL;

-- Step 3: Add and calculate response_days
ALTER TABLE cleaned_data
ADD COLUMN IF NOT EXISTS response_days INT;

UPDATE cleaned_data
SET response_days = DATE_PART('day', "Date Submitted"::date - "Date Received"::date);

-- Step 4: Remove rows with invalid or negative response times
DELETE FROM cleaned_data
WHERE response_days IS NULL OR response_days < 0;

-- Step 5: Create final cleaned table
DROP TABLE IF EXISTS cleaned_complaints;
CREATE TABLE cleaned_complaints AS
SELECT * FROM cleaned_data;
