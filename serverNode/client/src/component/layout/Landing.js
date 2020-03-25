import React from 'react'
import {Link} from 'react-router-dom'
import AGAINST from '../../images/AGAINST.png'

const Landing = () => {
    return(
        <section className="landing">
      <div className="dark-overlay">
        <div className="landing-inner">
          <img src={AGAINST} alt="logo" id="logo_home"/>

          <h1 className="x-large">Welcome to <i>Against Sexism</i></h1>
          <p className="lead">
            We are together to fight sexism !
          </p>
          <div className="buttons">
            <Link to='/register' className="btn btn-primary">Sign Up</Link>
            <Link to='/login' className="btn btn-light">Login</Link>
          </div>
        </div>
      </div>
    </section>
    )
}

export default Landing;