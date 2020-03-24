import {
    GET_REMARK, GET_REMARKS,
    ADD_REMARK, DELETE_REMARK,
    UPDATE_LIKES,
    REMARKS_LOADING, REMARK_ERROR,
    ADD_ANSWER, REMOVE_ANSWER,
    UPDATE_ANSWER_LIKES
} from '../actions/types'

const initialState = {
    remarks: [],
    loading: true,
    error: {}
};

export default function (state = initialState, action) {
    switch (action.type) {
        case GET_REMARKS:
            return {
                ...state,
                remarks: action.payload,
                loading: false
            }
        case GET_REMARK:
            return {
                ...state,
                remark: action.payload,
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
                remarks: state.remarks.filter(remark => remark._id !== action.payload),
                loading: false
            };
        case ADD_REMARK:
            return {
                ...state,
                remarks: [action.payload, ...state.remarks],
                loading: false
            };
        case REMARKS_LOADING:
            return {
                ...state,
                loading: true
            }
        case UPDATE_LIKES:
            return {
                ...state,
                remarks: state.remarks.map(remark => remark._id === action.payload.id ?
                    { ...remark, likes: action.payload.likes } :
                    remark),
                loading: false
            }

        case UPDATE_ANSWER_LIKES:
            return {
                ...state,
                remark: {
                    ...state.remark,
                answers: state.remark.answers.map(answer => answer._id === action.payload.answerId ?
                    { ...answer, likes: action.payload.likes } :
                    answer)},
                loading: false
            }

        case ADD_ANSWER:
            return {
                ...state,
                remark: {
                    ...state.remark,
                    answers: action.payload

                },
                loading: false
            }
        case REMOVE_ANSWER:
            return {
                ...state,
                remark: {
                    ...state.remark,
                    answers: state.remark.answers
                        .filter(answer => answer._id !== action.payload)
                },
                loading: false
            }

        default:
            return state;
    }

}