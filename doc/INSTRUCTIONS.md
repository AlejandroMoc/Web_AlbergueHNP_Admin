# Setup and Instructions

These steps are necessary for both local installation and installation on a closed network.

## Prerequisites

Before you begin, it is important to have the following:

- [Node.js](https://nodejs.org/) (which includes npm)
- [PostgreSQL](https://www.postgresql.org/download/)
- [pgAdmin 4](https://www.pgadmin.org/download/)

<!-- To run the project, it is necessary to import the database from the "dump" folder into a MySQL database. In this case, PostgreSQL with PGAdmin4 is used.

Likewise, it is necessary to change these values in the [db_connection.js](server/db_connection.js) file.
It is also necessary to modify the API_URL value in the [App.jsx](client/src/App.jsx) file with the system's local IP address. This can be found while running the client  -->

## Prerequisites

Before you begin, it is important to have the following:

- [Node.js](https://nodejs.org/) (which includes npm)
- [PostgreSQL](https://www.postgresql.org/download/)
- [pgAdmin 4](https://www.pgadmin.org/download/)

## 1. Database Setup (PostgreSQL)

1. **Install and start PostgreSQL**:

   It is necessary to make sure that PostgreSQL server is running.

   ```bash

   # Install PostgreSQL
   sudo pacman -S postgresql
   sudo pacman -S postgresql-openrc

   # Initialization
   sudo mkdir -p /var/lib/postgresql
   sudo chown -R postgres:postgres /var/lib/postgresql
   sudo -u postgres initdb -D /var/lib/postgresql/data

   # For OpenRC
   sudo rc-update add postgresql default
   sudo rc-service postgresql start

   # For systemctl
   sudo systemctl enable postgresql
   sudo systemctl start postgresql
   ```

2. **Create the database**:

   Use the `psql` command-line tool to create a new database for this project.

   ```bash
   # 
   sudo -u postgres psql
   ```

   ```sql

   // Create the DB
   CREATE DATABASE gestionAlbergue;

   // Give password if needed
   ALTER USER postgres WITH PASSWORD 'my_password';

   // Exit the console
   \q
   ```

   Go to the main path of the project and restore the `dump/dump_2.26_data.sql` file, which is the initial data.

   ```bash
   pg_restore --clean --if-exists --no-owner --username=postgres --dbname=gestionAlbergue dump/dump_2.26_data.sql
   ```

3. **Install pgAdmin 4**:

   ```bash
   yay -S pgadmin4-server-bin pgadmin4-desktop-bin

   # For OpenRC
   sudo rc-update add postgresql default
   sudo rc-service postgresql start

   # For systemctl
   sudo systemctl enable postgresql
   sudo systemctl start postgresql
   ```

   Once installed, run pgAdmin 4:

   ```bash
   /usr/pgadmin4/bin/pgadmin4
   ```

   Inside pgAdmin4, create a new server in the default "Servers" group in the sidebar.
   Right click the "Servers" group and create "Register".

   Inside the new interface write the following parameters:

   - Name: Localhost

   Inside the "Connection" tab:

   Host name/address: localhost
   Port: 5432
   Maintenance database: postgres
   Username: postgres
   Password: my_password (the pasword assigned previously)

   Finally click on "Save"
---

## 2. Backend Setup (`/server` directory)

The backend is a Node.js application.

1. **Navigate to the server directory**:

   Navigate to the `/server` directory of this project and install the npm dependencies.

   ```bash
   cd server
   npm install
   ```

2. **Create an environment file**:

   The server needs a `.env` file to store sensitive information like database credentials. Copy the file named `.env.example` in the `/server` directory to a new `.env` file.

   Modify the file correspondingly:

   ```env
   # PostgreSQL Database Connection
   DB_USER=username
   DB_HOST=localhost
   DB_DATABASE=gestionAlbergue
   DB_PASSWORD=my_password
   DB_PORT=5432
   ```

3. **Run the server**:

   Still inside the `/server` directory, run the backend:


   For development with automatic reloading (uses `nodemon`):
   ```bash
   npm run dev
   ```

   For production:

   ```bash
   npm start
   ```

   The server should now be running, typically on a port like `8800` or `3001`. Check the terminal output for the exact URL.

   ***

## 3. Frontend Setup (`/client`)

The frontend is a React application.

1. **Navigate to the client directory** (from the project's root):

   ```bash
   cd client
   ```

2. **Install dependencies**:

   ```bash
   npm install
   ```

3. **Run the client**:

   ```bash
   npm start
   ```

4. **Access the application**:

   This will automatically open a new tab in your web browser. 
   If it doesn't, you can access it at [http://localhost:3000](http://localhost:3000).

---

<!-- 
## Deployement

It is possible to use Docker for a remote installation of this system. To do this, after having installed Docker:

In the client folder, run the following command:

    docker image build -t gestion-front-image:latest .

In the server folder, run:

    docker image build -t gestion-back-image:latest .

Once this is done, navigate to the address set in API_URL (for example, http://192.168.1.68:8008). Anyone on the network should be able to access the system with this same URL. -->