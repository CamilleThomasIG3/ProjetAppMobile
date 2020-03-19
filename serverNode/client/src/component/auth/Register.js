import React, { Fragment, useState } from 'react'
import {Link, Redirect} from 'react-router-dom'
import {connect} from 'react-redux';
import {setAlert} from '../../actions/alert';
import {register} from '../../actions/auth';
import PropTypes from 'prop-types';



const Register = ({setAlert, register, isAuthenticated}) => {
    const [formdata, setFormData] = useState({
        pseudo: '',
        email: '',
        password: '',
        password2: ''
    });

    const {pseudo, email, password, password2} = formdata;

    const onChange = e => setFormData({...formdata, [e.target.name]: e.target.value});
    
    const onSubmit = async e => {
        e.preventDefault();
        if(password !== password2){
            setAlert('password does not match', 'danger')
        }
        else {
            register({pseudo, email, password});
        }
    };

    if(isAuthenticated){
        return <Redirect to='/dashboard'/>
    }

    return (
        <Fragment>
            <h1 className="large text-primary">Sign Up</h1>
            <p className="lead"><i className="fas fa-user"></i> Create Your Account</p>
            <form className="form" onSubmit={e => onSubmit(e)}>
                <div className="form-group">
                    <input type="text" placeholder="Pseudo" name="pseudo" value={pseudo} onChange={e => onChange(e)}  />
                </div>
                <div className="form-group">
                    <input type="email" placeholder="Email Address" name="email" value={email} 
                        onChange={e => onChange(e) } />
                    <small className="form-text">
                        This site uses Gravatar so if you want a profile image, use a
            Gravatar email
            
            </small>
                </div>
                <div className="form-group">
                    <input
                        type="password"
                        placeholder="Password"
                        name="password"
                        value={password}
                        onChange={e => onChange(e) }
                       // minLength="6"
                        //required
                        
                    />
                </div>
                <div className="form-group">
                    <input
                        type="password"
                        placeholder="Confirm Password"
                        name="password2"
                        value={password2}
                        onChange={e => onChange(e) }
                       // minLength="6"
                       // required
                    />
                </div>
                <input type="submit" className="btn btn-primary" value="Register" />
            </form>
            <p className="my-1">
                Already have an account? <Link to='/login'>Sign In</Link>
            </p>
        </Fragment>
    )
}

Register.propTypes = {
    setAlert: PropTypes.func.isRequired,
    register: PropTypes.func.isRequired,
    isAuthenticated: PropTypes.bool
}

const mapStateToProps = state => ({
    isAuthenticated: state.auth.isAuthenticated
})

export default connect(
    mapStateToProps,
    {setAlert, register}
    )(Register);