import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { deleteUser, removeAdmin } from '../../actions/user'

const UserItem = ({
    deleteUser,
    removeAdmin,
    auth,
    showActions,
    user: { _id, email, pseudo, password, register_date, admin } }) =>
    <div className="post bg-white p-1 my-1">
        <div>
            <h2>{pseudo}</h2>
        </div>
        <div>
            <h3>Email :
                    <p>{email}</p>
            </h3>
            <h3>Register date :
                <p className="my-1">
                    {register_date}
                </p>
            </h3>
            {showActions && <Fragment>
                {admin && (
                    <div>
                        <p>Is admin</p>
                        <button onClick={e => removeAdmin(_id, false)}
                                type="button"
                                className="btn btn-danger"
                        >
                            Delete Admin
                        </button>  
                    </div>                 
                )}
                {auth.isAuthenticated && (
                  <button
                        onClick={e => deleteUser(_id)}
                        type="button"
                        className="btn btn-danger"
                    >
                        delete
                    </button>
                    )}
            </Fragment>}
        </div>
    </div>


UserItem.defaultProps = {
    showActions: true
}

UserItem.propTypes = {
    user: PropTypes.object.isRequired,
    auth: PropTypes.object.isRequired,
    deleteUser: PropTypes.func.isRequired
}


const mapStateToProps = state => ({
    auth: state.auth
})

export default connect(mapStateToProps, {deleteUser, removeAdmin })(UserItem);