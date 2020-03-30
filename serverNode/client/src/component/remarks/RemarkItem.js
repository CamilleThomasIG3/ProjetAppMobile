import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
//import Moment from 'react-moment';
import { connect } from 'react-redux';
import { addRemarkLike, removeRemarkLike } from '../../actions/likes'
import { deleteRemark } from '../../actions/remark'
import { addRemarkSignal, removeRemarkSignal } from '../../actions/signal'
import { Card } from 'react-bootstrap'

import Moment from 'moment'
import { FaRegComment, FaTrashAlt, FaThumbsUp, FaExclamationTriangle } from 'react-icons/fa'; //icones

const isAlreadyByUser = (pseudo, tab) => {
    var res = false
    tab.forEach(function(element) {
        if(element.user===pseudo){
            res = true
        }
    })
    return res
}

const RemarkItem = ({
    deleteRemark,
    addRemarkLike,
    removeRemarkLike,
    addRemarkSignal,
    removeRemarkSignal,
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

                {/* Full screen*/}
                <div className="hide-mobile post-buttons">
                    {showActions && <Fragment>

                    {/* DISCUSSION */}
                    <Link to={`/remarks/${_id}`} className="btn btn-dark">
                        <FaRegComment/> Discussion {answers.length > 0 && (
                            <span className='comment-count'>{answers.length}</span>
                        )}
                    </Link>

                    {/* DELETE */}
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

                {/* LIKE */}
                {auth.isAuthenticated && isAlreadyByUser(auth.user.pseudo, likes) && (
                    <button onClick={e => { if (auth.isAuthenticated) removeRemarkLike(_id, auth.user.pseudo) }}
                        type="button" className="btn btn-primary">
                        <span>{likes.length} likes</span>
                    </button>
                )}
                {auth.isAuthenticated && !isAlreadyByUser(auth.user.pseudo, likes) && (
                    <button onClick={e => { if (auth.isAuthenticated) addRemarkLike(_id, auth.user.pseudo) }}
                        type="button" className="btn btn-light like">
                        <span>{likes.length} <FaThumbsUp/></span>
                    </button>
                )}

                {/* SIGNAL */}
                {auth.isAuthenticated && !isAlreadyByUser(auth.user.pseudo, signals) && (
                    <button
                        onClick={e => addRemarkSignal( _id, auth.user.pseudo)}
                        type="button"
                        className="btn btn-light signal">
                        <span>{signals.length} <FaExclamationTriangle/></span>
                    </button>
                )}
                {auth.isAuthenticated && isAlreadyByUser(auth.user.pseudo, signals) && (
                    <button
                        onClick={e => removeRemarkSignal( _id, auth.user.pseudo)}
                        type="button"
                        className="btn btn-signal">
                        <span>{signals.length} reports</span>
                    </button>
                )}
            </div> 

            {/* Responsive screen*/}
            <div className="visible-mobile post-buttons">
                    {showActions && <Fragment>

                    <Link to={`/remarks/${_id}`} className="btn btn-dark">
                        <FaRegComment/>{answers.length > 0 && (
                            <span className='comment-count'>{answers.length}</span>
                        )}
                    </Link>
                    {auth.isAuthenticated && (
                        !auth.loading && user === auth.user.pseudo && (<button
                            onClick={e => deleteRemark(_id)}
                            type="button"
                            className="btn btn-danger"
                        >
                        <FaTrashAlt/>
                        </button>
                        ))}
                    {auth.isAuthenticated && auth.user.admin && (
                        <button
                            onClick={e => deleteRemark(_id)}
                            type="button"
                            className="btn btn-danger"
                        >
                        <FaTrashAlt/>
                        </button>

                    )}
                </Fragment>}

                {auth.isAuthenticated && isAlreadyByUser(auth.user.pseudo, likes) && (
                    <button onClick={e => { if (auth.isAuthenticated) removeRemarkLike(_id, auth.user.pseudo) }}
                        type="button" className="btn btn-primary">
                        <span>{likes.length}<FaThumbsUp/></span>
                    </button>
                )}
                {auth.isAuthenticated && !isAlreadyByUser(auth.user.pseudo, likes) && (
                    <button onClick={e => { if (auth.isAuthenticated) addRemarkLike(_id, auth.user.pseudo) }}
                        type="button" className="btn btn-light like">
                        <span>{likes.length}<FaThumbsUp/></span>
                    </button>
                )}
                {auth.isAuthenticated && !isAlreadyByUser(auth.user.pseudo, signals) && (
                    <button
                        onClick={e => addRemarkSignal( _id, auth.user.pseudo)}
                        type="button"
                        className="btn btn-light signal">
                        <span>{signals.length} <FaExclamationTriangle/></span>
                    </button>
                )}
                {auth.isAuthenticated && isAlreadyByUser(auth.user.pseudo, signals) && (
                    <button
                        onClick={e => removeRemarkSignal( _id, auth.user.pseudo)}
                        type="button"
                        className="btn btn-signal">
                        <span>{signals.length} <FaExclamationTriangle/></span>
                    </button>
                )}
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

export default connect(mapStateToProps, { addRemarkLike, removeRemarkLike, deleteRemark, addRemarkSignal, removeRemarkSignal })(RemarkItem);