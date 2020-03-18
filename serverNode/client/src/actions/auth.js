import axios from 'axios';
import { REGISTER_SUCCESS, REGISTER_FAIL } from './types';
import { setAlert } from './alert';


export const register = ({ pseudo, email, password }) => async dispatch => {
    // const config = {
    //     'Content-type': 'application/json'
    // }

    const body = { pseudo, email, password };

    try {
        const res = await axios.post('api/users', body);
        dispatch({
            type: REGISTER_SUCCESS,
            payload: res.data.token
        });
    } catch (err) {
        const errors = err.response.data;
        console.log(errors)
        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));


        }
        dispatch({ type: REGISTER_FAIL });
        
    }

    

}



