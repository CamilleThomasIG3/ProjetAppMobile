import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
//import Moment from 'react-moment';
import { connect } from 'react-redux';
import { addRemarkLike, removeRemarkLike } from '../../actions/likes'
import { deleteRemark } from '../../actions/remark'
import { addRemarkSignal } from '../../actions/signal'
import { Card } from 'react-bootstrap'

import Moment from 'moment'
import { FaRegComment } from 'react-icons/fa'; //icones

const RemarkItem = ({
    deleteRemark,
    addRemarkLike,
    removeRemarkLike,
    addRemarkSignal,
    auth,
    showActions,
    remark: { _id, title, content, user, date, likes, answers, idCategory, signals } }) =>

    <div className="post">
        <Card className="post-content">
            <Card.Header>Posted by <i>{user}</i> on <i>{Moment(date).format('MM-DD-YYYY')}</i> </Card.Header>
            <Card.Body>
                <Card.Title>{title}</Card.Title>
                <Card.Subtitle className="mb-2 text-muted">{idCategory}</Card.Subtitle>
                <Card.Text>
                    <p>{content}</p>
                </Card.Text>

                <div className="post-buttons">
                    {showActions && <Fragment>

                    <Link to={`/remarks/${_id}`} className="btn btn-dark">
                        <FaRegComment/> Discussion {answers.length > 0 && (
                            <span className='comment-count'>{answers.length}</span>
                        )}
                    </Link>
                    {auth.isAuthenticated && (
                        !auth.loading && user === auth.user.pseudo && (<button
                            onClick={e => deleteRemark(_id)}
                            type="button"
                            className="btn btn-danger"
                        >
                            delete
                        </button>
                        ))}
                    {auth.isAuthenticated && auth.user.admin && (
                        <button
                            onClick={e => deleteRemark(_id)}
                            type="button"
                            className="btn btn-danger"
                        >
                            delete
                        </button>

                    )}
                </Fragment>}
                <button onClick={e => { if (auth.isAuthenticated) addRemarkLike(_id, auth.user.pseudo) }}
                    type="button" className="btn btn-primary">
                    <i className="fas fa-thumbs-up"></i>
                    <span>{likes.length} like</span>
                </button>
                <button onClick={e => { if (auth.isAuthenticated) removeRemarkLike(_id, auth.user.pseudo) }}
                    type="button" className="btn btn-light">
                    <i className="fas fa-thumbs-up"></i>
                    <span>unlike</span>
                </button>
                <button
                    onClick={e => addRemarkSignal( _id, auth.user.pseudo)}
                    type="button"
                    className="btn btn-signal">
                    <span>{signals.length} signal</span>

                </button>
            </div> 

            </Card.Body>
        </Card>
    </div>


RemarkItem.defaultProps = {
    showActions: true
}

RemarkItem.propTypes = {
    remark: PropTypes.object.isRequired,
    auth: PropTypes.object.isRequired,
    deleteRemark: PropTypes.func.isRequired
}


const mapStateToProps = state => ({
    auth: state.auth
})

export default connect(mapStateToProps, { addRemarkLike, removeRemarkLike, deleteRemark, addRemarkSignal })(RemarkItem);