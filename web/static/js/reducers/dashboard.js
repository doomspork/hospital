import { combineReducers } from 'redux';

import {
  ADD_HEALTH_CHECK,
  DELETE_HEALTH_CHECK,
  UPDATE_HEALTH_CHECK } from '../actions/healthChecks';

function healthChecks(state, action) {
  if(state === undefined) {
    return [];
  }

  switch (action.type) {
    case ADD_HEALTH_CHECK:
      return [...state, {
        id: action.id,
        name: action.name,
        target: action.target,
        healthCheckType: action.healthCheckType,
        options: action.options
      }];
    case DELETE_HEALTH_CHECK:
      return state.filter(function(hc) {
        return hc.id !== action.id;
      });
    case UPDATE_HEALTH_CHECK:
      let hc = state.find(function(hc) {
        return hc.id == action.id
      });

    default:
      return state;
  }
}

function csrfToken(state, action) {
  if(state === undefined) {
    let node = document.getElementById('root').attributes[1];
    return node.nodeValue;
  }
  return state;
}

module.exports = combineReducers({ csrfToken, healthChecks });
