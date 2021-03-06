import React, { Fragment, useState } from 'react'
import {Link, Redirect} from 'react-router-dom'
import {connect} from 'react-redux';
import PropTypes from 'prop-types';
import {login} from '../../actions/auth';

const Login = ({login, isAuthenticated}) => {
    const [formdata, setFormData] = useState({
        email: '',
        password: ''
    });

    const {email, password} = formdata;

    const onChange = e => setFormData({...formdata, [e.target.name]: e.target.value});
    
    const onSubmit = async e => {
        e.preventDefault();
        login(email, password);
    }

    //redirect if logged in
    if(isAuthenticated){
        return <Redirect to="/remarks"/>
    }

    return (
        <Fragment>
            <div className="dark-overlay page-content">
                <h1 className="large text-primary">Login</h1>
                
                <p className="my-1">
                    You don't have an account ? <Link to='/register'>Register</Link>
                </p>
                <form className="form form-centered" onSubmit={e => onSubmit(e)}>
                    <div className="form-group">
                        <input type="email" placeholder="Email Address" name="email" value={email} 
                            onChange={e => onChange(e) } required />
                    </div>
                    <div className="form-group">
                        <input
                            type="password"
                            placeholder="Password"
                            name="password"
                            value={password}
                            onChange={e => onChange(e) }
                            required
                            
                        />
                    </div>

                    <input type="submit" className="btn btn-primary" value="Login" />
                </form>
            </div>
        </Fragment>
    )
}

Login.propTypes = {
    login: PropTypes.func.isRequired,
    isAuthenticated: PropTypes.bool
}

const mapStateToProps = state => ({
    isAuthenticated: state.auth.isAuthenticated
})

export default connect(mapStateToProps, {login})(Login);