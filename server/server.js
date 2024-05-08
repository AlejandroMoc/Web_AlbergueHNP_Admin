const express = require('express');
const cors = require('cors');
const app = express();
require('dotenv').config();

const port = process.env.PORT || 8000;

app.use(cors());
app.use(express.json());

const {getAllDispBeds, getAllAreas, getAllClientInfo, registerNewPatient, registerEntradaUnica } = require('./queries/UsernewQueries.js');
const {getAllClients, getClientsByFilter } = require('./queries/UserListQueries.js');
const {getHuespedInfo, getclienteInfoD, getDeudaCliente, getServicioEU, getNewRegister, getTipoCliente}= require('./queries/InfoUserQueries.js');
const {getInfo, regServacio, regPago, regSalida, eliminarCama, anadCama} = require('./queries/RoomAdminQueries.js');
const {getAllUsers, getAllHuespedes, getUserInfo, getAllVisitantes,getAllVetados, getAllGeneralHuespedes, getAllGeneralVisitantes, getAllGeneralVetados, getAllIngresos} = require('./queries/ReportQueries.js');
const {getNewAdmin, getNewLogin, getTokenFromHeader, verifyRefreshToken, generateAccessToken} = require('./queries/LoginQueries.js');
const { verify } = require('jsonwebtoken');

//Funciones para UserNew
app.get('/alldispbeds', async(req, res) => {
    try {
        const beds = await getAllDispBeds();
        res.json(beds);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.post('/registerNewPatient', async(req, res) => {
    try {
        const carnet = req.body.carnet;
        const id_area = req.body.id_area;
        const nombre_p=req.body.nombre_p;
        const apellidos_p=req.body.apellidos_p;
        const nombre_c = req.body.nombre_c;
        const apellidos_c = req.body.apellidos_c;
        const lugar_o=req.body.lugar_o;
        const notas_c=req.body.notas_c;
        const sexo = req.body.sexo;
        const nivel_se=req.body.nivel_se;
        const id_cama=req.body.id_cama;
        // console.log(apellidos_c)
        const pacienteR = await registerNewPatient(carnet, id_area, nombre_p, apellidos_p, nombre_c, apellidos_c, lugar_o, notas_c, sexo, nivel_se, id_cama);
        res.json(pacienteR);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
    }
})  

app.post('/registerEntradaUnica', async(req, res) => {
    try {
        const carnet = req.body.carnet;
        const id_area = req.body.id_area;
        const nombre_p=req.body.nombre_p;
        const apellidos_p=req.body.apellidos_p;
        const nombre_c = req.body.nombre_c;
        const apellidos_c = req.body.apellidos_c;
        const lugar_o=req.body.lugar_o;
        const notas_c=req.body.notas_c;
        const sexo = req.body.sexo;
        const nivel_se=req.body.nivel_se;
        const bathroom = req.body.bathroom;
        const shower=req.body.shower;
        const breakfast=req.body.breakfast;
        const meal=req.body.meal;
        const dinner=req.body.dinner;
        // console.log(apellidos_c)
        const pacienteU = await registerEntradaUnica(carnet, id_area, nombre_p, apellidos_p, nombre_c, apellidos_c, lugar_o, notas_c, sexo, nivel_se,shower, bathroom, breakfast, meal, dinner);
        res.json(pacienteU);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
    }
})  

app.get('/allareas', async(req, res) => {
    try {
        const areas = await getAllAreas();
        res.json(areas);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.post('/allclientinfo', async (req, res) => {
    try {
        const nombre_c = req.body.nombre;
        const apellidos_c = req.body.apellidos;
        const client = await getAllClientInfo(nombre_c, apellidos_c);
        res.json(client);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.get('/allusers', async (req, res) => {
    try {
        const startDate = req.query.startDate; // Obtener fecha de inicio del query string
        const endDate = req.query.endDate; // Obtener fecha de fin del query string
        const allusers = await getAllUsers(startDate, endDate); // Llamar a getAllUsers con las fechas
        res.json(allusers);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Nueva función para obtener todos los huéspedes
app.get('/allhuespedes', async (req, res) => {
    try {
        const allHuespedes = await getAllHuespedes();
        res.json(allHuespedes);
    } catch (error) {
        console.error('Error fetching huespedes:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Nueva función para obtener todos los huéspedes
app.get('/allvisitantes', async (req, res) => {
    try {
        const allVisitantes = await getAllVisitantes();
        res.json(allVisitantes);
    } catch (error) {
        console.error('Error fetching visitantes:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Nueva función para obtener todos los huéspedes
app.get('/allvetados', async (req, res) => {
    try {
        const allVetados = await getAllVetados();
        res.json(allVetados);
    } catch (error) {
        console.error('Error fetching vetados:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.get('/userinfo/:userID', async (req, res) => {
    try {
        const userID = req.params.userID; // Obtiene el userID de los parámetros de la URL
        const clientInfo = await getUserInfo(userID); // Llama a la función que obtiene la información del cliente según el ID
        res.json(clientInfo); // Devuelve la información del cliente como respuesta
    } catch (error) {
        console.error('Error fetching client info:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Funciones para ReportQueries
app.get('/allgeneralhuespedes', async (req, res) => {
    try {
        const startDate = req.query.startDate; // Obtener fecha de inicio del query string
        const endDate = req.query.endDate; // Obtener fecha de fin del query string
        const allgeneralhuespedes = await getAllGeneralHuespedes(startDate,endDate);
        res.json(allgeneralhuespedes);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Funciones para ReportQueries
app.get('/allgeneralvisitantes', async (req, res) => {
    try {
        const startDate = req.query.startDate; // Obtener fecha de inicio del query string
        const endDate = req.query.endDate; // Obtener fecha de fin del query string
        const allgeneralvisitantes = await getAllGeneralVisitantes(startDate,endDate);
        res.json(allgeneralvisitantes);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.post('/allclientinfo', async(req, res) => {
    try {
        const nombre_c = req.body.nombre;
        const apellidos_c = req.body.apellidos;
        // console.log(nombre_c)
        // console.log(apellidos_c)
        const client = await getAllClientInfo(nombre_c, apellidos_c);
        res.json(client);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Funciones para ReportQueries
app.get('/allgeneralvetados', async (req, res) => {
    try {
        const startDate = req.query.startDate; // Obtener fecha de inicio del query string
        const endDate = req.query.endDate; // Obtener fecha de fin del query string
        const allgeneralvetados = await getAllGeneralVetados(startDate,endDate);
        res.json(allgeneralvetados);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Funciones para ReportQueries
app.get('/allingresos', async (req, res) => {
    try {
        const startDate = req.query.startDate; // Obtener fecha de inicio del query string
        const endDate = req.query.endDate; // Obtener fecha de fin del query string
        const allingresos = await getAllIngresos(startDate,endDate);
        res.json(allingresos);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

//Funciones para UserListAdmin
app.get('/allclients', async (req, res) => {
    try {
        const clients = await getAllClients();
        res.json(clients);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.post('/someclients', async (req, res) => {
    try {
        const select_Filters = req.body.filters;
        const select_View = req.body.views
        const debtRange = req.body.debts
        const dateRange = req.body.dates
        console.log('select_Filters:', select_Filters);
        console.log('view: ', select_View)
        console.log('debt: ', debtRange)
        console.log('date: ', dateRange)
        const clients = await getClientsByFilter(select_Filters, select_View, debtRange, dateRange);
        console.log('clientes:', clients)
        res.json(clients);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
    }
});

//Funciones para UserInfo
app.get('/clienteInfo/:id_cliente', async(req, res) => {
    try {
        const areas = await getclienteInfoD(req.params.id_cliente);
        res.json(areas);
    } catch (error) {
        console.error('Error fetching cliente INFORMACIÓN:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
})
app.get('/huespedInfo/:id_cliente', async(req, res) => {
    try {
        const areas = await getHuespedInfo(req.params.id_cliente);
        res.json(areas);
    } catch (error) {
        console.error('Error fetching cliente INFORMACIÓN:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
})
app.get('/deudaCliente/:id_cliente', async(req, res) => {
    try {
        const areas = await getDeudaCliente(req.params.id_cliente);
        res.json(areas);
    } catch (error) {
        console.error('Error fetching cliente DEUDA:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
})
app.get('/servicioEU/:id_cliente', async(req, res) => {
    try {
        const areas = await getServicioEU(req.params.id_cliente);
        res.json(areas);
    } catch (error) {
        console.error('Error fetching SERVICIO CLIENTE:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
})

app.post('/registrarPago', async(req, res) => {
    try {
        const pago = req.body.pago;
        const id_cliente = req.body.id_cliente;
        const registerNewPago = await getNewRegister(id_cliente, pago);
        res.json(registerNewPago);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
    }
})  

app.get('/tipoCliente/:id_cliente', async(req, res) => {
    try {
        const areas = await getTipoCliente(req.params.id_cliente);
        res.json(areas);
    } catch (error) {
        console.error('Error fetching TIPO CLIENTE:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
})

//USERINFO ----------- PAGINA INFORMACIÓN DE CLIENTE-----------------


//BEDS ----------- PAGINA CAMAS-----------------
app.get('/beds', async (req, res) => {
    try {
        const info = await getInfo();
        res.json(info);
    } catch (error) {
        console.error('Error fetching clients:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
})

app.post('/pagar', (req, res) => {
    const id_cliente = req.body.id_cliente;
    const notas_P = req.body.notas_p;
    const monto_T = req.body.monto_t;
    regPago(id_cliente, notas_P, monto_T)
        .then((data) => res.json(data))
        .catch((error) => console.log('ERROR: ', error));
})

app.post('/rooms_spacing_addbed', (req, res) => {
    const id = req.body.id_zona;
    anadCama(id)
        .then((data) => res.json(data))
        .catch((error) => console.log('ERROR: ', error));
})

app.post('/regSalida', (req, res) => {
    const id = req.body.id_cliente;
    regSalida(id)
        .then((data) => res.json(data))
        .catch((error) => console.log('ERROR: ', error));
})

app.post('/eliminarCama', (req, res) => {
    const id = req.body.id_cama;
    eliminarCama(id)
        .then((data) => res.json(data))
        .catch((error) => console.log('ERROR: ', error));
})

app.post('/regServacio', (req, res) => {
    const id = req.body.id_cliente;
    const id_s = req.body.id_servicio;
    const can = req.body.cant;
    regServacio(id, id_s, can)
        .then((data) => res.json(data))
        .catch((error) => console.log('ERROR: ', error));
})

//Para SignUp
app.post('/signup', async(req, res) => {
    const {username, password} = req.body;
    if (!username || !password){
        return res.status(400).send("Fields are required");
    }
    try{
        const nombre_u=req.body.username;
        const contrasena=req.body.password;
        await getNewAdmin(nombre_u, contrasena);
        res.status(200).json("User created successfully");
    } catch(error){
        console.error("Error creating user:", error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

//Para LogIn
app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) {
      return res.status(400).send("Fields are required");
    }
    try {
      const nombre_u = req.body.username;
      const contrasena = req.body.password;
  
      // TODO: Perform the login process and retrieve the necessary data
      const loginResult = await getNewLogin(nombre_u, contrasena);
      const { existingUser, accessToken, refreshToken } = loginResult;
  
      res.status(200).json({
        body: {
          user: existingUser,
          accessToken: accessToken,
          refreshToken: refreshToken
        }
      });
    } catch (error) {
      console.error("Error logging in:", error);
      res.status(500).json({ error: 'Internal server error' });
    }
});

app.post('/refresh-token', async (req, res) => {
    const refreshToken = getTokenFromHeader(req.headers);

    if (refreshToken){

        // try {
        //     const found = await Token.findOne({token: refreshToken});
        //     if (!found ){
        //         return res.status(401).send({error:"Unauthorized"});
        //     }
        try {
            const query = 'SELECT * FROM tokens WHERE token = $1';
            const values = [refreshToken];
            
            const { rows } = await pool.query(query, values);
            const found = rows[0];
            
            if (!found) {
              return res.status(401).send({ error: 'Unauthorized' });
            }
            const payload = verifyRefreshToken(found.token);
            if (payload){
                const accessToken=generateAccessToken(payload.user);
                return res.status(200).json({accessToken});
            } else{
                return res.status(401).send({error:"Unauthorized"});
            }

        } catch (error) {
            return res.status(401).send({error:"Unauthorized"});
        }

    }else {
        res.status(401).send({error: "Unauthorized"});
    }

    res.send("refresh-token");
});

// app.get('/hello', (req, res) => {
//     res.json({message:"Hola"});
// });

app.listen(port, () =>{
    console.log('Servidor corriendo en el puerto 8000')
});