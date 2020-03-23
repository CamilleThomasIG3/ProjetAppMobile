import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
//import Moment from 'react-moment';
import { connect } from 'react-redux';
//import { addLike, removeLike } from '../../actions/likes'
//import { deleteRemark } from '../../actions/remark'

const RemarkItem = ({
    remarkId,
    answer: { _id, content, categoryResponse, user, date}, 
    auth
}) => (
        <div class="post bg-white p-1 my-1">
          <div>
          <button type="button" className="btn btn-light">
                {categoryResponse}
            </button>
            <p class="my-1">
              {content} </p>
             <p class="post-date">
                Posted on {date} by {user}
            </p>
          </div>
        </div>
    )
    


RemarkItem.defaultProps= {
    showActions: true
}

RemarkItem.propTypes = {
    remarkId: PropTypes.object.isRequired,
    answer: PropTypes.object.isRequired,
    auth: PropTypes.object.isRequired,
}


const mapStateToProps = state => ({
    auth: state.auth
})

export default connect(mapStateToProps, { })(RemarkItem);