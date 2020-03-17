import { GET_REMARKS, ADD_REMARK, DELETE_REMARK, REMARKS_LOADING } from '../actions/types';
import axios from 'axios';

export const getRemarks = () => dispatch => {
    dispatch(setRemarksLoading());
    axios
        .get('/api/items')
        .then(res =>
            dispatch({
                type: GET_REMARKS,
                payload: res.data
            })
        )
};

export const deleteRemark = (id) => dispatch => {
    axios
        .delete('/api/remarks/${id}').then(
            res =>
                dispatch({
                    type: DELETE_REMARK,
                    payload: id
                })
        )
};

export const addRemark = remark => dispatch => {
    axios
        .post('api/remarks', remark)
        .then(res => dispatch(
            {
                type: ADD_REMARK,
                payload: res.data
            }
        ))
};

export const setRemarksLoading = () => {
    return {
        type: REMARKS_LOADING
    }
}

