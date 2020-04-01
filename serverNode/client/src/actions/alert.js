import {SET_ALERT, REMOVE_ALERT} from './types';


export const setAlert = (msg, alertType) => dispatch => {
    const id = 2;
    dispatch({
        type: SET_ALERT,
        payload: {msg, alertType, id}
    });

    setTimeout(() => dispatch({
        type: REMOVE_ALERT, 
        payload: id
    }), 4000);
};


