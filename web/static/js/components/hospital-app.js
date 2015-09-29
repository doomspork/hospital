import React from "bower_components/react/react";
import Header from "./header"
import Footer from "./footer"
import HealthCheck from "./health-check"

export default class HospitalApp extends React.Component {
  propTypes: {}
  mixins:    []

  getInitialState() {}
  getDefaultProps() { return {} }
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
