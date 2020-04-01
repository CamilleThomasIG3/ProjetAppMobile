import React, { Fragment, useState } from 'react'
import { connect } from 'react-redux';
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
import {setAlert} from '../../actions/alert'
import { editPseudo, editPassword } from '../../actions/auth';


const Profile = ({ isAuthenticated, editPseudo, editPassword, user }) => {

    const [formdata, setFormData] = useState({
        modal: false,
        modal2: false,
        newPseudo: '',
        password: '',
        newPassword: '',
        newPassword2: ''
    });

    const { modal, modal2, newPseudo, password, newPassword, newPassword2 } = formdata;

    if (!isAuthenticated) {
        return (
            <h2>you have to login to see profile</h2>
        )
    } else {
        const onChange = e => setFormData({ ...formdata, [e.target.name]: e.target.value });

        const onSubmit = async e => {
            e.preventDefault();
            editPseudo(user._id, newPseudo, password);

            //close modal
            toggle()
        }
        const onSubmit2 = async e => {
            e.preventDefault();
            if (newPassword !== newPassword2) {
                setAlert('password does not match', 'danger')
            }
            else {
                editPassword(user._id, newPassword, password);
            }


            //close modal
            toggle2()
        }

        const toggle = () => {
            setFormData({ modal: !modal })
        }
        const toggle2 = () => {
            setFormData({ modal2: !modal2 })
        }

        return (
            <Fragment>
                <div className="dark-overlay page-content">
                    <h1 className="large text-primary">Profile</h1>

                    <img src={PROFILE} alt="icon_profile" id="icon-profile" />

                    <div className="profile-data">
                        <h3><b>Pseudo</b></h3>
                        <h4>{user.pseudo}</h4>
                        <h3><b>Email</b></h3>
                        <h4>{user.email}</h4>
                    </div>

                    <Button color="ligth" onClick={toggle}>Edit pseudo</Button>
                    <Button color="ligth" onClick={toggle2}>Edit password</Button>

                    <Modal isOpen={modal} toggle={toggle}>
                        <ModalHeader toggle={toggle}>Edit pseudo</ModalHeader>

                        <ModalBody>
                            <Form onSubmit={e => onSubmit(e)}>
                                <FormGroup>
                                    <Label for="pseudo">Pseudo</Label>
                                    <Input type="text" name="newPseudo" id="pseudo" placeholder="new pseudo" value={newPseudo}
                                        onChange={e => onChange(e)} required />

                                    <Label for="password" style={{ marginTop: '1rem' }}>Password</Label>
                                    <Input type="password" name="password" id="password" placeholder="password"
                                        onChange={e => onChange(e)} required />

                                    <Button style={{ marginTop: '2rem' }} color="dark">Edit</Button>
                                </FormGroup>
                            </Form>
                        </ModalBody>
                    </Modal>
                    <Modal isOpen={modal2} toggle={toggle2}>
                        <ModalHeader toggle={toggle2}>Change your password</ModalHeader>

                        <ModalBody>
                            <Form onSubmit={e => onSubmit2(e)}>
                                <FormGroup>

                                    <Label for="password" style={{ marginTop: '1rem' }}>Password</Label>
                                    <Input type="password" name="password" id="password" placeholder="password"
                                        onChange={e => onChange(e)} required />

                                    <Label for="newPassword">new password</Label>
                                    <Input type="password" name="newPassword" id="newPassword" placeholder="new password" value={newPassword}
                                        onChange={e => onChange(e)} required />

                                    <Label for="newPassword2">Confirm new password</Label>
                                    <Input type="password" name="newPassword2" id="newPassword2" placeholder="confirm new password" value={newPassword2}
                                        onChange={e => onChange(e)} required />

                                    <Button style={{ marginTop: '2rem' }} color="dark">Edit</Button>
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
    editPseudo: PropTypes.func.isRequired,
    editPassword: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    isAuthenticated: state.auth.isAuthenticated,
    user: state.auth.user
})

export default connect(mapStateToProps, { setAlert, editPseudo, editPassword })(Profile);