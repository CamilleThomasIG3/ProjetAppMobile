import  {combineReducers} from 'redux';
import remarkReducer from './remarkReducer';

export default combineReducers({
    remark: remarkReducer
});