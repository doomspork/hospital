import { combineReducers } from 'redux';
import { assign, constains, mapValues, merge, omit} from 'lodash';
import { routerStateReducer as router } from 'redux-router';
import healthChecks from './health-checks'
import application from './application'

const rootReducer = combineReducers({
  application,
  healthChecks,
  router
});

export default rootReducer;
