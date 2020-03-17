import React, { Component } from 'react';
import { Container, ListGroup, ListGroupItem, Button } from 'reactstrap';
import { CSSTransition, TransitionGroup } from 'react-transition-group';

import { connect } from 'react-redux';
import { getRemarks, deleteRemark } from '../actions/remarkActions';
import PropTypes from 'prop-types';


class RemarkList extends Component {

    componentDidMount() {
        this.props.getRemarks();
    }

    onDeleteClick = (id) => {
        this.props.deleteRemark(id);
    }

    render() {
        const { remarks } = this.props.remark;
        return (
            <Container>
                <ListGroup>
                    <TransitionGroup className="remark-list">
                        {remarks.map(({_id, name}) => (
                            <CSSTransition key={_id} timeout={500} classNames="fade">
                                <ListGroupItem align="left">
                                    <Button className="remove-btn" color="danger" size="sm"
                                        onClick={this.onDeleteClick.bind(this, _id)}
                                    >&times;</Button> <div>
                                    name : {name} <br/>
                                    </div>
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

export default connect(
    mapStateToProps,
    { getRemarks, deleteRemark })
    (RemarkList);
