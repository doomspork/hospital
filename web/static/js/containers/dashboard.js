let React           = require('react');
let { connect }     = require('react-redux');
let request         = require('superagent');
let Header          = require('../components/header');
let Footer          = require('../components/footer');
let HealthCheckList = require('../components/health-checks');

let { deleteHealthCheck,
      addHealthCheck } = require('../actions/healthChecks').actionCreators;

let app = React.createClass({
  propTypes: {
    healthChecks: React.PropTypes.array
  },
  componentDidMount: function() {
    const { dispatch } = this.props;
    request
      .get('/api/health_checks')
      .end((err, res) => {
        let data = JSON.parse(res.text).data;
        data.forEach(function(item) {
          dispatch(addHealthCheck(item));
        });
      });
  },
  render: function() {
    const { dispatch, healthChecks } = this.props;
    return (
      <div className='container'>
        <Header />
        <HealthCheckList
          healthChecks={healthChecks}
          onDeleteClick={id => dispatch(deleteHealthCheck(id))} />
        <Footer />
      </div>
    )
  }
});

let injectedState = function(state) {
  return {
    healthChecks: state.healthChecks
  };
}

module.exports = connect(injectedState)(app);
