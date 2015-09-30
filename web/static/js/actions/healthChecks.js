const ADD_HEALTH_CHECK    = "ADD_HEALTH_CHECK";
const DELETE_HEALTH_CHECK = "DELETE_HEALTH_CHECK";

module.exports = {
  actions: {
    ADD_HEALTH_CHECK: ADD_HEALTH_CHECK,
    DELETE_HEALTH_CHECK: DELETE_HEALTH_CHECK
  },
  actionCreators: {
    addHealthCheck: function(hc) {
      return {
        type: ADD_HEALTH_CHECK,
        id: hc.id,
        name: hc.name,
        target: hc.target,
        healthCheckType: hc.type,
        options: hc.options
      }
    },
    deleteHealthCheck: function(id) {
      return {
        type: DELETE_HEALTH_CHECK,
        id: id
      }
    }
  }
}
