import React, { Component, PropTypes } from 'react';

export default class HealthCheck extends Component {
  render() {
    return (
      <div className="health-check panel panel-default">
        <div className="panel-heading">
          <div className="row">
            <div className="col-md-6">
              <h3 className="panel-title">{this.props.name}</h3>
            </div>
            <div className="col-md-6">
              <span className="pull-right">
                <a href="{this.props.target}" target="_blank"><i class="fa fa-wrench"></i></a>
                <i className="fa fa-close" onClick={this.props.onDeleteClick}></i>
              </span>
            </div>
          </div>
        </div>
        <div className="panel-body">
          Panel content
        </div>
      </div>
    )
  }
};

HealthCheck.propTypes = {
  name: PropTypes.string,
  healthCheckType: PropTypes.string,
  target: PropTypes.string,
  onDeleteClick: PropTypes.func
}
