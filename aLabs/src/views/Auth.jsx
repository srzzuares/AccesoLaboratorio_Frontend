import React from 'react';
import {
  MDBBtn,
  MDBContainer,
  MDBRow,
  MDBCol,
  MDBInput
}
from 'mdb-react-ui-kit';

function App() {
  return (
    <MDBContainer className="my-5 gradient-form">

      <MDBRow>

        <MDBCol col='6' className="mb-5">
          <div className="d-flex flex-column ms-5">

            <div className="text-center">
              <img src="https://scontent.fmex19-1.fna.fbcdn.net/v/t1.6435-9/79332802_2310104462427616_47091627751112704_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=Uzc2YEYq8pcAX8mBR1B&_nc_ht=scontent.fmex19-1.fna&oh=00_AfDlz4C4g7CTg58BI8W-Lmg65J8qPLCQzyWySBaaU3YKVw&oe=6436F127"
                style={{width: '185px'}} alt="logo" />
              <h4 className="mt-1 mb-5 pb-1">Acceso al Laboratorio</h4>
            </div>


            <MDBInput wrapperClass='mb-4' label='Usuario' id='form1' type='email'/>
            <MDBInput wrapperClass='mb-4' label='Contraseña' id='form2' type='password'/>


            <div className="text-center pt-1 mb-5 pb-1">
              <MDBBtn className="mb-4 w-100 gradient-custom-2">Entrar</MDBBtn>
              <a className="text-muted" href="#!">¿Has olvidado tu contraseña?</a>
            </div>

            <div className="d-flex flex-row align-items-center justify-content-center pb-4 mb-4">
              <p className="mb-0">¿Quieres crear una nueva cuenta?</p>
              <MDBBtn outline className='mx-2' color='danger'>
                Registrar
              </MDBBtn>
            </div>

          </div>

        </MDBCol>

        <MDBCol col='6' className="mb-5">
          <div className="d-flex flex-column  justify-content-center gradient-custom-2 h-100 mb-4">

            <div className="text-white px-3 py-4 p-md-5 mx-md-4">
             
              <p class="small mb-0">Av. Universidad Tecnológica No . 1000, Tierra Negra, Xicotepec de Juárez, Puebla.
Teléfonos: 01 (764) 7645240 y 7645252
©2019 Dirección de Planeación y Evaluación.
Universidad Tecnológica de Xicotepec de Juárez.
              </p>
            </div>

          </div>

        </MDBCol>

      </MDBRow>

    </MDBContainer>
  );
}

export default App;