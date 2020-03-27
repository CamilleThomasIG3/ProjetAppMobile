import React, { useState } from 'react';
import PropTypes from 'prop-types'
import { connect } from 'react-redux';
import { addRemark } from '../../actions/remark'
// import { Button } from 'reactstrap';
// import { Link} from 'react-router-dom';




const RemarkForm = ({ addRemark, isAuthenticated, user }) => {
    const [formData, setFormData] = useState({
        title: '',
        content: '',
        idCategory: ''
    });

    const { title, content, idCategory } = formData;

    const onChange = e => setFormData({ ...formData, [e.target.name]: e.target.value });

    const onSubmit = async e => {
        e.preventDefault();
        addRemark({ title, content, idCategory }, user);
        // e.clear();
    };

    if (!isAuthenticated) {
        return (
            <h2>you have to login to post remarks</h2>
        )
    }

    return (
        <div>
            <p className="lead"><i className="fas fa-user"></i> Add a new Remark</p>
            <form className="form" onSubmit={e => onSubmit(e)}>
                <div className="form-group">
                    <input type="text" placeholder="Title" name="title" value={title} onChange={e => onChange(e)} />
                </div>
                <div className="form-group">
                    <label>
                        <textarea className="textarea" placeholder="Write your remark" name="content" value={content}
                            onChange={e => onChange(e)}></textarea>
                    </label>
                </div>
                <div className="form-group">
                    <input type="text" placeholder="Category" name="idCategory" value={idCategory} onChange={e => onChange(e)} />
                </div>
                <input type="submit" className="btn btn-primary" value="addRemark" />
            </form>
        </div>
    )
}

RemarkForm.propTypes = {
    addRemark: PropTypes.func.isRequired,
    isAuthenticated: PropTypes.bool.isRequired,
}

const mapStateToProps = state => ({
    isAuthenticated: state.auth.isAuthenticated,
    user: state.auth.user
})

export default connect(
    mapStateToProps,
    { addRemark }
)(RemarkForm);