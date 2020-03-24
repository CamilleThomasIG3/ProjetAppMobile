import React, { Fragment, useEffect } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Spinner from '../layout/Spinner'
import { getRemark } from '../../actions/remark'
import RemarkItem from '../remarks/RemarkItem';
import { Link } from 'react-router-dom'
import AnswerForm from './AnswerForm';
import AnswerItem from './AnswerItem';

const Remark = ({ getRemark, remark: { remark, loading }, match }) => {
    useEffect(() => {
        getRemark(match.params.id);
    }, [getRemark, match.params.id]);

    return loading || remark === null ?
        <Spinner /> :
        <Fragment>
            <RemarkItem remark={remark} showActions={false} />
            <AnswerForm remarkId={remark._id} />
            <div className="comments">
                {remark.answers.map(answer => (
                    <AnswerItem key={answer._id} answer={answer} remarkId={remark._id} />
                ))
                }</div>
        </Fragment>

}

Remark.propTypes = {
    getRemark: PropTypes.func.isRequired,
    //remark: PropTypes.object.isRequired
}

const mapStateToProps = state => ({
    remark: state.remark
})

export default connect(mapStateToProps, { getRemark })(Remark)