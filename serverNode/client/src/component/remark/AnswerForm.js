import React, { useState } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
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
import { addAnswer } from '../../actions/remark'

const AnswerForm = ({ remarkId, addAnswer, isAuthenticated, user }) => {

    const [formData, setFormData] = useState({
        modal: false,
        content: ''
    });

    const [categoryResponse, handleChangeCategoryResponse] = useState('Général')
    const { modal, content }= formData;

    const onChange = e => setFormData({ ...formData, [e.target.name]: e.target.value });


    const onSubmit = async e => {
        e.preventDefault();
        addAnswer(remarkId, {content, categoryResponse}, user);
        toggle()
    }

    const toggle = () => {
        setFormData({ modal: !modal })
    }

    return (
        <div>
            <Button color="primary" onClick={toggle}>Add comment</Button>

            <Modal isOpen={modal} toggle={toggle}>
                <ModalHeader toggle={toggle}>Add comment</ModalHeader>

                <ModalBody>
                    <Form onSubmit={e => onSubmit(e)}>
                        <FormGroup>
                            <Label for="categoryResponse">Category</Label>
                            <Input type="select" value={categoryResponse} onChange={e => handleChangeCategoryResponse(e.target.value)}>
                                <option value='Général'>General</option>
                                <option value='Humour' >Humour</option>
                                <option value='Loi' >Law</option>
                                <option value='Citation' >Citation</option>
                            </Input>
                            <Input type="textarea" className="textarea" rows="5" placeholder="Write your answer" name="content" value={content}
                                onChange={e => onChange(e)}></Input>

                            <Button style={{ marginTop: '2rem' }} color="dark">Add comment</Button>
                        </FormGroup>
                    </Form>
                </ModalBody>
            </Modal>
        </div>
    )
}

AnswerForm.propTypes = {
    addAnswer: PropTypes.func.isRequired,
    isAuthenticated: PropTypes.bool.isRequired

}

const mapStateToProps = state => ({
    isAuthenticated: state.auth.isAuthenticated,
    user: state.auth.user

})

export default connect(mapStateToProps, { addAnswer })(AnswerForm)