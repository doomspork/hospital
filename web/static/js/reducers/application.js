import * as constants from '../constants';

const initialState = {
  csrf: null,
  token: null,
  email: null,
  name: null,
};

export default function application(state = initialState, action) {
  switch (action.type) {
    case constants.LOGGED_IN:
      return {
        ...state,
        ...action.user
      }
    case constants.LOG_OUT:
      return {
        ...initialState,
        token: state.token
      }
    default:
      return state;
  }
}
