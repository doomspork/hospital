let React = require('react');

export default class HealthCheck extends React.Component {
  propTypes: {}
  mixins:    []

  componentWillMount() {}
  componentWillReceiveProps() {}
  componentWillUnmount() {}

  render() {
    let name = "Some health check name";
    let link = "/foo";

    return (
      <div className="panel panel-default">
        <div className="panel-heading">
          <div className="row">
            <div className="col-md-6">
              <h3 className="panel-title">{name}</h3>
            </div>
            <div className="col-md-6">
              <span className="pull-right">
                <a href="{link}"><i class="fa fa-wrench"></i></a>
                <i className="fa fa-close"></i>
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
