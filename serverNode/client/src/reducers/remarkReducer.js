import { GET_REMARKS, ADD_REMARK, DELETE_REMARK} from '../actions/types'

const initialState = {
    remarks: [
        {id: 1, name: 'z'},
        {id: 2, name: 'a'},
        {id: 3, name: 'b'},
        {id: 4, name: 'c'}
    ]
}

export default function(state = initialState, action){
    switch (action.type) {
        case GET_REMARKS:
            return {
                ...state
            }
        default: 
            return state;
    }
     
}