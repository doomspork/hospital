import createLogger from 'redux-logger';
import rootReducer from '../reducers';
import thunk from 'redux-thunk';
import { createStore, applyMiddleware, compose } from 'redux';
import { reduxReactRouter } from 'redux-router';
import createHistory from 'history/lib/createBrowserHistory';
import persistenceStore from '../persistence/store';

const storeEnhancers = [persistenceStore];

const finalCreateStore = compose(
  ...storeEnhancers,
  applyMiddleware(thunk),
  reduxReactRouter({ createHistory }),
  applyMiddleware(createLogger())
)(createStore);

export default function configureStore(initialState) {
  return finalCreateStore(rootReducer, initialState);
}
