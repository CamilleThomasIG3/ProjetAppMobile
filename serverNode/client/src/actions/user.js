import {GET_USERS,
    DELETE_USER,
    USERS_LOADING, USER_ERROR, UPDATE_ADMIN} from './types';
import { setAlert } from './alert';
import axios from 'axios';


export const getUsers = () => async dispatch => {
   try {
       const res = await axios
           .get('/api/users/');
       dispatch({
           type: GET_USERS,
           payload: res.data
       });
      

   } catch (err) {
       const errors = err.response.data;
        console.log(errors.msg);
        
       if (errors) {
           dispatch(setAlert(errors.msg, 'danger'));
       }
       dispatch({
           type: USER_ERROR,
           payload: { msg: err.response.statusText, status: err.response.status }
       });

   }

};

export const deleteUser = (id) => dispatch => {
   try {

       axios
           .delete('/api/users/' + id).then(
               res =>
                   dispatch({
                       type: DELETE_USER,
                       payload: id
                   })
           )
       dispatch(setAlert('user removed', 'success'));
   } catch (err) {
       const errors = err.response.data;
       
       if (errors) {
           dispatch(setAlert(errors.msg, 'danger'));
       }
       dispatch({
           type: USER_ERROR,
           payload: { msg: err.response.statusText, status: err.response.status }
       });

   }
};

export const removeAdmin = (id, newAdmin) => async dispatch => {
    const body = { newAdmin};
    try {
        const res = await axios
            .put(`/api/users/${id}`, body);
        dispatch({
            type: UPDATE_ADMIN,
            payload: {id, admin: res.data.admin}
        });
        
    } catch (err) {
        const errors = err.response.data;
        
        if (errors) {
            dispatch(setAlert(errors.msg, 'danger'));
        }
        dispatch({
            type: USER_ERROR,
            payload: {msg: err.response.statusText, status: err.response.status}
        });
    }

};



export const setUsersLoading = () => {
   return {
       type: USERS_LOADING
   }
}
