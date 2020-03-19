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
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
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

