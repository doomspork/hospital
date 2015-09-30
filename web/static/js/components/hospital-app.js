let React        = require('react');
let Header       = require('./header');
let Footer       = require('./footer');
let HealthChecks = require('./health-checks');

module.exports = React.createClass({
  render: function() {
    return (
      <div className='container'>
        <Header />
        <HealthChecks />
        <Footer />
      </div>
    )
  }
});
