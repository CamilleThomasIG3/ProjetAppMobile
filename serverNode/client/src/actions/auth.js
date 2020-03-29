import axios from 'axios';
import {
    REGISTER_SUCCESS, REGISTER_FAIL,
    USER_LOADED, AUTH_ERROR,
    LOGIN_FAIL, LOGIN_SUCCESS,
    EDIT_PSEUDO_SUCCESS, EDIT_PSEUDO_ERROR,
    LOGOUT
} from './types';
import { setAlert } from './alert';
import setAuthToken from '../utils/setAuthToken'
//import { useCallback, useReducer } from 'react';


export const loadUser = () => async dispatch => {
    if (localStorage.token) {
        setAuthToken(localStorage.token);
    }

    try {
        const res = await axios.get('/api/auth');

        dispatch({
            type: USER_LOADED,
            payload: res.data
        });

    } catch (err) {
        
        dispatch({
            type: AUTH_ERROR
        })
    }
}


export const register = ({ pseudo, email, password }) => async dispatch => {
    // const config = {
    //     'Content-type': 'application/json'
    // }

    const body = { pseudo, email, password };

    try {
        const res = await axios.post('api/users', body);
        dispatch({
            type: REGISTER_SUCCESS,
            payload: res.data
        });
        dispatch(loadUser());
    } catch (err) {
        const errors = err.response.data;

        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({ type: REGISTER_FAIL });

    }



}

export const login = (email, password) => async dispatch => {
    // const config = {
    //     'Content-type': 'application/json'
    // }

    const body = { email, password };

    try {
        const res = await axios.post('api/auth', body);
        dispatch({
            type: LOGIN_SUCCESS,
            payload: res.data
        });
        dispatch(loadUser());
    } catch (err) {
        const errors = err.response.data;
        
        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({ type: LOGIN_FAIL });

    }



};

export const editPseudo = (id, newPseudo, password) => async dispatch => {
    const body = { newPseudo, password };

    try {
        const res = await axios.put(`api/users/${id}`, body);
        dispatch({
            type: EDIT_PSEUDO_SUCCESS,
            payload: res.data
        });
        dispatch(loadUser());
        
    } catch (err) {
        const errors = err.response.data;
        
        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({ type: EDIT_PSEUDO_ERROR });
    }
};

export const logout = () => dispatch => {
    dispatch({type: LOGOUT});
};



