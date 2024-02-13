#Data Normalization Project
##Author: Ruthanne Ward
##Class: Spatial Database
##Assignment: Lab 2
##Description: During this lab I learned how to normalize a table to 1NF and 2NF. I also practiced writing a report in markdown and using git to share my work on github. 

**Objectives**
The objective of this lab is to normalize a table of three parks and their facilities into 1NF and 2NF format. 

**Methods""
First, the table Parks_Info is created.

It has three columns, ID, ParkName and Facilities. This table is not in 1NF becuase the Facilities column contains multiple entries for each park. Two new tables, Parks and Facilities are created to fix this problem.



The Parks table has two columns, ParkID and ParkName. 

The Facilities table has three columns, ParkID, FacilityID and FacilityName. Now, each column has one value per row. The two tables are connected via the ParkID column through the use of the "Foreign Key" and "Refference" commands. 


The Parks and Facilities tables satisfy 1NF rules becuase all table cells contain atomic values, each column or attribute has a unique name, the order in which data is stored does not affect the database’s integrity and each column contains values of a single type.

Next, the data undergoes another transformation to satisfy the 2NF format. The table, ParkFacilities, is made to seperate out the facilities and give each facility a unique ID. The ParkFacilities table has two columns, FacilityID and FacilityName. 

Next, the Facilities table is edited to include a new column, ParkFacilityID. The Facilities table is then linked to the ParkFaciltiies table, matching each facility which its corresponding ID from ParkFacilities. Finally, the FacilityName column is deleted from the Facilities table and replaced with the corresponding unique ID from teh FacilityID column. This process removes the partial dependency by seperating the facilityname into a seperate table and inserting a unique ID for each facility into the Facilities table. 