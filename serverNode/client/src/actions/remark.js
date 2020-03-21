import { GET_REMARKS, ADD_REMARK, DELETE_REMARK, REMARKS_LOADING, SET_ALERT, REMARK_ERROR } from './types';
import { setAlert } from './alert';
import axios from 'axios';


export const getRemarks = () => async dispatch => {
    try {
        const res = await axios
            .get('/api/remarks');
        dispatch({
            type: GET_REMARKS,
            payload: res.data
        });

    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: { msg: err.response.statusText, status: err.response.status }
        });

    }

};

export const deleteRemark = (id) => dispatch => {
    try {

        axios
            .delete('/api/remarks/' + id).then(
                res =>
                    dispatch({
                        type: DELETE_REMARK,
                        payload: id
                    })
            )
        dispatch(setAlert('post remove', 'success'));
    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: { msg: err.response.statusText, status: err.response.status }
        });

    }
};


export const addRemark = (formData) => async dispatch => {
    try {
        const res = await axios.post('/api/remarks', formData);
        dispatch({
            type: ADD_REMARK,
            payload:res.data.remark
        })
        dispatch(setAlert('post created', 'success'));
    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: { msg: err.response.statusText, status: err.response.status }
        });

    }
};

export const setRemarksLoading = () => {
    return {
        type: REMARKS_LOADING
    }
}

