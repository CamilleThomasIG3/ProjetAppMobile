import React, { Fragment, useState } from 'react'
import {connect} from 'react-redux';
import {
    Button,
    Modal,
    ModalHeader,
    ModalBody,
    Form,
    FormGroup,
    Label,
    Input
} from 'reactstrap'
import PropTypes from 'prop-types';

import PROFILE from '../../images/profile.png'

import {editPseudo} from '../../actions/auth';


const Profile = ({isAuthenticated, editPseudo, user}) => {    
    
    const [formdata, setFormData] = useState({
        modal: false,
        newPseudo: user.pseudo,
        password: ''
    });

    const {modal, newPseudo, password} = formdata;

    if (!isAuthenticated) {
        return (
            <h2>you have to login to see profile</h2>
        )
    }else{
        const onChange = e => setFormData({...formdata, [e.target.name]: e.target.value});

        const onSubmit = async e => {
            e.preventDefault();
            editPseudo(user._id, newPseudo, password);

            //close modal
            toggle()
        }
    
        const toggle = () => {
            setFormData({modal: !modal})
        }

        return (
            <Fragment>
                <div className="dark-overlay page-content">
                    <h1 className="large text-primary">Profile</h1>
                    
                    <img src={PROFILE} alt="icon_profile" id="icon-profile"/>

                    <div className="profile-data">
                        <h3><b>Pseudo</b></h3>
                        <h4>{user.pseudo}</h4>
                        <h3><b>Email</b></h3>
                        <h4>{user.email}</h4>
                    </div>

                    <Button color="ligth" onClick={toggle}>Edit pseudo</Button>

                    <Modal isOpen={modal} toggle={toggle}>
                        <ModalHeader toggle={toggle}>Edit pseudo</ModalHeader>

                        <ModalBody>
                            <Form onSubmit={e => onSubmit(e)}>
                                <FormGroup>
                                    <Label for="pseudo">Pseudo</Label>                                
                                    <Input type="text" name="newPseudo" id="pseudo" placeholder="new pseudo" value={newPseudo}
                                        onChange={e => onChange(e)} required/>

                                    <Label for="password" style={{marginTop:'1rem'}}>Password</Label>
                                    <Input type="password" name="password" id="password" placeholder="password" 
                                        onChange={e => onChange(e)} required/>

                                    <Button style={{marginTop:'2rem'}} color="dark">Edit</Button>
                                </FormGroup>
                            </Form>
                        </ModalBody>
                    </Modal>
                </div>
            </Fragment>
        )
    }
}

Profile.propTypes = {
    isAuthenticated: PropTypes.bool.isRequired,
    editPseudo: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    isAuthenticated: state.auth.isAuthenticated,
    user: state.auth.user
})

export default connect(mapStateToProps, {editPseudo})(Profile);