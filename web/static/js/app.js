let React           = require('react');
let { Provider }    = require('react-redux');
let App             = require('./containers/dashboard');
let store           = require('./store/configureStore');

React.render(
  <Provider store={store}>
    {() => <App />}
  </Provider>,
  document.getElementById('root')
);
