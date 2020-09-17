# SQL Portfolio: Data Analysis on the Ford Foundation
This is a SQL-based portfolio to showcase skill in SQL and data anlysis.

## Data Source: Ford Foundation 
The portfolio analysizes the dataset publicly provided by the Ford Foundation, one of America's largest private foundations *with the mission of advancing human welfare*.  Analysis was performed to reveal historical trends of the foundation's grantmaking from 2013 to 2020 at a high level persective, and a deeper look into what the foundation has done so far in 2020.

Most of the database schema tables derive from the Ford Foundation dataset. However, the code for the dim_date table is taken from [this Medium article](https://medium.com/@duffn/creating-a-date-dimension-table-in-postgresql-af3f8e2941ac).

## SQL: PostgreSQL
PostgreSQL was utilized and the queries were directly ran in PgAdmin 4, the management tool for PostgreSQL. The queries aim to bring insight on how well the foundation's committments align with its mission of funding *individuals, institutions, and innovative ideas [world wide] that are at the front lines of social change around the world in areas of civil rights, education, arts and culture, human rights, poverty reduction and urban development*. 

## Data Visualization: Power BI
Power BI was used to connect to the PostgreSQL database and utilized to create visual analysis on the queries. Final presentation are dashboards showing the grants made by the Ford Foundation from a historical perspective and from a current outlook with drill-down information that utilizes slicing/filtering. 
