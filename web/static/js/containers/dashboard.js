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
    const { csrf, dispatch, checksById, reports } = this.props;
    return (
      <div className='container'>
        <Header />
        <HealthCheckList
          healthChecks={checksById}
          onDeleteClick={id => dispatch(deleteHealthCheck(id, csrf))} />
        <Footer />
      </div>
    )
  }
};

App.propTypes = {
  checksById: PropTypes.object,
  csrf: PropTypes.string
};

let mapStateToProps = function(state) {
  return {
    checksById: state.healthChecks.checksById,
    csrf: state.csrfToken
  };
}

module.exports = connect(mapStateToProps)(App);
