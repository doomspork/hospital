import request from 'superagent';

export const ADD_HEALTH_CHECK    = 'ADD_HEALTH_CHECK';
export const DELETE_HEALTH_CHECK = 'DELETE_HEALTH_CHECK';
export const UPDATE_HEALTH_CHECK = 'UPDATE_HEALTH_CHECK';

export function addHealthCheck(hc) {
  return {
    type: ADD_HEALTH_CHECK,
    id: hc.id,
    name: hc.name,
    target: hc.target,
    healthCheckType: hc.type,
    options: hc.options
  };
}

function removeHealthCheck(id) {
  return {
    type: DELETE_HEALTH_CHECK,
    id: id
  };
}

export function deleteHealthCheck(id, csrf_token) {
  return function(dispatch) {
    request.del('/health_checks/' + id)
    .set('x-csrf-token', csrf_token)
    .end(function(err, res){
      if (res.ok) {
        dispatch(removeHealthCheck(id));
      } else {
        // Handle failure
      }
    });
  };
}

function receiveHealthChecks(health_checks) {
  return function(dispatch) {
    health_checks.forEach(function(health_check){
      dispatch(addHealthCheck(health_check));
    });
  };
}

export function fetchHealthChecks() {
  return function(dispatch) {
    request.get('/health_checks')
    .end(function(err, res){
      if (res.ok) {
        let json = res.body.data;
        dispatch(receiveHealthChecks(json));
      } else {
        // Handle failure
      }
    });
  };
}

function receiveHealthCheckUpdates(id, json) {
  return {
    type: UPDATE_HEALTH_CHECK,
    id: id,
    json
  }
}

export function pollHealthCheckUpdates(id) {
  return function(dispatch) {
    setTimeout(() => {
      request.get('/health_checks/' + id + '/summary')
      .end(function(err, res){
        if (res.ok) {
          let json = res.body.data;
          dispatch(receiveHealthCheckUpdates(id, json));

        } else {
          // Handle failure
        }
        dispatch(pollHealthCheckUpdates(id));
      });
    }, 60000);
  }
}
