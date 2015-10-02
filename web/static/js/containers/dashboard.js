import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';

import Header from '../components/header';
import Footer from '../components/footer';
import HealthCheckList from '../components/health-checks';
import { deleteHealthCheck,
         fetchHealthChecks } from '../actions/healthChecks'

class App extends Component {
  componentDidMount() {
    const { dispatch } = this.props;
    dispatch(fetchHealthChecks());
  }

  render() {
    const { csrf, dispatch, healthChecks } = this.props;
    return (
      <div className='container'>
        <Header />
        <HealthCheckList
          healthChecks={healthChecks}
          onDeleteClick={id => dispatch(deleteHealthCheck(id, csrf))} />
        <Footer />
      </div>
    )
  }
};

App.propTypes = {
  healthChecks: PropTypes.array,
  csrf: PropTypes.string
};

let mapStateToProps = function(state) {
  return {
    healthChecks: state.healthChecks,
    csrf: state.csrfToken
  };
}

module.exports = connect(mapStateToProps)(App);
