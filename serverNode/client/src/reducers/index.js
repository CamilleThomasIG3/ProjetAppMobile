import  {combineReducers} from 'redux';
import alert from './alert';
import auth from './auth';
//import remarkReducer from './remarkReducer';

export default combineReducers({
    // remark: remarkReducer
    alert, 
    auth


});