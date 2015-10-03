import React, { Component, PropTypes } from 'react';
import Summary from './summary';

export default class HealthCheck extends Component {
  render() {
    return (
      <div className="health-check panel panel-default">
        <div className="panel-heading">
          <div className="row">
            <div className="col-md-6">
              <h3 className="panel-title">
                <span className="label label-primary">{this.props.healthCheckType}</span>
                <span className="health-check-name">{this.props.name}</span>
              </h3>
            </div>
            <div className="col-md-6">
              <span className="pull-right">
                <i className="fa fa-wrench"></i>
                <i className="fa fa-close" onClick={this.props.onDeleteClick}></i>
              </span>
            </div>
          </div>
        </div>
        <div className="panel-body">
          <Summary />
        </div>
      </div>
    )
  }
};

HealthCheck.propTypes = {
  id: PropTypes.number,
  name: PropTypes.string,
  healthCheckType: PropTypes.string,
  target: PropTypes.string,
  onDeleteClick: PropTypes.func
}
