import {GET_USERS,
    DELETE_USER,
    USERS_LOADING, USER_ERROR,
   REMOVE_ADMIN_SUCCESS, REMOVE_ADMIN_ERROR } from '../actions/types'

const initialState = {
    users: [],
    user: null,
    loading: true,
    error: {},
};

export default function (state = initialState, action) {
    switch (action.type) {
        case GET_USERS:
            return {
                ...state,
                users: action.payload,
                loading: false
            }
        case USER_ERROR:
            return {
                ...state,
                error: action.payload,
                loading: false
            };
        case DELETE_USER:
            return {
                ...state,
                users: state.users.filter(user => user._id !== action.payload),
                loading: false
            };
        case USERS_LOADING:
            return {
                ...state,
                loading: true
            }
        case UPDATE_ADMIN:
            return {
                ...state,
                users: state.users.map(user => user._id === action.payload.id ?
                    { ...user, admin: action.payload.admin } :
                    user),
                loading: false
            }

        default:
            return state;
    }

}