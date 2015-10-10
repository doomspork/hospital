import React, { Component, PropTypes } from 'react';
import HealthCheck from './health-check';
import keys from 'lodash/object/keys';

export default class HealthCheckList extends Component {
  render() {
    const { healthChecks, onDeleteClick } = this.props;
    const ids = keys(healthChecks);
    return (
      <div className="health-checks">
        { ids.map(function(id, index) {
          const instance = healthChecks[id];
          return (
            <HealthCheck {...instance}
              key={index}
              onDeleteClick={() => onDeleteClick(id)} />
          )
        })}
      </div>
    )
  }
};

HealthCheckList.propTypes = {
  healthChecks: PropTypes.object.isRequired,
  onDeleteClick: PropTypes.func.isRequired
}
