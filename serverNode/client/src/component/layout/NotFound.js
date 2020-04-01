import React from 'react'
import {Link} from 'react-router-dom'
import { connect } from 'react-redux'

const NotFound = () => {
    return(
      <section className="landing">
        <div className="dark-overlay">
          <div className="landing-inner">
            {/* <img src={AGAINST} alt="logo" id="logo_home"/> */}

            <h1 className="x-large">This page doesn't exist !</h1>
            <h2 className="x-large">Sorry</h2>
            
            <div className='buttons'>
              <Link to='/' className="btn btn-primary">Home page</Link>
            </div>
          </div>
        </div>
      </section>
    )
}


export default connect()(NotFound);