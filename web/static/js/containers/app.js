import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';

import Header from '../components/header';
import Footer from '../components/footer';
import HealthCheckList from '../components/health-checks';
import { deleteHealthCheck,
         fetchHealthChecks } from '../actions'


class App extends Component {
  componentDidMount() {
    const { dispatch } = this.props;
    dispatch(fetchHealthChecks());
  }

  render() {
    const { csrf, dispatch, healthChecks, reports } = this.props;
    return (
      <div className='container'>
        <Header />
        <HealthCheckList
          healthChecks={healthChecks}
          reports={reports}
          onDeleteClick={id => dispatch(deleteHealthCheck(id, csrf))} />
        <Footer />
      </div>
    )
  }
};

App.propTypes = {
  csrf: PropTypes.string,
  healthChecks: PropTypes.array,
  reports: PropTypes.object
};

let mapStateToProps = function(state) {
  return {
    csrf: state.csrfToken,
    healthChecks: state.healthChecks,
    reports: state.reports
  };
}

module.exports = connect(mapStateToProps)(App);
