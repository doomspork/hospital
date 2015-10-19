import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';

import Header from '../components/header';
import Footer from '../components/footer';
import HealthCheckList from '../components/health-checks';
import { deleteHealthCheck,
         fetchHealthChecks } from '../actions/health-checks'

class Dashboard extends Component {
  componentDidMount() {
    const { dispatch } = this.props;
    dispatch(fetchHealthChecks());
  }

  render() {
    const { csrf, dispatch, checksById } = this.props;
    return (
      <div className='container'>
        <Header />
        <HealthCheckList
          healthChecks={checksById}
          onDeleteClick={id => dispatch(deleteHealthCheck(id, csrf))} />
      </div>
    )
  }
};

Dashboard.propTypes = {
  checksById: PropTypes.object,
  csrf: PropTypes.string
};

let mapStateToProps = function(state) {
  return {
    checksById: state.healthChecks.checksById,
    csrf: state.csrfToken
  };
}

module.exports = connect(mapStateToProps)(Dashboard);
