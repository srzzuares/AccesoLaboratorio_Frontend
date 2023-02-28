import Form from 'react-bootstrap/Form';

export const Registrar = () => {
    return (
        <Form className='registro'>
            <h4>Crear Cuenta</h4>
            <Form.Group className='' controlId='formBasicNumber'>
                <Form.Label>Numero de control</Form.Label>
                <Form.Control type='number' placeholder='Numero de control'/>
            </Form.Group>
            <Form.Group>
                <Form.Label>Nombre</Form.Label>
                <Form.Control type='text' placeholder='Nombre/s'/>
            </Form.Group>
            <Form.Group>
                <Form.Label>Primer Apellido</Form.Label>
                <Form.Control type='text' placeholder='Primer Apellido'/>
            </Form.Group>
            <Form.Group>
                <Form.Label>Segundo Apellido</Form.Label>
                <Form.Control type='text' placeholder='Segundo Apellido'/>
            </Form.Group>
            <Form.Group>
                <Form.Label>Cargo</Form.Label>
                <Form.Select>
                    <option value={1}>Docente</option>
                    <option value={2}>Laboratorista</option>
                </Form.Select>
            </Form.Group>
        </Form>
    )
}