import { GET_REMARKS, ADD_REMARK, DELETE_REMARK, REMARKS_LOADING, REMARK_ERROR} from '../actions/types'

const initialState = {
    remarks: [],
    loading: true,
    error: {}
};

export default function(state = initialState, action){
    switch (action.type) {
        case GET_REMARKS:
            return {
                ...state,
                remarks: action.payload,
                loading: false
            }
        case REMARK_ERROR:
            return {
                ...state,
                error: action.payload,
                loading: false
            };
        
        case DELETE_REMARK:
            return {
                ...state,
                remarks: state.remarks.filter(remark => remark._id !== action.payload)
            };
        case ADD_REMARK:
            return {
                ...state,
                remarks: [action.payload, ...state.remarks]
            }; 
        case REMARKS_LOADING:
            return {
                ...state,
                loading: true
            }   
        default: 
            return state;
    }
     
}