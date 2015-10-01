let React                           = require('react');
let { createStore, applyMiddleware} = require('redux');
let { Provider }                    = require('react-redux');
let DashboardContainer              = require('./containers/dashboard');
let DashboardReducer                = require('./reducers/dashboard');
let thunkMiddleware                 = require('redux-thunk');
let createLogger                    = require('redux-logger');

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
