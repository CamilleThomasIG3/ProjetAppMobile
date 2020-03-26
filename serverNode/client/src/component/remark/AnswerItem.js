import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
//import Moment from 'react-moment';
import { connect } from 'react-redux';
//import { addRemarkLike, removeRemarkLike } from '../../actions/likes'
import { deleteAnswer } from '../../actions/remark'
import {addAnswerLike, removeAnswerLike} from '../../actions/likes'

const AnswerItem = ({
    remarkId,
    answer: { _id, content, categoryResponse, user, date, likes}, 
    auth, 
    answer,
    deleteAnswer,
    addAnswerLike,
    removeAnswerLike
}) => (
        <div class="post bg-white p-1 my-1">
          <div>
              <h4>Catégorie : 
          <button type="button" className="btn btn-light">
                {categoryResponse}
            </button></h4>
            <p class="my-1">
              {content} </p>
             <p class="post-date">
                Posted on {date} by {user}
            </p>
            <button onClick={e => {if(auth.isAuthenticated) addAnswerLike(remarkId, _id, auth.user.pseudo)}}
                    type="button" className="btn btn-light">
                    <i className="fas fa-thumbs-up"></i>
                    <span>{likes.length} like</span>
                </button>
                <button onClick ={ e => {if(auth.isAuthenticated) removeAnswerLike(remarkId, _id, auth.user.pseudo)}}
                type="button" className="btn btn-light">
                    <i className="fas fa-thumbs-up"></i>
                    <span>unlike</span>
                </button>
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
          </div>
        </div>
    )
    


AnswerItem.defaultProps= {
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

export default connect(mapStateToProps, { addAnswerLike, removeAnswerLike,deleteAnswer})(AnswerItem);