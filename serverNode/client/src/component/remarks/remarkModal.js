import React, { Component } from 'react';
import {
    Button, Modal, ModalHeader, ModalBody, Form, FormGroup, Label, Input
} from 'reactstrap';
import {connect} from 'react-redux';
import {addRemark} from '../../actions/remark';

class RemarkModal extends Component{
    state = {
        modal: false,
        name: ''


    }

    toggle = () => {
        this.setState({
            modal: !this.state.modal
        });
    }

    
    onChange = (e) => {
        this.setState({[e.target.name]: e.target.value});
    }
    

    onSubmit = e => {
        e.preventDefault();
        const newRemark = {
            name: this.state.name
        }

        this.props.addRemark(newRemark);
        this.toggle();
    };

    render(){
        return(
            <div>
                <Button 
                color="dark"
                style={{marginBottom: '2rem'}}
                onClick= {this.toggle}>
                    Add remark
                </Button>
                <Modal
                isOpen={this.state.modal}
                toggle={this.toggle}
                >
                    <ModalHeader toggle={this.toggle}>
                        Add To Remark list
                    </ModalHeader>
                    <ModalBody>
                        <Form onSubmit={this.onSubmit}>
                            <FormGroup>
                                <Label for='remark'>
                                    remark
                                </Label>
                                <Input
                                type='text'
                                name='name'
                                id='remark'
                                placeholder='add content'
                                onChange={this.onChange}
                                />
                                {/* <Input
                                type='text'
                                name='idCategory'
                                id='remark'
                                placeholder='add cat'
                                onChange={this.onChangeCategory}
                                /> */}
                                <Button color="dark" style={{marginTop: '2rem'}} block>Add remark</Button>
                            </FormGroup>
                        </Form>
                    </ModalBody>


                </Modal>
            </div>
        )
    }
}

const mapStateToProps = state => ({
    remark: state.remark
})

export default connect(mapStateToProps, {addRemark})(RemarkModal);

