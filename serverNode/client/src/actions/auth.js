import axios from 'axios';
import {
    REGISTER_SUCCESS, REGISTER_FAIL,
    USER_LOADED, AUTH_ERROR,
    LOGIN_FAIL, LOGIN_SUCCESS,
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
        const res = await axios.get('api/auth');

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
        const errors = err.response;
        console.log(errors)
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
        const errors = err.response;
        console.log(errors)
        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({ type: LOGIN_FAIL });

    }



};

export const logout = () => dispatch => {
    dispatch({type: LOGOUT});
};



