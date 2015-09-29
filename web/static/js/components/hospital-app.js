let React = require('react');
let Header = require('./header');
let Footer = require('./footer');
let HealthCheck = require('./health-check');

export default class HospitalApp extends React.Component {
  propTypes: {}
  mixins:    []

  componentWillMount() {}
  componentWillReceiveProps() {}
  componentWillUnmount() {}

  render() {
    return (
      <div className='container'>
        <Header />
        <HealthCheck />
        <HealthCheck />
        <HealthCheck />
        <Footer />
      </div>
    )
  }
};
