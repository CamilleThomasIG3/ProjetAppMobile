import {
    REGISTER_SUCCESS, REGISTER_FAIL,
    USER_LOADED, AUTH_ERROR,
    LOGIN_FAIL, LOGIN_SUCCESS,
    EDIT_PSEUDO_SUCCESS,
    LOGOUT,
} from '../actions/types';


const initialState = {
    token: localStorage.getItem('token'),
    isAuthenticated: false,
    loading: true,
    user: null
}

export default function (state = initialState, action) {
    switch (action.type) {
        case LOGIN_SUCCESS:
        case REGISTER_SUCCESS:
            localStorage.setItem('token', action.payload.token);
            return {
                ...state,
                ...action.payload,
                isAuthenticated: true,
                loading: false
            }

        case USER_LOADED:
            return {
                ...state,
                isAuthenticated: true,
                loading: false,
                user: action.payload
            }
        case EDIT_PSEUDO_SUCCESS:            
            return{
                ...state,
                ...action.payload,
                isAuthenticated: true,
                loading: false
            }
        case REGISTER_FAIL:
        case AUTH_ERROR:
        case LOGIN_FAIL:
        case LOGOUT:
            localStorage.removeItem('token');
            return {
                ...state,
                token: null,
                isAuthenticated: false,
                loading: false
            }


        default:
            return {
                ...state, 
                loading: false
            }
    }
}