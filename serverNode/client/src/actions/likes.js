import { REMARK_ERROR, UPDATE_LIKES, UPDATE_ANSWER_LIKES } from './types';
import axios from 'axios';



//-----------remark---------------

export const addRemarkLike = (id, user) => async dispatch => {
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

export const removeRemarkLike = (id, user) => async dispatch => {
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

//------------answer---------

export const addAnswerLike = (remarkId, answerId, user) => async dispatch => {
    try {
        const body = {pseudo: user}
        const res = await axios
            .post('/api/remarks/'+remarkId+'/answers/'+answerId, body);
        dispatch({
            type: UPDATE_ANSWER_LIKES,
            payload: {answerId, likes: res.data.likes}
        });
        
    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
};

export const removeAnswerLike = (remarkid, answerId, user) => async dispatch => {
    try {
        const res = await axios
            .delete('/api/remarks/'+remarkid+'/answers/'+answerId+'/likes/'+user);
        dispatch({
            type: UPDATE_ANSWER_LIKES,
            payload: {answerId, likes: res.data.likes}
        });
        
    } catch (err) {
        dispatch({
            type: REMARK_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
};
