# How I Started This Project 

First Lets make a work flow how we will approach the problem..

For that I read the requirements pdf which was given by the Company..

So after anaylzing the pdf I found we have to make a sqflite version 

So for that Lets make a Database schema such that it will help us in our backend 

main three operations in our database includes update add and delete tasks for the users tasks 



## So lets Jump to making the Sqflite database

So I added first the main dependencies which where needed for this project for database to start googled flutter package which are sqflite 
to get its latest version similarily paths also such that there are no version issues later 


Then I made a new directory called services which has the script which Intializes the database in the app for first time 


not only intializing the data base but we need to make the schemas design which get made when the app is first opened and the sqflite in the
database is made so lets initalize it and make its first parameters

So now basically beacause of the time constraints we do not have the time to create an image of the database schema so for that I created a table which
has coloumn like this 


################# TABLE tasks ########################

---- ID ---- Content ---- Priority ---- Status -----
---- Int Primary Key ---- String Not Null ---- Int ---- Status Not Null -----



So after that in the database_service.dart file I have added the CRUD operations such as add, delete and update for the start to confirm it is working lets validate this also 
