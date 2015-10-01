import React from 'react';
import { createStore, applyMiddleware} from 'redux';
import { Provider } from 'react-redux';
import thunkMiddleware from 'redux-thunk';
import createLogger from 'redux-logger';

import DashboardContainer from './containers/dashboard';
import DashboardReducer from './reducers/dashboard';

const loggerMiddleware = createLogger();
const createStoreWithMiddleware = applyMiddleware(
  thunkMiddleware,
  loggerMiddleware
)(createStore);

let store = createStoreWithMiddleware(DashboardReducer);

React.render(
  <Provider store={store}>
    {() => <DashboardContainer />}
  </Provider>,
  document.getElementById('root')
);
