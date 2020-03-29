import React, { Fragment, useEffect, useState } from 'react';
import { connect } from 'react-redux';
import { getRemarks, deleteRemark } from '../../actions/remark';
import Spinner from '../layout/Spinner';
import PropTypes from 'prop-types';
import RemarkItem from './RemarkItem';
import RemarkForm from './RemarkForm';
import {Input} from 'reactstrap'


const MyRemarks = ({ getRemarks, deleteRemark, remark: { remarks, loading }, auth: {isAuthenticated}, user }) => {

    const [selectCat, handleChangeSelectCat] = useState('all')
    const [filter, handleChangeFilter] = useState('recent');
    useEffect(() => {
        getRemarks(selectCat);
    }, [getRemarks, filter, selectCat]);


    return !isAuthenticated || loading ? <Spinner /> : (
        <div className="page-remarks">
            <h1 className="large text-primary">My remarks</h1>

            {/* full screen */}
            <div className="hide-mobile sort-buttons">
                <button className="btn" value={'recent'} onClick={e => handleChangeFilter(e.target.value)}>
                    Sort by date
                    </button>
                <button className="btn" value={'likes'} onClick={e => handleChangeFilter(e.target.value)} >
                    Sort by number of likes
                    </button>
                <button className="btn" value={'answers'} onClick={e => handleChangeFilter(e.target.value)}>
                    Sort by number of answers
                    </button>
            </div>

            {/* responsive screen */}
            <div className="visible-mobile sort-buttons">
                <button className="btn" value={'recent'} onClick={e => handleChangeFilter(e.target.value)}>
                    Date</button>
                <button className="btn" value={'likes'} onClick={e => handleChangeFilter(e.target.value)} >
                    Likes</button>
                <button className="btn" value={'answers'} onClick={e => handleChangeFilter(e.target.value)}>
                    Answers</button>
            </div>

            <div className="selectGroup">
                <p>Filter by category : </p>
                <Input type="select" value={selectCat} onChange={e => handleChangeSelectCat(e.target.value)}>
                    <option value='all'>All</option>
                    <option value='Rue' >Rue</option>
                    <option value='Travail'>Travail</option>
                    <option value='Transports'>Transport</option>
                    <option value='Famille'>Famille</option>
                    <option value='Général'>Général</option>
                </Input>
            </div>

            {filter === 'recent' &&
                <Fragment>
                    <div className="posts">
                        {remarks.filter(answer => answer.user === user.pseudo)
                        .map(remark => (
                            <RemarkItem key={remark._id} remark={remark} />))}
                    </div>
                </Fragment>}

            {filter === 'likes' &&
                <Fragment>
                    <div className="posts">
                        {remarks.filter(answer => answer.user === user.pseudo)
                        .sort((a, b) => a.likes.length > b.likes.length ? -1 : 1)
                        .map(remark => (
                            <RemarkItem key={remark._id} remark={remark} />))}
                    </div>
                </Fragment>}

            {filter === 'answers' &&
                <Fragment>
                    <div className="posts">
                        {remarks.filter(answer => answer.user === user.pseudo)
                        .sort((a, b) => a.answers.length > b.answers.length ? -1 : 1)
                        .map(remark => (
                            <RemarkItem key={remark._id} remark={remark} />))}
                    </div>
                </Fragment>}

        </div>
    )

}

MyRemarks.propTypes = {
    getRemarks: PropTypes.func.isRequired,
    remark: PropTypes.object.isRequired
}

const mapStateToProps = (state) => ({
    remark: state.remark,
    user: state.auth.user,
    auth: state.auth
});

export default connect(
    mapStateToProps,
    { getRemarks, deleteRemark })
    (MyRemarks);
