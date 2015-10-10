import request from 'superagent';

export const ADD_HEALTH_CHECK    = 'ADD_HEALTH_CHECK';
export const DELETE_HEALTH_CHECK = 'DELETE_HEALTH_CHECK';
export const UPDATE_REPORTS = 'UPDATE_REPORTS';

export function addHealthCheck(hc) {
    return {
      type: ADD_HEALTH_CHECK,
      healthCheckType: hc.type,
      id: hc.id,
      name: hc.name,
      options: hc.options,
      target: hc.target,
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

export function fetchHealthChecks() {
  return function(dispatch) {
    request.get('/health_checks')
    .end(function(err, res){
      if (res.ok) {
        let json = res.body.data;
        json.forEach(function(health_check){
          dispatch(addHealthCheck(health_check));
        });
        dispatch(pollHealthCheckReports());
      } else {
        // Handle failure
      }
    });
  };
}

function receiveHealthCheckReports(data) {
  return {
    type: UPDATE_REPORTS,
    summaries: data
  };
}

export function pollHealthCheckReports() {
  return function(dispatch) {
    setTimeout(() => {
      request.get('/reports')
      .end(function(err, res){
        if (res.ok) {
          let data = res.body.data;
          dispatch(receiveHealthCheckReports(data));
          dispatch(pollHealthCheckReports());
        } else {
          // Handle failure
        }
      });
    }, 5000);
  };
}
