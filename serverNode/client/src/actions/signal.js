import { REMARK_ERROR, UPDATE_SIGNALS, UPDATE_ANSWER_SIGNALS} from './types';
import axios from 'axios';
import { setAlert } from './alert';


//-----------remark---------------

export const addRemarkSignal = (id, user) => async dispatch => {
    try {
        const body = {pseudo: user}
        const res = await axios
            .post('/api/remarks/'+id+'/signals', body);
        dispatch({
            type: UPDATE_SIGNALS,
            payload: {id, signals: res.data.signals}
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

export const removeRemarkSignal = (id, user) => async dispatch => {
    try {
        const res = await axios
            .delete('/api/remarks/'+id+'/usersignal/'+user);
        dispatch({
            type: UPDATE_SIGNALS,
            payload: {id, signals: res.data.signals}
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

export const deleteSignals = (id) => async dispatch => {
    try {
        await axios
            .delete('/api/remarks/'+id+'/signals');
        dispatch({
            type: UPDATE_SIGNALS,
            payload: id
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

//------------answer---------

export const addAnswerSignal = (remarkId, answerId, user) => async dispatch => {
    try {
        const body = {pseudo: user}
        const res = await axios
            .post('/api/remarks/'+remarkId+'/answers/'+answerId+'/signals', body);
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
            .delete('/api/remarks/'+remarkid+'/answers/'+answerId+'/usersignal/'+user);
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

export const deleteAnswerSignals = (remarkid, answerId) => async dispatch => {
    try {
        await axios
            .delete('/api/remarks/'+remarkid+'/answers/'+answerId+'/signals');
        dispatch({
            type: UPDATE_SIGNALS,
            payload: answerId
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

}}