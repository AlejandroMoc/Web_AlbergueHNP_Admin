import './UserNewAdmin.scss';
import 'bootstrap/dist/css/bootstrap.min.css';
import React, { useEffect, useState } from 'react';
import { LuUser } from "react-icons/lu";
import { LuCalendarDays } from "react-icons/lu";
import { MdOutlineAttachMoney } from "react-icons/md";
import { FiHome } from "react-icons/fi";
import { TbMoodKid } from "react-icons/tb";
import { FaRegAddressCard } from "react-icons/fa";
import { RiHospitalLine } from "react-icons/ri";
import { IoMdAddCircleOutline } from "react-icons/io";
import { IoMdRemoveCircleOutline } from "react-icons/io";
//import { registerNewPatient } from '../../../../server/queries/UsernewQueries';


const UserNewAdmin = () => {



console.log("id_cama")
  const [bed, setBed] = useState([{id_cama: 0}])
  useEffect(() => {
    fetch('http://localhost:8000/alldispbeds')
    .then((res) => res.json())
    .then((beds) => setBed(beds));
  }, [])
  

  const [area, setArea] = useState([{id_area: 0, nombre_a: ''}]) //PARA DROPDOWN DE AREA PACIENTE
  useEffect(() => {
    fetch('http://localhost:8000/allareas')
    .then((res) => res.json())
    .then((areas) => setArea(areas));
  }, [])

  
  const [client, setClient] = useState([{sexo: null, nivel_se: 0, lugar_o: '', nombre_p: '', apellidos_p: '', carnet: '', id_area: 0, notas_c: '',id_cliente:0}])
  useEffect(() => {
    if (isVisitantePrevio === true) {
      fetch('http://localhost:8000/allclientinfo', {
        method: 'POST',
        body: JSON.stringify({nombre: nombre_c, apellidos: apellidos_c}),
        headers: {
          'Content-type': 'application/json; charset=UTF-8'
        }
      })
      .then((res) => res.json())
      .then((client) => setClient(client))
      .catch((error) => console.error('Error fetching data:', error));
      setIsVisitantePrevio(false);
    }
  })

  const [nombre_cError, setNombre_CError] = useState(false);
  const [apellidos_cError, setApellidos_CError] = useState(false);
  const [sexoError, setSexoError] = useState(false);
  const [nivel_seError, setNivel_SEError] = useState(false);
  const [lugar_oError, setLugar_OError] = useState(false);
  const [nombre_pError, setNombre_PError] = useState(false);
  const [apellidos_pError, setApellidos_PError] = useState(false);
  const [carnetError, setCarnetError] = useState(false);
  const [id_areaError, setId_areaCError] = useState(false);
  
  const validateFields = () => {
    setNombre_CError(nombre_c === '');
    setApellidos_CError(apellidos_c === '');
    setSexoError(sexo === null);
    setNivel_SEError(nivel_se === 0);
    setLugar_OError(lugar_o === '');
    setNombre_PError(nombre_p === '');
    setApellidos_PError(apellidos_p === '');
    setCarnetError(carnet === '');
    setId_areaCError(id_area === '');
    return !(
      nombre_c === '' ||
      apellidos_c === '' ||
      sexo === null ||
      nivel_se === 0 ||
      lugar_o === '' ||
      nombre_p === '' ||
      apellidos_p === '' ||
      carnet === '' ||
      id_area === ''
    );
  };
  const handleSelectChange = (event) => {
    const selectedId = event.target.value;
    setNumeroA(selectedId);
    console.log('ID del área seleccionada:', selectedId);
  };

  const [isVisitantePrevio, setIsVisitantePrevio] = useState(false);
  const handleIsVisitantePrevioChange = (event) => {
    // console.log(event.target.checked)
    setIsVisitantePrevio(event.target.checked)
  }

const [btRegistro, setBtRegistro] = useState(false);
const handleBtRegistroClick = async () => {
  if (validateFields()) {
    if (showServices) {
      try {
        await fetch('http://localhost:8000/registerEntradaUnica', {
          method: 'POST',
          body: JSON.stringify({ carnet: carnet, id_area: id_area, nombre_p: nombre_p, apellidos_p: apellidos_p, nombre_c: nombre_c, apellidos_c: apellidos_c, lugar_o: lugar_o, notas_c: notas_c, sexo: sexo, nivel_se: nivel_se, shower:shower, bathroom:bathroom, breakfast:breakfast, meal:meal, dinner:dinner}),
          headers: {
            'Content-type': 'application/json; charset=UTF-8'
          }
        });
        alert('Registro exitoso');
       } catch (error) {
        console.error('Error al registrar entrada unica:', error);
        alert('Error al registrar el paciente');
      }
    }
    else if(showBedNumber){
      try {
        await fetch('http://localhost:8000/registerNewPatient', {
          method: 'POST',
          body: JSON.stringify({ carnet: carnet, id_area: id_area, nombre_p: nombre_p, apellidos_p: apellidos_p, nombre_c: nombre_c, apellidos_c: apellidos_c, lugar_o: lugar_o, notas_c: notas_c, sexo: sexo, nivel_se: nivel_se, id_cama: id_cama }),
          headers: {
            'Content-type': 'application/json; charset=UTF-8'
          }
        });
        alert('Registro exitoso');
       } catch (error) {
        console.error('Error al registrar el paciente:', error);
        alert('Error al registrar el paciente');
      }
    }
  } else {
    alert('Por favor llene todos los campos obligatorios');
  }
};

  const [nombre_c, setNombre_C] = useState([]);
  const handleNombre_CChange = (event) => {
    const inputValue = event.target.value;
    const nombrecArray = inputValue.split(' ');
    console.log(nombrecArray);
    const nombrecString = nombrecArray.join(' ');
    console.log(nombrecString);
    setNombre_C(nombrecString);
  }


  const [apellidos_c, setApellidos_C] = useState([]);
  const handleApellidos_CChange = (event) => {
    const inputValue = event.target.value;
    const apellidoscArray = inputValue.split(' ');
    console.log(apellidoscArray);
    const apellidoscString = apellidoscArray.join(' ');
    console.log(apellidoscString);
    setApellidos_C(apellidoscString);
  }


  const [apellidos_p, setApellidos_P] = useState([]);
  const handleApellidos_PChange = (event) => {
    const inputValue = event.target.value;
    const apellidosArray = inputValue.split(' ');
    console.log(apellidosArray);
    const apellidosString = apellidosArray.join(' ');
    console.log(apellidosString);
    setApellidos_P(apellidosString);
  }
  
  const [nombre_p, setNombre_P] = useState([]);
  const handleNombre_PChange = (event) => {
    const inputValue = event.target.value;
    const nombrepArray = inputValue.split(' ');
    console.log(nombrepArray);
    const nombrepString = nombrepArray.join(' ');
    console.log(nombrepString);
    setNombre_P(nombrepString);
  }

  console.log(client)

  const [isPaciente, setIsPaciente] = useState(false)
  
  const [sexo, setSexo] = useState(null)
  const handleSexoChange = (event) => {
    console.log(event.target.value)
    setSexo(event.target.value)
  }

  const [nivel_se, setNivel_SE] = useState(0)
  const handleNivel_SEChange = (event) => {
    // console.log(event.target.value)
    setNivel_SE(event.target.value)
  }

  const [paciente, setPaciente] = useState(0)
  const handlePacienteChange = (event) => {
    // console.log(event.target.value)
    setPaciente(event.target.value)
  }

  const [id_cliente, setId_cliente] = useState(0)
  const handleId_clienteChange = (event) => {
    // console.log(event.target.value)
    setNivel_SE(event.target.value)
  }

  const [lugar_o, setLugar_O] = useState('')
  const handleLugar_OChange = (event) => {
    // console.log(event.target.value)
    setLugar_O(event.target.value)
  }


  const [carnet, setCarnet] = useState('')
  const handleCarnetChange = (event) => {
    // console.log(event.target.value)
    setCarnet(event.target.value)
  }

  const [notas_c, setNotas_C] = useState('')
  const handleNotas_CChange = (event) => {
    // console.log(event.target.value)
    setNotas_C(event.target.value)
  }

  const [showServices, setShowServices] = useState(false);
  const [showBedNumber, setShowBedNumber] = useState(true);
  const[tipo_cliente,setTipoCliente]=useState('');

  const handleRadioChange = (event) => {
    const isGuest = event.target.value === 'true';
    setShowServices(!isGuest);
    setShowBedNumber(isGuest); 
    setTipoCliente(event.target.value);
  };
  
  const [id_cama, setId_CamaC] = useState('')
  const handleId_CamaCChange = (event) => {
    // console.log(event.target.value)
    setId_CamaC(event.target.value)
  }

  const [id_area, setId_areaC] = useState('')
  const handleId_areaCChange = (event) => {
    // console.log(event.target.value)
    setId_areaC(event.target.value)
  }

  const [shower, setShower] = useState(0);
  const [bathroom, setBathroom] = useState(0);
  const [breakfast, setBreakfast] = useState(0);
  const [meal, setMeal] = useState(0);
  const [dinner, setDinner] = useState(0);

  const handleSetShower = (sh) => {
    if (sh === 1) {
      setShower(pShower => pShower + 1);
    }
    else if (sh === 0 && shower != 0) {
      setShower(pShower => pShower - 1);
    }
  }

  const handleSetBathroom = (ba) => {
    if (ba === 1) {
      setBathroom(pBathroom => pBathroom + 1);
    }
    else if (ba === 0 && bathroom != 0) {
      setBathroom(pBathroom => pBathroom - 1);
    }
  }

  const handleSetBreakfast = (br) => {
    if (br === 1) {
      setBreakfast(pBreakfast => pBreakfast + 1);
    }
    else if (br === 0 && breakfast != 0) {
      setBreakfast(pBreakfast => pBreakfast - 1);
    }
  }

  const handleSetMeal = (me) => {
    if (me === 1) {
      setMeal(pMeal => pMeal + 1);
    }
    else if (me === 0 && meal != 0) {
      setMeal(pMeal => pMeal - 1);
    }
  }

  const handleSetDinner = (di) => {
    if (di === 1) {
      setDinner(pDinner => pDinner + 1);
    }
    else if (di === 0 && dinner != 0) {
      setDinner(pDinner => pDinner - 1);
    }
  }
  

  return (
    <div class='App-minheight'>
      <div class="contenedorGral">
        <div class="container contenedorEspaciosReg">   
          <div class="input-group mb-3 checkerito">
            <div class="form-check form-switch" onChange={handleIsVisitantePrevioChange}>
              <input class="form-check-input checkboxHM" type="checkbox" role="switch" id="flexSwitchCheckDefault" checked={isVisitantePrevio}></input>
              <label class="form-check-label labelRadio" for="flexSwitchCheckDefault">Visitante Previo</label>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input checkboxHM" type="checkbox" role="switch" id="flexSwitchCheckDefault" onClick={handlePacienteChange} ></input>
              <label class="form-check-label labelRadio" for="flexSwitchCheckDefault">Paciente</label>
            </div>
          </div>     
            <div class="input-group mb-3 " onChange={handleNombre_CChange}>
              <span class="input-group-text spanEspIcon" id="basic-addon1"><LuUser /></span>
              <input type="text" class="form-control espReg" placeholder="Nombre Completo" aria-label="Username" aria-describedby="basic-addon1" value={nombre_c}></input>
            </div>
            <div class="input-group mb-3 "onChange={handleApellidos_CChange} >
              <span class="input-group-text spanEspIcon" id="basic-addon1"><LuUser /></span>
              <input type="text" class="form-control espReg" placeholder="Apellidos" aria-label="Username" aria-describedby="basic-addon1" value={apellidos_c}></input>
            </div>
           <div class="input-group mb-3 checkerito" onChange={handleSexoChange}>
              <div class="divRadio">
                <div class="form-check">
                  <input class="form-check-input checkboxHM" type="radio" name="sexo" id="flexRadioDefaultSexo" value={true}></input>
                  <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">Hombre</span>
                  </label>
                </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="sexo" id="flexRadioDefaultSexo" value={false}></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">Mujer</span>
                </label>
              </div>
            </div>
          </div>
          <span class="input-group-text spanEspL" id="basic-addon1">Nivel Socioeconómico</span>
          <div class="input-group mb-3 checkerito" onChange={handleNivel_SEChange}>
            <div class="divRadio">
              <div class="form-check">
                <input class="form-check-input checkboxHM"  type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc" value={1}></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">1</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc" value={2}></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">2</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc" value={3}></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">3</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc" value={4}></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">4</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc" value={5}></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">5</span>
                </label>
              </div>
            </div>
          </div>
          <div class="input-group mb-3 " onChange={handleLugar_OChange}>
            <span class="input-group-text spanEspIcon" id="basic-addon1"><FiHome /></span>
            <input type="text" class="form-control espReg" placeholder="Lugar de Origen" aria-label="Username" aria-describedby="basic-addon1" value={lugar_o}></input>
          </div>
          <div class="input-group mb-3 " onChange={handleNombre_PChange}>
            <span class="input-group-text spanEspIcon" id="basic-addon1"><TbMoodKid /></span>
            <input type="text" class="form-control espReg" placeholder="Nombre del Paciente" aria-label="Username" aria-describedby="basic-addon1" value={nombre_p}></input>
          </div>
          <div class="input-group mb-3 " onChange={handleApellidos_PChange} >
            <span class="input-group-text spanEspIcon" id="basic-addon1"><TbMoodKid /></span>
            <input type="text" class="form-control espReg" placeholder="Apellidos del paciente" aria-label="Username" aria-describedby="basic-addon1" value={apellidos_p}></input>
          </div>
          <div class="input-group mb-3 " onChange={handleCarnetChange}>
            <span class="input-group-text spanEspIcon" id="basic-addon1"><FaRegAddressCard /></span>
            <input type="text" class="form-control espReg" placeholder="Número de Carnet" aria-label="Username" aria-describedby="basic-addon1" value={carnet}></input>
          </div>
          <div class="labelX" onChange={handleId_areaCChange}>
            <span>Área de Paciente: </span>
            <select class="form-select selecti sm" aria-label="Default select example">
              <option selected>X</option> 
              {(
                area.map((item) => (
                  <option key={item.id_area} value={item.id_area}>{item.nombre_a}</option>
                ))
              )}
            </select>
          </div>
        </div>
        <div class="espNot">
          <div class="mb-3" onChange={handleNotas_CChange}>
            <textarea class="form-control  inputNotas" id="exampleFormControlTextarea1" rows="3" placeholder="Notas: " value={notas_c}></textarea>
          </div>
          <div class="input-group mb-3 checkerito">
            <div class="divRadio">
              <div class="form-check" onChange={handleRadioChange}>
                <input class="form-check-input checkboxHM" type="radio"  name="huesEU" id="flexRadioDefaultHuesEU"  value={true}></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">Huésped</span>
                </label>
              </div>
              <div class="form-check" onChange={handleRadioChange}>
                <input class="form-check-input checkboxHM" type="radio"  name="huesEU" id="flexRadioDefaultHuesEU"  value={false}></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">Entrada Única</span>
                </label>
              </div>
            </div>
          </div>
          {showBedNumber && (
          <div class="labelX" onChange={handleId_CamaCChange}>
            <span>Número de Cama: </span>
            <select class="form-select selecti sm" aria-label="Default select example">
              <option selected>X</option> {/*AQUÍ TENDRÍA QUE IR LA ID DE CAMA SELECCIONADA EN LA PANTALLA DE GESTION*/}
              {(
                bed.map((item) => (
                  <option value={item.id_cama}>{item.id_cama}</option>
                ))
              )}
            </select>
          </div>
          )}
          {showServices && (
          <div class="servoSocs">
            <div class="input-group mb-3">
              <span className='button-serv' class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetShower(1)}><IoMdAddCircleOutline /></span>
              <span className='button-serv' class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetShower(0)}><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Regadera</span>
              <span class="input-group-text spanNotText" id="basic-addon1">{shower}</span>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetBathroom(1)}><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetBathroom(0)}><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Baño</span>
              <span class="input-group-text spanNotText" id="basic-addon1">{bathroom}</span>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetBreakfast(1)}><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetBreakfast(0)}><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Desayuno</span>
              <span class="input-group-text spanNotText" id="basic-addon1">{breakfast}</span>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetMeal(1)}><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetMeal(0)}><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Comida</span>
              <span class="input-group-text spanNotText" id="basic-addon1">{meal}</span>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetDinner(1)}><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1" onClick={() => handleSetDinner(0)}><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Cena</span>
              <span class="input-group-text spanNotText" id="basic-addon1">{dinner}</span>
            </div>
          </div>
           )}
      <button type="button" className={`botonReg Appglobal-buttonaccept ${btRegistro ? 'activo' : ''}`} onClick={handleBtRegistroClick}>
        {btRegistro ? 'Desactivar' : 'Registrar'}
      </button>

        </div>
      </div>
    </div>
  );
}

export default UserNewAdmin;