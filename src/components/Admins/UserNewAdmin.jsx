import React from 'react';
import './UserNewAdmin.scss';
import 'bootstrap/dist/css/bootstrap.min.css';

import { LuUser } from "react-icons/lu";
import { LuCalendarDays } from "react-icons/lu";
import { MdOutlineAttachMoney } from "react-icons/md";
import { FiHome } from "react-icons/fi";
import { TbMoodKid } from "react-icons/tb";
import { FaRegAddressCard } from "react-icons/fa";
import { RiHospitalLine } from "react-icons/ri";
import { IoMdAddCircleOutline } from "react-icons/io";
import { IoMdRemoveCircleOutline } from "react-icons/io";

const UserNewAdmin = () => {

  const handleRadioChange = (event) => {
    if (event.target.value === "opcion3") {
      setShowNumbersSelect(true);
    } else {
      setShowNumbersSelect(false);
    }
  };

  return (
    <div class='App-minheight'>
      <div class="contenedorGral">
        <div class="container contenedorEspaciosReg">   
          <div class="input-group mb-3 checkerito">
            <div class="form-check form-switch">
              <input class="form-check-input checkboxHM" type="checkbox" role="switch" id="flexSwitchCheckDefault"></input>
              <label class="form-check-label labelRadio" for="flexSwitchCheckDefault">Visitante Previo</label>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input checkboxHM" type="checkbox" role="switch" id="flexSwitchCheckDefault"></input>
              <label class="form-check-label labelRadio" for="flexSwitchCheckDefault">Paciente</label>
            </div>
          </div>     
          <div class="input-group mb-3 ">
            <span class="input-group-text spanEspIcon" id="basic-addon1"><LuUser /></span>
            <input type="text" class="form-control espReg" placeholder="Nombre Completo" aria-label="Username" aria-describedby="basic-addon1"></input>
          </div>
          <div class="input-group mb-3 checkerito">
            <div class="divRadio">
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="sexo" id="flexRadioDefaultSexo"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">Hombre</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="sexo" id="flexRadioDefaultSexo"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">Mujer</span>
                </label>
              </div>
            </div>
          </div>
          <div class="input-group mb-3 ">
            <span class="input-group-text spanEspIcon" id="basic-addon1"><LuCalendarDays /></span>
            <input type="text" class="form-control espReg" placeholder="Fecha de Nacimiento (dd/mm/aaaa)" aria-label="Username" aria-describedby="basic-addon1"></input>
          </div>
          <span class="input-group-text spanEspL" id="basic-addon1">Nivel Socioeconómico</span>
          <div class="input-group mb-3 checkerito">
            <div class="divRadio">
              <div class="form-check">
                <input class="form-check-input checkboxHM"  type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">1</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">2</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">3</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">4</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" name="nivelSoc" id="flexRadioDefaultNivelSoc"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">5</span>
                </label>
              </div>
            </div>
          </div>
          <div class="input-group mb-3 ">
            <span class="input-group-text spanEspIcon" id="basic-addon1"><FiHome /></span>
            <input type="text" class="form-control espReg" placeholder="Lugar de Origen" aria-label="Username" aria-describedby="basic-addon1"></input>
          </div>
          <div class="input-group mb-3 ">
            <span class="input-group-text spanEspIcon" id="basic-addon1"><TbMoodKid /></span>
            <input type="text" class="form-control espReg" placeholder="Nombre del Paciente" aria-label="Username" aria-describedby="basic-addon1"></input>
          </div>
          <div class="input-group mb-3 ">
            <span class="input-group-text spanEspIcon" id="basic-addon1"><FaRegAddressCard /></span>
            <input type="text" class="form-control espReg" placeholder="Número de Carnet" aria-label="Username" aria-describedby="basic-addon1"></input>
          </div>
          <div class="input-group mb-3 ">
            <span class="input-group-text spanEspIcon" id="basic-addon1"><RiHospitalLine /></span>
            <input type="text" class="form-control espReg" placeholder="Área del Paciente" aria-label="Username" aria-describedby="basic-addon1"></input>
          </div>
        </div>
        <div class="espNot">
          <div class="mb-3">
            <textarea class="form-control  inputNotas" id="exampleFormControlTextarea1" rows="3" placeholder="Notas: "></textarea>
          </div>
          <div class="input-group mb-3 checkerito">
            <div class="divRadio">
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" value="op1" name="huesEU" id="flexRadioDefaultHuesEU"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                <span class="textoHM">Huésped</span>
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input checkboxHM" type="radio" value="op2" name="huesEU" id="flexRadioDefaultHuesEU"></input>
                <label class="form-check-label labelRadio" for="flexRadioDefault1">
                  <span class="textoHM">Entrada Única</span>
                </label>
              </div>
            </div>
          </div>
          <div class="labelX">
            <span>Número de Cama</span>
            <select class="form-select selecti sm" aria-label="Default select example">
              <option selected>X</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">6</option>
              <option value="2">21</option>
              <option value="3">37</option>
            </select>
          </div>
          <div class="servoSocs">
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Regadera</span>
              <span class="input-group-text spanNotText" id="basic-addon1">0</span>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Baño</span>
              <span class="input-group-text spanNotText" id="basic-addon1">0</span>
            </div>
          </div>
          <div>
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Desayuno</span>
              <span class="input-group-text spanNotText" id="basic-addon1">0</span>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Comida</span>
              <span class="input-group-text spanNotText" id="basic-addon1">0</span>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdAddCircleOutline /></span>
              <span class="input-group-text spanNotIcon" id="basic-addon1"><IoMdRemoveCircleOutline /></span>
              <span class="input-group-text spanNotText" id="basic-addon1">Cena</span>
              <span class="input-group-text spanNotText" id="basic-addon1">0</span>
            </div>
          </div>
          <button type="button" class="btn btn-primary botonReg">Registrar</button>
        </div>
      </div>
    </div>
  )
}

export default UserNewAdmin