import React, { Fragment, useEffect, useState } from 'react';
import { connect } from 'react-redux';
import { getRemarks, deleteRemark } from '../../actions/remark';
import Spinner from '../layout/Spinner';
import PropTypes from 'prop-types';
import ReportedRemarks from './ReportedRemarks';
import ReportedAnswers from './ReportedAnswers';


const Reports = ({ isAuthenticated, getRemarks, deleteRemark, remark: { remarks, loading } }) => {
    const [choice, handleChangeChoice] = useState('remarks');
    const [selectCat] = useState('all')
    useEffect(() => {
            getRemarks(selectCat);
    }, [getRemarks, selectCat, choice]);


    return loading ? <Spinner /> : (
        <div className="page-remarks">
            <h1 className="large text-primary">Reports</h1>


            {/* full screen */}
            <div>
                <button className="btn" value={'remarks'} onClick={e => handleChangeChoice(e.target.value)}>
                    Remarks ▼
                    </button>
                <button className="btn" value={'answers'} onClick={e => handleChangeChoice(e.target.value)}>
                    Answers ▼
                    </button>
            </div>
            {choice === 'remarks' &&
                <Fragment>
                <ReportedRemarks/>
                </Fragment>
                   
            }
            {choice === 'answers' &&
                <Fragment>
                <ReportedAnswers/> 
                </Fragment>
            }

        </div>
    )

}

Reports.propTypes = {
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
    (Reports);
