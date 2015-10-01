import { combineReducers } from 'redux';

import {
  ADD_HEALTH_CHECK,
  DELETE_HEALTH_CHECK,
  FETCH_HEALTH_CHECKS } from '../actions/healthChecks';

const INITIAL_STATE = [];

function healthChecks(state, action) {
  if(state === undefined) {
    return INITIAL_STATE;
  }

  switch (action.type) {
    case ADD_HEALTH_CHECK:
      return [...state, {
        id: action.id,
        name: action.name,
        target: action.target,
        healthCheckType: action.type,
        options: action.options
      }];
    case DELETE_HEALTH_CHECK:
      // TODO: Actually update server, right now only happening through the UI
      return state.filter(function(hc) {
        return hc.id !== action.id;
      });
    default:
      return state;
  }
}

module.exports = combineReducers({ healthChecks });
