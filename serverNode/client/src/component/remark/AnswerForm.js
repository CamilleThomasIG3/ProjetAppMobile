import React, {useState} from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import {addAnswer, addRemark} from '../../actions/remark'

const AnswerForm = ({remarkId, addAnswer, isAuthenticated, user}) => {

    const [formData, setFormData] = useState({
        pseudo: user,
        content: '',
        CategoryResponse: ''
    });

    const { pseudo, content, categoryResponse } = formData;

    const onChange = e => setFormData({ ...formData, [e.target.name]: e.target.value });

    const onSubmit = async e => {
        e.preventDefault();
        addAnswer(remarkId, formData );
    };

    if (!isAuthenticated) {
        return (
            <h2> login to post answers</h2>
        )
    }

    return (
        <div>
            <p className="lead"><i className="fas fa-user"></i> Add a comment</p>
            <form className="form" onSubmit={e => onSubmit(e)}>
                <div className="form-group">
                    <input type="text" placeholder="Category" name="categoryResponse" value={categoryResponse} onChange={e => onChange(e)} />
                </div>
                <div className="form-group">
                    <input type="text" className="text" placeholder="Write your answer" name="content" value={content}
                        onChange={e => onChange(e)} />
                </div>
                <input type="submit" className="btn btn-primary" value="addAnswer" />
            </form>
        </div>
    )
}

AnswerForm.propTypes = {
    addAnswer: PropTypes.func.isRequired,
    isAuthenticated: PropTypes.bool.isRequired

}

const mapStateToProps = state => ({
    isAuthenticated: state.auth.isAuthenticated,
    user: state.auth.user

})

export default connect(mapStateToProps, {addAnswer})(AnswerForm)