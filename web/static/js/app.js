import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { ReduxRouter } from 'redux-router';
import { Route, IndexRoute } from 'react-router';
import configureStore from './store/configureStore';
import { get } from './persistence/storage';
import { App, Dashboard, Login } from './containers';
import { LOG_OUT } from './constants';

const root = document.getElementById('root');

const initialState = {
  application: {
    csrf: root.attributes[1].nodeValue,
    token: get('token'),
    email: null,
    name: null,
  }
};

let store = configureStore(initialState);

function requireAuth(nextState, replaceState) {
  const state = store.getState();
  const isLoggedIn = Boolean(state.application.token);
  if (!isLoggedIn)
    replaceState({
      nextPathname: nextState.location.pathname
    }, '/login');
}

function logout(nextState, replaceState) {
  store.dispatch({ type: LOG_OUT });
  replaceState({}, '/login');
}

ReactDOM.render(
  <Provider store={store}>
    <ReduxRouter>
      <Route path="/" component={App}>
        <IndexRoute component={Dashboard} />
        <Route path="dashboard" component={Dashboard} onEnter={requireAuth} />
        <Route path="login" component={Login} />
        <Route path="logout" onEnter={logout} />
      </Route>
    </ReduxRouter>
  </Provider>,
  root
)
