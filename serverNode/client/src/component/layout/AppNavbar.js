import React, { Fragment, useState} from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import { logout } from '../../actions/auth'

import { FaHome, FaBars } from 'react-icons/fa'; //icones
// import {
//     Collapse, Navbar, NavbarToggler, NavbarBrand, Nav, NavItem, NavLink, Container
// } from 'reactstrap';

const AppNavbar = ({ auth: { isAuthenticated, loading }, logout, user }) => {
    const [formdata, setFormData] = useState({
        isExpanded: true
    });

    const {isExpanded} = formdata;    

    const logOut = () => {
        logout()
        handleToggle()
    }

    const handleToggle = () => {
        setFormData({isExpanded: !isExpanded})
    }

    const authLinks = (
        <div className="nav-right">
            <Link onClick={handleToggle} to='/remarks/myRemarks'>My remarks</Link>
            <Link onClick={handleToggle} to='/profile'>Profile</Link>
            
            <Link onClick={logOut} to='/'>Logout</Link>
            
        </div>
    );

    const guestLinks = (
        <div className="nav-right">
            <Link onClick={handleToggle} to='/register'>Register</Link>
            <Link onClick={handleToggle} to='/login'>Login</Link>
        </div>
    );

    const adminLinks = (
        <div className="nav-right">
            <Link onClick={handleToggle} to='/users'>Users</Link>
        </div>
    )

    return (
        <div>
            <nav className="navbar bg-dark nav-long">
                <div className="nav-left">
                    <Link to='/'><FaHome size={30}/></Link>
                    <Link to='/remarks'>Remarks</Link>
                </div>
                
                { !loading && (<Fragment>{isAuthenticated ? authLinks : guestLinks}</Fragment>) }
                { !loading && (<Fragment>{isAuthenticated && user.admin && (
                    adminLinks
                )}</Fragment>) }
            </nav>
            
            <nav className="navbar bg-dark nav-burger">
                <div className="nav-left">
                    <Link to='/'><FaHome size={30}/></Link>
                </div>
                    
                <Link onClick={handleToggle} to='/remarks'>Remarks</Link>

                <i onClick={handleToggle}> <FaBars size={30}/></i>

                <ul className={`nav-items ${isExpanded ? "is-expanded" : ""}`}>
                    { !loading && (<Fragment>{isAuthenticated ? authLinks : guestLinks}</Fragment>) }
                </ul>
            </nav>
        </div>
    )
}


AppNavbar.propTypes = {
    logout: PropTypes.func.isRequired,
    auth: PropTypes.object.isRequired

};

const mapStateToProps = state => ({
    auth: state.auth,
    user: state.auth.user
});


export default connect(mapStateToProps, { logout })(AppNavbar);