import React, { useState } from 'react';
import PropTypes from 'prop-types'
import { connect } from 'react-redux';
import { addRemark } from '../../actions/remark'
import {
    Button,
    Modal,
    ModalHeader,
    ModalBody,
    Form,
    FormGroup,
    Label,
    Input,
} from 'reactstrap'




const RemarkForm = ({ addRemark, isAuthenticated, user }) => {
    const [formData, setFormData] = useState({
        modal: false,
        title: '',
        content: ''
    });
    const [idCategory, handleChangeIdCategory] = useState('Général')


    const { modal, title, content } = formData;

    const onChange = e => setFormData({ ...formData, [e.target.name]: e.target.value });

    const onSubmit = async e => {
        e.preventDefault();
        addRemark({ title, content, idCategory }, user);
        toggle()
    };

    const toggle = () => {
        setFormData({ modal: !modal })
    }

    return (
        <div>
            <Button className="add-remark" color="primary" onClick={toggle}>Add sexist remark</Button>

            <Modal isOpen={modal} toggle={toggle}>
                <ModalHeader toggle={toggle}>Add a sexist remark</ModalHeader>

                <ModalBody>
                    <Form onSubmit={e => onSubmit(e)}>
                        <FormGroup>
                            <Label for="title">Title</Label>
                            <Input type="text" placeholder="Title" name="title" value={title} onChange={e => onChange(e)} required />

                            <Label for="idCategory">Category</Label>
                            <Input type="select" value={idCategory} onChange={e => handleChangeIdCategory(e.target.value)}>
                                <option value='Général'>General</option>
                                <option value='Rue' >Street</option>
                                <option value='Travail'>Work</option>
                                <option value='Transports'>Transports</option>
                                <option value='Famille'>Family</option>
                            </Input>
                            <Input type="textarea" className="textarea" rows="5" placeholder="Write your sexist remark" name="content" value={content}
                                onChange={e => onChange(e)}></Input>

                            <Button style={{ marginTop: '2rem' }} color="dark">Add remark</Button>
                        </FormGroup>
                    </Form>
                </ModalBody>
            </Modal>
        </div>
    )
}

RemarkForm.propTypes = {
    addRemark: PropTypes.func.isRequired,
    isAuthenticated: PropTypes.bool.isRequired,
}

const mapStateToProps = state => ({
    isAuthenticated: state.auth.isAuthenticated,
    user: state.auth.user
})

export default connect(
    mapStateToProps,
    { addRemark }
)(RemarkForm);