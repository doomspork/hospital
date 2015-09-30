let React       = require('react');
let request     = require('superagent')
let HealthCheck = require('./health-check');

module.exports = React.createClass({
  getInitialState: function() {
    return {
      healthChecks: []
    }
  },
  componentDidMount: function() {
    request
      .get('/api/health_checks')
      .end((err, res) => {
        let data = JSON.parse(res.text).data;
        this.setState({ healthChecks: data })
      });
  },
  render: function() {
    const { healthChecks } = this.state;
    return (
      <div className="health-checks">
        { healthChecks.map(function(instance) {
          return (
            <HealthCheck
              name={instance.name}
              key={instance.id}
              target={instance.target}
              type={instance.type}
              options={instance.options} />
          )
        })}
      </div>
    )
  }
});
