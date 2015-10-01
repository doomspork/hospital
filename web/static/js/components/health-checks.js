import React, { Component, PropTypes } from 'react';
import HealthCheck from './health-check';

export default class HealthCheckList extends Component {
  render() {
    const { healthChecks, onDeleteClick } = this.props;
    return (
      <div className="health-checks">
        { healthChecks.map(function(instance, index) {
          return (
            <HealthCheck {...instance}
              key={index}
              onDeleteClick={() => onDeleteClick(instance.id)} />
          )
        })}
      </div>
    )
  }
};

HealthCheckList.propTypes = {
  onDeleteClick: PropTypes.func,
  healthChecks: PropTypes.array
}
