import * as constants from '../constants';
import request from 'superagent';

export function login (form, redirect) {
  return function(dispatch, getState) {
    const { application } = getState();
    request.post('/login', { user: form })
    .set('x-csrf-token', application.csrf)
    .end(function(err, res){
      if (res.ok) {
        let user = res.body.data;
        dispatch({
          type: constants.LOGGED_IN,
          user
        });
        if (redirect) redirect();
      } else {
        // Handle failure
      }
    });
  };
}
