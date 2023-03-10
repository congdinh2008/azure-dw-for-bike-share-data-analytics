# Building an Azure Data Warehouse for Bike Share Data Analytics

## Project Overview
Divvy is a bike sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another station. The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can analyze the data.

Since the data from Divvy are anonymous, we have created fake rider and account profiles along with fake payment data to go along with the data from Divvy. The dataset looks like this:
<img src="./images/divvy-erd.png" title="Divvy ERD">
Relational ERD for the Divvy Bikeshare Dataset (with fake data tables)

The goal of this project is to develop a data warehouse solution using Azure Synapse Analytics. You will:
- Design a star schema based on the business outcomes listed below;
- Import the data into Synapse;
- Transform the data into the star schema;
- and finally, view the reports from Analytics.

The business outcomes you are designing for are as follows:

Analyze how much time is spent per ride
- Based on date and time factors such as day of week and time of day
- Based on which station is the starting and / or ending station
- Based on age of the rider at time of the ride
- Based on whether the rider is a member or a casual rider

Analyze how much money is spent
- Per month, quarter, year
- Per member, based on the age of the rider at account start

EXTRA CREDIT - Analyze how much money is spent per member
- Based on how many rides the rider averages per month
- Based on how many minutes the rider spends on a bike per month

## Tasks for the project
### Task 1: Create your Azure resources
1. Create an Azure PostgreSQL database
2. Create an Azure Synapse workspace
3. Create a Dedicated SQL Pool and database within the Synapse workspace

<img src="./images/all_resources.png" title="Divvy ERD">

### Task 2: Design a star schema
<img src="./images/divvy_star_schema.jpg" title="Divvy Star Schema">

### Task 3: Create the data in PostgreSQL
<img src="./images/import_data.png" title="Import Data">

### Task 4: EXTRACT the data from PostgreSQL
<img src="./images/load_data_from_postgreSQL_to_blob_storage_2.png" title="EXTRACT the data from PostgreSQL">

<img src="./images/load_data_from_postgreSQL_to_blob_storage.png" title="EXTRACT the data from PostgreSQL">

### Task 5: LOAD the data into external tables in the data warehouse
#### SQL Scripts: ./external_scripts/*.sql
#### Station
<img src="./images/external_stations.png" title="External Station">

#### Rider
<img src="./images/external_riders.png" title="External Rider">

#### Payment
<img src="./images/external_payments.png" title="External Payment">

#### Trip
<img src="./images/external_trips.png" title="External Trip">

### Task 6: TRANSFORM the data to the star schema
#### SQL Scripts: ./transformation_scripts/*.sql
#### Dimension Stations
<img src="./images/dim_stations.png" title="Dimension Stations">

#### Dimension Dates
<img src="./images/dim_dates.png" title="Dimension Dates">

#### Dimension Riders
<img src="./images/dim_riders.png" title="Dimension Riders">

#### Fact Trips
<img src="./images/fact_trips.png" title="Fact Trips">

#### Fact Payments
<img src="./images/fact_payments.png" title="Fact Payments">

### End