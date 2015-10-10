import React from 'react';
import { Provider } from 'react-redux';
import configureStore from './store/configureStore';
import DashboardContainer from './containers/dashboard';

const store = configureStore();

React.render(
  <Provider store={store}>
    {() => <DashboardContainer />}
  </Provider>,
  document.getElementById('root')
);
