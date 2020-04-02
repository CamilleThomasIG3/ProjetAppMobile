import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { deleteAnswer } from '../../actions/remark'
import { addAnswerLike, removeAnswerLike } from '../../actions/likes'
import { addAnswerSignal, removeAnswerSignal, deleteAnswerSignals } from '../../actions/signal'
import { Card } from 'react-bootstrap'
import {Link} from 'react-router-dom'

import Moment from 'moment'
import { FaThumbsUp, FaExclamationTriangle, FaTrashAlt } from 'react-icons/fa';

const isAlreadyByUser = (pseudo, tab) => {
    var res = false
    tab.forEach(function (element) {
        if (element.user === pseudo) {
            res = true
        }
    })
    return res
}

const AnswerItem = ({
    remarkId,
    answer: { _id, content, categoryResponse, user, date, likes, signals },
    auth,
    answer,
    deleteAnswer,
    addAnswerLike,
    removeAnswerLike,
    addAnswerSignal,
    deleteAnswerSignals,
    removeAnswerSignal
}) => (
        <Card className="post-content">
            <Card.Header><Link to={`/remarks/${remarkId}`} className="btn btn-dark">
                        
                    Posted by <i>{user}</i> on <i>{Moment(date).format('MM-DD-YYYY')}</i></Link> </Card.Header>
            <Card.Body>
                <Card.Subtitle className="mb-2 text-muted">{categoryResponse}</Card.Subtitle>
                <Card.Text>
                    {content}
                </Card.Text>

                {/* LIKE */}
                {auth.isAuthenticated && !isAlreadyByUser(auth.user.pseudo, likes) && (
                    <button onClick={e => { if (auth.isAuthenticated) addAnswerLike(remarkId, _id, auth.user.pseudo) }}
                        type="button" className="btn btn-light like">
                        <span>{likes.length} <FaThumbsUp /></span>
                    </button>
                )}
                {auth.isAuthenticated && isAlreadyByUser(auth.user.pseudo, likes) && (
                    <button onClick={e => { if (auth.isAuthenticated) removeAnswerLike(remarkId, _id, auth.user.pseudo) }}
                        type="button" className="btn btn-primary">
                        <span>{likes.length} likes</span>
                    </button>
                )}

                {/* SIGNAL */}
                {auth.isAuthenticated && !isAlreadyByUser(auth.user.pseudo, signals) && (
                    <button
                        onClick={e => addAnswerSignal(remarkId, _id, auth.user.pseudo)}
                        type="button"
                        className="btn btn-light signal"
                    >
                        <span>{signals.length} <FaExclamationTriangle /></span>

                    </button>
                )}
                {auth.isAuthenticated && isAlreadyByUser(auth.user.pseudo, signals) && (
                    <button
                        onClick={e => removeAnswerSignal(remarkId, _id, auth.user.pseudo)}
                        type="button"
                        className="btn btn-signal"
                    >
                        <span>{signals.length} reports</span>

                    </button>
                )}

                {/* DELETE */}
                {auth.isAuthenticated && !auth.user.admin && (
                    !auth.loading && user === auth.user.pseudo && (<button
                        onClick={e => deleteAnswer(remarkId, _id)}
                        type="button"
                        className="btn btn-danger"
                    >
                        delete
                    </button>
                    ))}
                {auth.isAuthenticated && auth.user.admin && (
                    <button
                        onClick={e => deleteAnswer(remarkId, _id)}
                        type="button"
                        className="btn btn-danger"
                    >
                        delete
                    </button>
                )}
                {auth.isAuthenticated && auth.user.admin && signals.length>0 && (
                        <button
                            onClick={e => deleteAnswerSignals(remarkId, _id)}
                            type="button"
                            className="btn btn-danger"
                        >
                        <FaTrashAlt/> signals
                        </button>

                    )}
            </Card.Body>
        </Card>
    )



AnswerItem.defaultProps = {
    showActions: true
}

AnswerItem.propTypes = {
    remarkId: PropTypes.string.isRequired,
    answer: PropTypes.object.isRequired,
    auth: PropTypes.object.isRequired,
    deleteAnswer: PropTypes.func.isRequired
}


const mapStateToProps = state => ({
    auth: state.auth
})

export default connect(mapStateToProps, { addAnswerLike, removeAnswerLike, deleteAnswer, addAnswerSignal, removeAnswerSignal, deleteAnswerSignals })(AnswerItem);