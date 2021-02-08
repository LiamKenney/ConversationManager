# ConversationManager
Full-stack web app created with React, Express, Node.JS, and MSSQL to view conversations, messages, and thoughts.


Getting Started

If you do not have a database management system, please start by downloading [Microsoft SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15) and follow their instructions for installation.

Once MS SQL Server is installed on you computer, click cancel on the "Connect to Server" login pop-up window and instead navigate to the top menu. Clicking Registered Servers under the View tab will bring up the Registered Servers window, with a single entity called "Database Engine". Expanding the Database Engine will reveal a folder called "Local Managemenet Servers". Right click this folder and click Tasks > Register Local Servers to create your local servers. The name of your local server can be found in the Local Server Groups folder once expanded. Make sure that your local server is the name of your host machine and "sqlexpress", i.e. "hostname/sqlexpress". If your local server does not appear named like this, rename your local server to "hostname/sqlexpress".

You can now connect to your local database. Click File > "Connect Object Explorer..." and choose your local server. Windows authentication will make the authentication much simpler. Once your server is up and you are connected, open "ConversationManagerInit.sql" in MS SQL Server and click execute to create necessary tables, stored procedures, and mock data.

Once the database is set up fully, you can cd into the backend folder first. Run "npm install" to install necessary dependancies first, then run "npm start" to start the backend server or "npm run debug" to start the server with a logger. If no errors are shown, the Node server is working.

Change directories into ../app to start the front-end server. Similarly, run "yarn install" to install dependancies and "yarn start" to start the server. The front-end server will be hosted at localhost:3000, while the back-end is hosted at localhost:8080. 


Using the app

Once both servers are up and running, you can navigate to localhost:3000 in your browser to view the app. Users can view all conversations here. Each conversation can be opened to reveal the message responses to that conversation topic. Each message is also tagged with thoughts that help categorize the message. Users can add new conversations using the input field at the bottom of the page to enter a new title, then hit create. Each conversation can be opened to reveal an input section for new messages, and similarly with new thoughts by opening individual messages. There is also a search bar at the top of the page that users can use to filter conversation titles.
