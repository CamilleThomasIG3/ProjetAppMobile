import React, { Fragment, Component, useEffect } from 'react';
import { Container, ListGroup, ListGroupItem, Button } from 'reactstrap';
import { CSSTransition, TransitionGroup } from 'react-transition-group';

import { connect } from 'react-redux';
import { getRemarks, deleteRemark } from '../../actions/remark';
import Spinner from '../layout/Spinner';
import PropTypes from 'prop-types';
import RemarkItem from './RemarkItem';
import RemarkForm from './RemarkForm';


const Remarks = ({ getRemarks, deleteRemark, remark: { remarks, loading } }) => {
    useEffect(() => {
        getRemarks();
    }, [getRemarks]);


    return loading ? <Spinner /> : (
        <div>
            <Fragment>
                <h1 className="large text-primary">Remarks</h1>
                <p className="lead"> Welcome girls and boys</p>
                <RemarkForm/>
                <div className="remarks">
                    {console.log(remarks)}
                    {remarks.map(remark => (
                        <RemarkItem key={remark._id} remark={remark} />))}
                </div>
            </Fragment>
        </div>
    )

}

Remarks.propTypes = {
    getRemarks: PropTypes.func.isRequired,
    remark: PropTypes.object.isRequired
}

const mapStateToProps = (state) => ({
    remark: state.remark
});

export default connect(
    mapStateToProps,
    { getRemarks, deleteRemark })
    (Remarks);
