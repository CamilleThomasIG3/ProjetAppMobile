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
// import { Button } from 'reactstrap';
// import { Link} from 'react-router-dom';




const RemarkForm = ({ addRemark, isAuthenticated, user }) => {
    const [formData, setFormData] = useState({
        modal: false,
        title: '',
        content: ''
    });
    const [idCategory, handleChangeIdCategory] = useState('')


    const { modal, title, content } = formData;

    const onChange = e => setFormData({ ...formData, [e.target.name]: e.target.value });

    const onSubmit = async e => {
        e.preventDefault();
        addRemark({ title, content, idCategory }, user);
        // e.clear();
        toggle()
    };

    const toggle = () => {
        setFormData({ modal: !modal })
    }


    if (!isAuthenticated) {
        return (
            <h4 className="page-infos">- you have to login to post remarks -</h4>
        )
    }

    return (
        <div>
            <Button color="primary" onClick={toggle}>Add sexist remark</Button>

            <Modal isOpen={modal} toggle={toggle}>
                <ModalHeader toggle={toggle}>Add a sexist remark</ModalHeader>

                <ModalBody>
                    <Form onSubmit={e => onSubmit(e)}>
                        <FormGroup>
                            <Label for="title">Title</Label>
                            <Input type="text" placeholder="Title" name="title" value={title} onChange={e => onChange(e)} required />

                            <Label for="idCategory">Category</Label>
                            <Input type="select" value={idCategory} onChange={e => handleChangeIdCategory(e.target.value)}>
                                <option value='Général'>Général</option>
                                <option value='Rue' >Rue</option>
                                <option value='Travail'>Travail</option>
                                <option value='Transports'>Transports</option>
                                <option value='Famille'>Famille</option>
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