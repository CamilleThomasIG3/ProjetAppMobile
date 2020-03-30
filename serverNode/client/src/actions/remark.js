import {
    GET_REMARK, GET_REMARKS,
    ADD_REMARK, DELETE_REMARK,
    REMARKS_LOADING, REMARK_ERROR,
    ADD_ANSWER, REMOVE_ANSWER
} from './types';
import { setAlert } from './alert';
import axios from 'axios';


export const getRemarks = (cat) => async dispatch => {
    try {
        var res = null
        if (cat === 'all') {
            res = await axios
                .get('/api/remarks');
            dispatch({
                type: GET_REMARKS,
                payload: res.data
            });
        }
        else {
            res = await axios
                .get('/api/remarks/categorie/' + cat);
            dispatch({
                type: GET_REMARKS,
                payload: res.data
            });
        }


    } catch (err) {
        const errors = err.response.data;

        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({
            type: REMARK_ERROR,
            payload: { msg: err.response.statusText, status: err.response.status }
        });

    }

};

export const getMyRemarks = (user) => async dispatch => {
    try {
        const res = await axios
            .get('/api/remarks/user/'+user);
        dispatch({
            type: GET_REMARKS,
            payload: res.data
        });

    } catch (err) {
        const errors = err.response.data;

        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
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
        dispatch(setAlert('remark removed', 'success'));
    } catch (err) {
        const errors = err.response.data;

        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({
            type: REMARK_ERROR,
            payload: { msg: err.response.statusText, status: err.response.status }
        });

    }
};


export const addRemark = (formData, cuser) => async dispatch => {
    try {
        const body = {
            title: formData.title,
            content: formData.content,
            idCategory: formData.idCategory,
            pseudo: cuser.pseudo
        }
        const res = await axios.post('/api/remarks', body);
        dispatch({
            type: ADD_REMARK,
            payload: res.data.remark
        })
        dispatch(setAlert('post created', 'success'));
    } catch (err) {
        const errors = err.response.data;

        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({
            type: REMARK_ERROR,
            payload: { msg: err.response.statusText, status: err.response.status }
        });

    }
};

export const getRemark = (id) => async dispatch => {
    try {
        const res = await axios
            .get(`/api/remarks/${id}`);
        dispatch({
            type: GET_REMARK,
            payload: res.data
        });

    } catch (err) {
        const errors = err.response.data;

        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({
            type: REMARK_ERROR,
            payload: { msg: err.response.statusText, status: err.response.status }
        });

    }

};

//add answer
export const addAnswer = (id, formData, cuser) => async dispatch => {
    try {
        const body = {
            content: formData.content,
            categoryResponse: formData.categoryResponse,
            pseudo: cuser.pseudo
        }
        const res = await axios.post('/api/remarks/' + id + '/answers', body);
        dispatch({
            type: ADD_ANSWER,
            payload: res.data.answers
        })
        dispatch(setAlert('answer created', 'success'));
    } catch (err) {
        const errors = err.response.data;

        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({
            type: REMARK_ERROR,
            payload: { msg: err.response.statusText, status: err.response.status }
        });

    }
};

//delete answer
export const deleteAnswer = (id, answerId) => async dispatch => {
    try {
        await axios.delete('/api/remarks/' + id + '/answers/' + answerId);
        dispatch({
            type: REMOVE_ANSWER,
            payload: answerId
        })
        dispatch(setAlert('answer removed', 'success'));
    } catch (err) {
        const errors = err.response.data;

        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
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

