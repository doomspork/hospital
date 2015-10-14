import React, { Component, PropTypes } from 'react';
import has from 'lodash/object/has'
import Summary from './summary';

export default class HealthCheck extends Component {
  render() {
    const { healthCheckType, name, onDeleteClick, reports } = this.props;
    const areReportsLoaded = has(reports, 'avg');

    return (
      <div className="health-check panel panel-default">
        <div className="panel-heading">
          <div className="row">
            <div className="col-md-6">
              <h3 className="panel-title">
                <span className="label label-primary">{healthCheckType}</span>
                <span className="health-check-name">{name}</span>
              </h3>
            </div>
            <div className="col-md-6">
              <span className="pull-right">
                <i className="fa fa-wrench"></i>
                <i className="fa fa-close" onClick={onDeleteClick}></i>
              </span>
            </div>
          </div>
        </div>
        <div className="panel-body check-summary">
          {areReportsLoaded ? <Summary {...reports}/> : 'Loading...'}
        </div>
      </div>
    )
  }
};

HealthCheck.propTypes = {
  healthCheckType: PropTypes.string,
  id: PropTypes.number,
  name: PropTypes.string,
  onDeleteClick: PropTypes.func,
  reports: PropTypes.object,
  target: PropTypes.string
}
