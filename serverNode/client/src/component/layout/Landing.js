import React from 'react'
import {Link} from 'react-router-dom'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'
import AGAINST from '../../images/AGAINST.png'

const Landing = ({isAuthenticated}) => {
    return(
        <section className="landing">
      <div className="dark-overlay">
        <div className="landing-inner">
          <img src={AGAINST} alt="logo" id="logo_home"/>

          <h1 className="x-large">Welcome to <i>Against Sexism</i></h1>
          <p className="lead">
            We are together to fight sexism !
          </p>
          <div className={`buttons ${isAuthenticated ? "is-authenticated" : ""}`}>
            <Link to='/register' className="btn btn-primary">Sign Up</Link>
            <Link to='/login' className="btn btn-light">Login</Link>
          </div>
        </div>
      </div>
    </section>
    )
}

Landing.propTypes = {
  isAuthenticated: PropTypes.bool
};

const mapStateToProps = state => ({
  isAuthenticated: state.auth.isAuthenticated
});


export default connect(mapStateToProps)(Landing);