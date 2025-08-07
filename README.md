# Manager for Puebla Children's Hospital Shelter (Albergue del Hospital del Niño Poblano)

<!-### In collaboration with the Instituto Tecnológico y de Estudios Superiores de Monterrey and the Puebla Children's Hospital Shelter. -->

<!--Ctrl+Shift+V in VSCode to preview this file -->

Application developed from February 19 to June 14, 2024.

Delivered on June 12, 2024.

## General Setup

These steps are necessary for both local installation and installation on a closed network.

To run the project, it is necessary to import the database from the "dump" folder into a MySQL database. In this case, PostgreSQL with PGAdmin4 is used.

Likewise, it is necessary to change these values in the [db_connection.js](server/db_connection.js) file.
It is also necessary to modify the API_URL value in the [App.jsx](client/src/App.jsx) file with the system's local IP address.

## Local Execution

Open the "server" folder and the "client" folder in two separate terminals. Run the following commands in each of the newly opened terminals:

    npm install

    npm start

Navigate to the address set in API_URL (default is localhost:3000).

## Remote Execution

It is also possible to use Docker for a remote installation of this system. To do this, after having installed Docker:

In the client folder, run the following command:

    docker image build -t gestion-front-image:latest .

In the server folder, run:

    docker image build -t gestion-back-image:latest .

Once this is done, navigate to the address set in API_URL (for example, http://192.168.1.68:8008). Anyone on the network should be able to access the system with this same URL.

### Developers

[Hugo Muñoz Rodríguez](https://github.com/hugo1808)

[Daniela Lozada Bracamontes](https://github.com/Daniy23)

[José Luis Zago Guevara](https://github.com/GhulRasal)

[Christian Flores Alberto](https://github.com/christian1444)

[César Guerra Martínez](https://github.com/CesarGMtz)

[Alejandro Daniel Moctezuma Cruz](https://github.com/AlejandroMoc)
