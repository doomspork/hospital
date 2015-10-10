import { combineReducers } from 'redux';
import merge from 'lodash/object/merge';
import omit from 'lodash/object/omit';
import assign from 'lodash/object/assign';
import contains from 'lodash/collection/contains';
import mapValues from 'lodash/object/mapValues';
import * as ActionTypes from '../actions';

function csrfToken(state, action) {
  if(state === undefined) {
    let node = document.getElementById('root').attributes[1];
    return node.nodeValue;
  }
  return state;
}

let initialState = {
  checks: [],
  checksById: {}
}

function healthChecks(state = initialState, action) {
  switch (action.type) {
    case ActionTypes.ADD_HEALTH_CHECK:
      let newId = action.id
      return {
        checks: state.checks.concat(action.id),
        checksById: {
          ...state.checksById,
          [newId]: {
            healthCheckType: action.healthCheckType,
            id: action.id,
            name: action.name,
            options: action.options,
            target: action.target,
            reports: {}
          }
        }
      }
    case ActionTypes.DELETE_HEALTH_CHECK:
      return {
        ...state,
        checks: state.checks.filter(id => id !== action.id),
        checksById: omit(state.checksById, action.id)
      }
    case ActionTypes.UPDATE_REPORTS:
      const summaries = action.summaries;

      return {
        ...state,
        checksById: mapValues(state.checksById, function (check) {
          return summaries[check.id] !== undefined ?
            assign({}, check, { reports: summaries[check.id] }) :
            check
        })
      }
    default:
      return state;
  }
}

const rootReducer = combineReducers({
  csrfToken,
  healthChecks
});

export default rootReducer;
