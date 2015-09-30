let React        = require('react');
let { connect }  = require('react-redux');
let Header       = require('../components/header');
let Footer       = require('../components/footer');
let HealthChecks = require('../components/health-checks');

let { deleteHealthCheck } = require('../actions/healthChecks').actionCreators;

let app = React.createClass({
  render: function() {
    const { dispatch } = this.props;
    return (
      <div className='container'>
        <Header />
        <HealthChecks
          onDeleteClick={id => dispatch(deleteHealthCheck(id))} />
        <Footer />
      </div>
    )
  }
});

let selectedState = function(state) {
  return {};
}

module.exports = connect(selectedState)(app);
