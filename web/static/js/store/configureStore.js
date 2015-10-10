import { createStore, applyMiddleware} from 'redux';
import thunk from 'redux-thunk';
import createLogger from 'redux-logger';
import rootReducer from '../reducers';

const loggerMiddleware = createLogger();
const createStoreWithMiddleware = applyMiddleware(thunk, createLogger())(createStore);


export default function configureStore(initialState) {
  const store = createStoreWithMiddleware(rootReducer, initialState);

  // Middleware setup

  return store;
}
