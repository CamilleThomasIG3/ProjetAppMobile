import { GET_REMARKS, ADD_REMARK, DELETE_REMARK, REMARKS_LOADING, SET_ALERT, REMARK_ERROR, UPDATE_LIKES } from './types';
import { setAlert } from './alert';
import axios from 'axios';


export const addLike = (remarkId) => async dispatch => {
    try {
        const res = await axios
            .post('/api/remarks/'+{remarkId}+'/likes');
        dispatch({
            type: UPDATE_LIKES,
            payload: {remarkId,likes: res.data}
        });
        
    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
};

export const removeLike = (remarkId) => async dispatch => {
    try {
        const res = await axios
            .delete('/api/remarks/'+{remarkId}+'/likes');
        dispatch({
            type: UPDATE_LIKES,
            payload: {remarkId,likes: res.data}
        });
        
    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
};
