import React, { Fragment, useEffect, useState } from 'react';
import { connect } from 'react-redux';
import { getRemarks, deleteRemark } from '../../actions/remark';
import Spinner from '../layout/Spinner';
import PropTypes from 'prop-types';
import RemarkItem from '../remarks/RemarkItem';
import {Input} from 'reactstrap'
import AnswerItem from '../remark/AnswerItem';


const ReportedRemarks = ({ isAuthenticated, getRemarks, deleteRemark, remark: { remarks, loading } }) => {

    const [selectCat, handleChangeSelectCat] = useState('all')
    const [filter, handleChangeFilter] = useState('recent');
    const [choice, handleChangeChoice] = useState('remarks');
    useEffect(() => {
        // if (choice == 'remarks'){
            getRemarks(selectCat);
        // }
        // else {
        //     getRemarks(selectCat).map(r =>
        //         r.answers.map(answer =>
        //             <AnswerItem key={answer._id} answer={answer} remarkId={r._id}/>))
        // }
    }, [getRemarks, filter, selectCat, choice]);


    return loading ? <Spinner /> : (
        <div className="page-remarks">
            <h1 className="large text-primary">Reports</h1>


            {/* full screen */}
            <div>
                <button className="btn" value={'remarks'} onClick={e => handleChangeChoice(e.target.value)}>
                    Remarks
                    </button>
                <button className="btn" value={'answers'} onClick={e => handleChangeChoice(e.target.value)}>
                    Answers
                    </button>
            </div>
            {choice === 'remarks' &&
                <Fragment>
                    <div>
                        <h2>Reported Remarks</h2>
                    </div>
                    <div className="hide-mobile sort-buttons">
                        <button className="btn" value={'recent'} onClick={e => handleChangeFilter(e.target.value)}>
                            Sort by date
                            </button>
                        <button className="btn" value={'signals'} onClick={e => handleChangeFilter(e.target.value)} >
                            Sort by number of Signals
                            </button>
                        <button className="btn" value={'answers'} onClick={e => handleChangeFilter(e.target.value)}>
                            Sort by number of answers
                            </button>
                    </div>

                    {/* responsive screen */}
                    <div className="visible-mobile sort-buttons">
                        <button className="btn" value={'recent'} onClick={e => handleChangeFilter(e.target.value)}>
                            Date</button>
                        <button className="btn" value={'Signals'} onClick={e => handleChangeFilter(e.target.value)} >
                            Signals</button>
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
                                {remarks.filter(r => r.signals.length > 0).map(remark => (
                                    <RemarkItem key={remark._id} remark={remark} />))}
                            </div>
                        </Fragment>}

                    {filter === 'signals' &&
                        <Fragment>
                            <div className="posts">
                                {remarks.filter(r => r.signals.length > 0).sort((a, b) => a.signals.length > b.signals.length ? -1 : 1).map(remark => (
                                    <RemarkItem key={remark._id} remark={remark} />))}
                            </div>
                        </Fragment>}

                    {filter === 'answers' &&
                        <Fragment>
                            <div className="posts">
                                {remarks.filter(r => r.signals.length > 0).sort((a, b) => a.answers.length > b.answers.length ? -1 : 1).map(remark => (
                                    <RemarkItem key={remark._id} remark={remark} />))}
                            </div>
                        </Fragment>}
                </Fragment>
            }
            {choice === 'answers' &&
                <Fragment>
                    <div>
                        <h2>Reported Answers</h2>
                    </div>
                    <div className="comments">
                        {remarks.map(r => 
                            r.answers.filter(answer => answer.signals.length > 0).sort((a,b) => a.signals.length > b.signals.length ? -1 : 1).map(answer =>
                                <AnswerItem key={answer._id} answer={answer} remarkId={r._id} /> 
                        ))
                        }
                    </div>}

                </Fragment>
            }

        </div>
    )

}

ReportedRemarks.propTypes = {
    getRemarks: PropTypes.func.isRequired,
    remark: PropTypes.object.isRequired
}

const mapStateToProps = (state) => ({
    remark: state.remark,
    isAuthenticated: state.auth.isAuthenticated
});

export default connect(
    mapStateToProps,
    { getRemarks, deleteRemark })
    (ReportedRemarks);