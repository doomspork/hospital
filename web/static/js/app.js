let React              = require('react');
let { createStore }    = require('redux');
let { Provider }       = require('react-redux');
let DashboardContainer = require('./containers/dashboard');
let DashboardReducer   = require('./reducers/dashboard');

let store = createStore(DashboardReducer);

// Audit trail of application state
store.subscribe(() => console.log(store.getState()));

React.render(
  <Provider store={store}>
    {() => <DashboardContainer />}
  </Provider>,
  document.getElementById('root')
);
