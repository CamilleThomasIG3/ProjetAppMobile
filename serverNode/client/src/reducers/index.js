import  {combineReducers} from 'redux';
import alert from './alert';
import auth from './auth';
import user from './user';
//import profile from './profile';
import remark from './remark';

export default combineReducers({
    // remark: remarkReducer
    alert, 
    auth,
    remark,
    user


});