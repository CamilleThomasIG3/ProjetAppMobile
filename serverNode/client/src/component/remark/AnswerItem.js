import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
//import Moment from 'react-moment';
import { connect } from 'react-redux';
//import { addRemarkLike, removeRemarkLike } from '../../actions/likes'
import { deleteAnswer } from '../../actions/remark'
import { addAnswerLike, removeAnswerLike } from '../../actions/likes'
import { addAnswerSignal} from '../../actions/signal'
import { Card } from 'react-bootstrap'

import Moment from 'moment'

const AnswerItem = ({
    remarkId,
    answer: { _id, content, categoryResponse, user, date, likes, signals },
    auth,
    answer,
    deleteAnswer,
    addAnswerLike,
    removeAnswerLike,
    addAnswerSignal
}) => (
        <Card className="post-content">
            <Card.Header>Posted by <i>{user}</i> on <i>{Moment(date).format('MM-DD-YYYY')}</i> </Card.Header>
            <Card.Body>
                <Card.Subtitle className="mb-2 text-muted">{categoryResponse}</Card.Subtitle>
                <Card.Text>
                    <p>{content}</p>
                </Card.Text>

                {auth.isAuthenticated && (
                    <button onClick={e => { if (auth.isAuthenticated) addAnswerLike(remarkId, _id, auth.user.pseudo) }}
                        type="button" className="btn btn-primary">
                        <i className="fas fa-thumbs-up"></i>
                        <span>{likes.length} like</span>
                    </button>
                )}
                {auth.isAuthenticated && (
                    <button onClick={e => { if (auth.isAuthenticated) removeAnswerLike(remarkId, _id, auth.user.pseudo) }}
                        type="button" className="btn btn-light">
                        <i className="fas fa-thumbs-up"></i>
                        <span>unlike</span>
                    </button>
                )}
                {auth.isAuthenticated &&(
                    <button
                        onClick={e => addAnswerSignal(remarkId, _id, auth.user.pseudo)}
                        type="button"
                        className="btn btn-signal"
                    >
                        <span>{signals.length} signal</span>

                    </button>
                )}
                {auth.isAuthenticated && (
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
            </Card.Body>
        </Card>
    )



AnswerItem.defaultProps = {
    showActions: true
}

AnswerItem.propTypes = {
    remarkId: PropTypes.object.isRequired,
    answer: PropTypes.object.isRequired,
    auth: PropTypes.object.isRequired,
    deleteAnswer: PropTypes.func.isRequired
}


const mapStateToProps = state => ({
    auth: state.auth
})

export default connect(mapStateToProps, { addAnswerLike, removeAnswerLike, deleteAnswer, addAnswerSignal })(AnswerItem);