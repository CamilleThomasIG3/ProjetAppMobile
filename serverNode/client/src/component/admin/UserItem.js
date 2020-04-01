import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { deleteUser, removeAdmin } from '../../actions/user'
import Moment from 'moment'
import { Card } from 'react-bootstrap'

const UserItem = ({
    deleteUser,
    removeAdmin,
    auth,
    showActions,
    user: { _id, email, pseudo, password, register_date, admin } }) =>

    <Card className="post-content">
        <Card.Header>Registered on <i>{Moment(register_date).format('MM-DD-YYYY')}</i> </Card.Header>
        <Card.Body>
            <Card.Title>{pseudo}</Card.Title>
            {admin && (
                <Card.Subtitle className="mb-2 text-muted">Admin</Card.Subtitle>
            )}
            <Card.Text>
                <p>{email}</p>
            </Card.Text>
    
            <div className="delete-button-user">   
                {auth.isAuthenticated && (
                    <button
                            onClick={e => deleteUser(_id)}
                            type="button"
                            className="btn btn-danger"
                        >
                            Delete user
                        </button>
                        )}
                {showActions && <Fragment>
                    {admin && (
                        <div>
                            <button onClick={e => removeAdmin(_id, false)}
                                    type="button"
                                    className="btn btn-danger"
                            >
                                Revoke admin
                            </button>  
                        </div>                 
                    )}
                </Fragment>}
            </div>

        </Card.Body>
    </Card>


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