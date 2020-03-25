import React, { Fragment } from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import { logout } from '../../actions/auth'

import { FaHome } from 'react-icons/fa'; //icones
// import {
//     Collapse, Navbar, NavbarToggler, NavbarBrand, Nav, NavItem, NavLink, Container
// } from 'reactstrap';

const AppNavbar = ({ auth: { isAuthenticated, loading }, logout }) => {
    const authLinks = (
        <div className="nav-left">
            <a onClick={logout} href='/'>
                <span className="hide-sm">logout</span>
            </a>
            
            <Link to='/profile'>Profile</Link>
            <Link to='/remarks/myRemarks'>My remarks</Link>
        </div>
    );

    const guestLinks = (
        <div className="nav-left">
            <Link to='/register'>Register</Link>
            <Link to='/login'>Login</Link>
        </div>
    );

    return (
        <nav className="navbar bg-dark">
            <div className="nav-right">
                <Link to='/'><FaHome size={30}/></Link>
                <Link to='/remarks'>Remarks</Link>
            </div>
            
            {
                !loading && (<Fragment>{isAuthenticated ? authLinks : guestLinks}

                </Fragment>)
            }


        </nav >
    )
}


AppNavbar.propTypes = {
    logout: PropTypes.func.isRequired,
    auth: PropTypes.object.isRequired

};

const mapStateToProps = state => ({
    auth: state.auth
});


export default connect(mapStateToProps, { logout })(AppNavbar);