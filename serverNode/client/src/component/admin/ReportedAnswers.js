import React, { useEffect, useState } from 'react';
import { connect } from 'react-redux';
import { getRemarks, deleteRemark } from '../../actions/remark';
import Spinner from '../layout/Spinner';
import PropTypes from 'prop-types';
import {Input} from 'reactstrap'
import AnswerItem from '../remark/AnswerItem';


const ReportedAnswers = ({ isAuthenticated, getRemarks, deleteRemark, remark: { remarks, loading } }) => {
    const [selectCatAnsw, handleChangeSelectCatAnsw] = useState('all');
    const [filterAnsw, handleChangeFilterAnsw] = useState('recent');
    const [selectCat] = useState('all');
    useEffect(() => {
            getRemarks(selectCat);
    }, [getRemarks, selectCat, selectCatAnsw, filterAnsw]);


    return loading ? <Spinner /> : (
        <div className="page-remarks">
                    <div>
                        <h2 className="reports text-primary">Reported answers</h2>
                    </div>
                    <div className="add-comment selectGroup">
                        {/* Sort */}
                        <Input type="select" value={filterAnsw} onChange={e => handleChangeFilterAnsw(e.target.value)}>
                            <option value='recent'>Sort by date</option>
                            <option value='signals' >Sort by number of reports</option>
                        </Input>
                        {/* Filter */}
                        <p className="filter-answers">Filter by category : </p>
                        <Input type="select" value={selectCatAnsw} onChange={e => handleChangeSelectCatAnsw(e.target.value)}>
                            <option value='all'>All</option>
                            <option value='Général'>General</option>
                            <option value='Humour' >Humour</option>
                            <option value='Loi' >Law</option>
                            <option value='Citation'>Citation</option>
                        </Input>
                    </div>
                    {/* sort: recent, filter : !all */}
                    {filterAnsw === 'recent' && selectCatAnsw !== 'all' &&
                    <div className="comments">
                        {remarks.map(r =>
                            r.answers.filter(answer => answer.signals.length > 0)
                                        .filter(answer => (answer.categoryResponse === selectCatAnsw))
                                        .map(answer => <AnswerItem key={answer._id} answer={answer} remarkId={r._id} />) 
                        )}   
                    </div>}
                    {/* sort : reports, filter: !all  */}
                    {filterAnsw === 'signals' && selectCatAnsw !== 'all' &&
                    <div className="comments">
                        {remarks.map(r =>
                            r.answers.filter(answer => answer.signals.length > 0)
                            .sort((a, b) => a.signals.length > b.signals.length ? -1 : 1)
                            .filter(answer => (answer.categoryResponse === selectCatAnsw))
                            .map(answer => <AnswerItem key={answer._id} answer={answer} remarkId={r._id} />)
                        )}
                    </div>}
                    {/* sort : recent, filter : all */}
                    {filterAnsw === 'recent' && selectCatAnsw === 'all' &&
                    <div className="comments">
                        {remarks.map(r =>
                            r.answers.filter(answer => answer.signals.length > 0)
                            .map(answer => <AnswerItem key={answer._id} answer={answer} remarkId={r._id} />) 
                        )}
                    </div>}
                    {/* sort: reports, filter : all */}
                    {filterAnsw === 'signals' && selectCatAnsw === 'all' &&
                    <div className="comments">
                        {remarks.map(r =>
                            r.answers.filter(answer => answer.signals.length > 0)
                            .sort((a, b) => a.signals.length > b.signals.length ? -1 : 1)
                            .map(answer =>
                                <AnswerItem key={answer._id} answer={answer} remarkId={r._id} />)
                        )}
                    </div>}

        </div>
    )

}

ReportedAnswers.propTypes = {
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
    (ReportedAnswers);
