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


Also made a Model for tasks which has all the content and making it as a object for accessing it in other dart files also '



After making a rough CRUD operations and checking it using a normal UI I have commited my code now



## Now moving to advanced Database Like Migrations and error Handling 


For advanced Error Handling I have used Logger package which is easier to log message and also can be used via Remote Error handling which flutter Crashlytics already Provides 


Also Added one Data Migration Scheme where I have added a Duedate column Which I missed So Now our column Look Like this 

---- ID ---- Content ---- Priority ---- Status ----- DueDate?------
---- Int Primary Key ---- String Not Null ---- Int ---- Status Not Null ----- Date Which Can be null--------

handled all the neccessary Error handling And dealt with the data Migration in version 2 part where the column  Duedate will be added without changing the database 
just altering or adding the column in that just to make sure when one coloumn



## Now After this lets manage the state Flow Or The backend Struture with RiverPod

Now I have first made few changes to my yaml file I have added riverpod in it to make the backend and state management.

After anaylzing the App architecture I found out that I needed to wrap the database by repository layer such that all the db execution and all
is being done in the is repo layer only so made a task repository layer which has all the methods to be called to the database service layer

after making the repo now I have made 
