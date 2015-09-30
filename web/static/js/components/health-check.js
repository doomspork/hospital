let React = require('react');

module.exports = React.createClass({
  propTypes: {
    name: React.PropTypes.string,
    options: React.PropTypes.object,
    target: React.PropTypes.string,
    type: React.PropTypes.string,
    id: React.PropTypes.number
  },
  render: function() {
    return (
      <div className="panel panel-default">
        <div className="panel-heading">
          <div className="row">
            <div className="col-md-6">
              <h3 className="panel-title">{this.props.name}</h3>
            </div>
            <div className="col-md-6">
              <span className="pull-right">
                <a href="{this.props.target}" target="_blank"><i class="fa fa-wrench"></i></a>
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
});
