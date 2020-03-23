import { REMARK_ERROR, UPDATE_LIKES } from './types';
import axios from 'axios';


export const addLike = (id, user) => async dispatch => {
    try {
        const body = {pseudo: user}
        const res = await axios
            .post('/api/remarks/'+id+'/likes', body);
        dispatch({
            type: UPDATE_LIKES,
            payload: {id, likes: res.data.likes}
        });
        
    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
};

export const removeLike = (id, user) => async dispatch => {
    try {
        const res = await axios
            .delete('/api/remarks/'+id+'/userlike/'+user);
        dispatch({
            type: UPDATE_LIKES,
            payload: {id, likes: res.data.likes}
        });
        
    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
};
