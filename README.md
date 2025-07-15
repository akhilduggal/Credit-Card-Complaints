# Credit-Card-Complaints
An interactive Tableau dashboard that examines around 75,000 customer complaint data across 25 variables.

##  Features
- Action filters and parameter controls for dynamic exploration.
- KPI visualizations: complaint counts, response timeliness, closure rates.
- Technical methods include calculated fields, LOD expressions, and data blending.

##  Data Preprocessing (PostgreSQL)

Before visualizing the data in Tableau, I cleaned and prepared the dataset using PostgreSQL. This included:

- **Removing duplicates** to keep only the most recent record for each complaint.
- **Filling missing fields** (like product type and company response) to avoid broken visuals.
- **Calculating `response_days`** – a new field that shows how many days it took for the company to respond to each complaint.  
  > This helps identify delays or trends in response times across different products or companies.
- **Filtering out invalid records**, like rows with missing or negative response times.

These steps ensured the data was clean, complete, and ready for accurate analysis.

See `credit_complaints.sql` for details.

## 📁 Contents
- `credit_complaints.sql` – Data preparation script  
- `complaints.csv` – Source dataset  
- `ComplaintsDashboard.twbx` – Tableau workbook  
- `dashboard_screenshot.png` – Dashboard preview  
