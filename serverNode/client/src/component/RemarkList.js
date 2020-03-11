import React, {Component} from 'react';
import {Container, ListGroup, ListGroupItem, Button} from 'reactstrap';
import {CSSTransition, TransitionGroup} from 'react-transition-group';

import {connect} from 'react-redux';
import { getRemarks } from '../actions/remarkActions';
import PropTypes from 'prop-types';


class RemarkList extends Component {
    
    componentDidMount(){
        this.props.getRemarks();
    }

    render() {
        const {remarks} = this.props.remark;
        return (
            <Container>
                <Button color="dark" style={{marginBottom:'2rem'}} onClick={()=> {
                    const name = prompt('add Remark');
                    if(name){
                        this.setState(state => ({
                            remarks: [...state.remarks, {id: 5, name: name}]
                        }));
                    }
                }}>Add remark</Button>
                <ListGroup>
                    <TransitionGroup className="remark-list">
                        {remarks.map(({id, name})=> (
                            <CSSTransition key={id} timeout={500} classNames="fade">
                                <ListGroupItem align="left">
                                    <Button className="remove-btn" color="danger" size="sm" 
                                    onClick={()=> {
                                    this.setState(state =>({
                                        remarks: state.remarks.filter(remark => remark.id !== id)
                                    } ));
                                }}
                                >&times;</Button>
                                    {name}
                                </ListGroupItem>

                            </CSSTransition>
                        ))}
                    </TransitionGroup>
                </ListGroup>
            </Container>
        )
    }

}

RemarkList.propTypes = {
    getRemarks: PropTypes.func.isRequired,
    remark: PropTypes.object.isRequired
}

const mapStateToProps = (state) => ({
    remark: state.remark
});

export default connect(mapStateToProps, {getRemarks})(RemarkList);
