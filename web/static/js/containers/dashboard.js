import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';

import Header from '../components/header';
import WidgetContainer from '../components/widget-container';
import Sidebar from '../components/sidebar';
import PreFooter from '../components/pre-footer';
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
    return (
      <div className='foobar'>
        <Header />
        <div className="page-container">
          <WidgetContainer />
          <Sidebar />
        </div>
        <PreFooter />
        <Footer />
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
