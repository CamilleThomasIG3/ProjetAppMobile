import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
//import Moment from 'react-moment';
import { connect } from 'react-redux';
import {addLike} from '../../actions/likes'
import { deleteRemark} from '../../actions/remark'

const RemarkItem = ({ 
    deleteRemark,
    addLike,
    auth, 
    remark: { _id, title, content, user, date, likes, answers, idCategory } }) =>
    <div className="post bg-white p-1 my-1">
        <div>
            <a href="profile.html">
                <h4>{title}</h4>
            </a>
        </div>
        <div>
            <button type="button" className="btn btn-light">
                {idCategory}
            </button>
            <p className="my-1">
                {content}
            </p>
            <p className="post-date">
                Posted on {date}
            </p>
            <button type="button" onClick={e => addLike(_id)} className="btn btn-light">
                <i className="fas fa-thumbs-up"></i>
                <span>{likes.length}</span>
            </button>
            <Link to={'remark/' + _id} className="btn btn-primary">
                Discussion {answers.length > 0 && (
                    <span className='comment-count'>{answers.length}</span>
                )}
            </Link>
            {auth.isAuthenticated && (
                !auth.loading && user == auth.user.pseudo && (<button
                onClick={e => deleteRemark(_id)}
                    type="button"
                    className="btn btn-danger"
                >
                    delete
                </button>
                ))}

        </div>
    </div>


RemarkItem.propTypes = {
    remark: PropTypes.object.isRequired,
    auth: PropTypes.object.isRequired,
    deleteRemark: PropTypes.func.isRequired
}


const mapStateToProps = state => ({
    auth: state.auth
})

export default connect(mapStateToProps, {addLike, deleteRemark})(RemarkItem);