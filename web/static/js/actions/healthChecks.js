import request from 'superagent';

export const ADD_HEALTH_CHECK    = "ADD_HEALTH_CHECK";
export const DELETE_HEALTH_CHECK = "DELETE_HEALTH_CHECK";

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

export function deleteHealthCheck(id) {
  return {
    type: DELETE_HEALTH_CHECK,
    id: id
  };
}

function receiveHealthChecks(health_checks) {
  return dispatch => {
    health_checks.forEach(function(health_check){
      dispatch(addHealthCheck(health_check));
    });
  };
}

export function fetchHealthChecks() {
  return dispatch => {
    request.get(`/health_checks`)
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
