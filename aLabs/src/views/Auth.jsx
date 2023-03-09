import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';

export const Auth = () => {
    return (
        <Form className='login'>
            <h4>Iniciar Sesión</h4>
            <Form.Group className='' controlId='formBasicEmail'>
                <Form.Label>Usuario</Form.Label>
                <Form.Control type='email' placeholder='Ingrese su cuenta'/>
            </Form.Group>
            <Form.Group className='' controlId='formBasicPassword'>
                <Form.Label>Contraseña</Form.Label>
                <Form.Control type='password' placeholder='Contraseña'/>
            </Form.Group>
            <Form.Group className='' controlId='formBasicCheckbox'>
                <Form.Check type='checkbox' label='Recordarme'/>
            </Form.Group>
            <Button variant='primary' type='submit'>
                Iniciar Sesión
            </Button>
        </Form>
    )
}
