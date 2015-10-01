let React       = require('react');
let HealthCheck = require('./health-check');

module.exports = React.createClass({
  propTypes: {
    onDeleteClick: React.PropTypes.func,
    healthChecks: React.PropTypes.array
  },
  render: function() {
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
});
