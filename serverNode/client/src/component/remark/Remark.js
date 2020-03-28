import React, { Fragment, useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Spinner from '../layout/Spinner'
import { getRemark } from '../../actions/remark'
import RemarkItem from '../remarks/RemarkItem';
import AnswerForm from './AnswerForm';
import AnswerItem from './AnswerItem';
import { Input } from 'reactstrap'
import { FaArrowLeft } from 'react-icons/fa'; //icones

const Remark = ({ getRemark, remark: { remark, loading }, match }) => {

    const [selectCat, handleChangeSelectCat] = useState('all')
    const [filter, handleChangeFilter] = useState('recent');

    useEffect(() => {
        getRemark(match.params.id);
    }, [getRemark, match.params.id]);

    return loading || remark === null ?
        (<Spinner />) : (
            <Fragment>
                <Link to="/remarks" className="btn"><FaArrowLeft /></Link>

                <RemarkItem remark={remark} showActions={false} />
                <AnswerForm remarkId={remark._id} />
                <div className="selectGroup">
                    <Input type="select" value={selectCat} onChange={e => handleChangeFilter(e.target.value)}>
                        <option value='recent'>recent</option>
                        <option value='likes' >likes</option>
                    </Input>
                </div>
                {filter === 'recent' &&
                    <div className="posts">
                        {remark.answers.map(answer => (
                            <AnswerItem key={answer._id} answer={answer} remarkId={remark._id} />))}
                    </div>}
                {filter === 'likes' &&
                    <div className="comments">
                        {remark.answers.sort((a, b) => a.likes.length > b.likes.length ? -1 : 1).map(answer => (
                            <AnswerItem key={answer._id} answer={answer} remarkId={remark._id} /> ))}
                    </div>}
            </Fragment>
        )
}

Remark.propTypes = {
    getRemark: PropTypes.func.isRequired,
    remark: PropTypes.object.isRequired
}

const mapStateToProps = state => ({
    remark: state.remark
})

export default connect(mapStateToProps, { getRemark })(Remark)