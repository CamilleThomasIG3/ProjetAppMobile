import React from 'react';
import {Route, Redirect} from 'react-router-dom';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

const PrivateRouteAdmin = ({ component: Component, user, loading, ...rest}) => (
    <Route {...rest} render={props => user===null || (!user.admin && !loading) 
        ? (<Redirect to = '/login'/>) 
        : (<Component {...props}/>)
    }/>
)

PrivateRouteAdmin.propTypes = {
    user: PropTypes.object.isRequired,
    loading: PropTypes.bool.isRequired,
}

const mapStateToProps = state => ({
    loading: state.auth.loading,
    user: state.auth.user
})


export default connect(mapStateToProps)(PrivateRouteAdmin);