let React = require('react');

module.exports = React.createClass({
  propTypes: {
    name: React.PropTypes.string,
    target: React.PropTypes.string,
    onDeleteClick: React.PropTypes.func
  },
  render: function() {
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
});
