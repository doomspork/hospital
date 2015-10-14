import { assign, mapValues, omit} from 'lodash';
import * as constants from '../constants';

const initialState = {
  checks: [],
  checksById: {}
}

export default function healthChecks(state = initialState, action) {
  switch (action.type) {
    case constants.ADD_HEALTH_CHECK:
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
    case constants.DELETE_HEALTH_CHECK:
      return {
        ...state,
        checks: state.checks.filter(id => id !== action.id),
        checksById: omit(state.checksById, action.id)
      }
    case constants.UPDATE_REPORTS:
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


