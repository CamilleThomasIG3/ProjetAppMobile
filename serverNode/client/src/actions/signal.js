import { REMARK_ERROR, UPDATE_ANSWER_SIGNALS} from './types';
import axios from 'axios';
import { setAlert } from './alert';

//------------answer---------

export const addAnswerSignal = (remarkId, answerId, user) => async dispatch => {
    try {
        const body = {pseudo: user}
        const res = await axios
            .post('/api/remarks/'+remarkId+'/answers/'+answerId, body);
        dispatch({
            type: UPDATE_ANSWER_SIGNALS,
            payload: {answerId, signals: res.data.signals}
        });
        
    } catch (err) {
        const errors = err.response.data;
        
        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({
            type: REMARK_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
};

export const removeAnswerSignal = (remarkid, answerId, user) => async dispatch => {
    try {
        const res = await axios
            .delete('/api/remarks/'+remarkid+'/answers/'+answerId+'/likes/'+user);
        dispatch({
            type: UPDATE_ANSWER_SIGNALS,
            payload: {answerId, signals: res.data.signals}
        });
        
    } catch (err) {
        const errors = err.response.data;
        
        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({
            type: REMARK_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });

}
    
};