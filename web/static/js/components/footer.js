import React from "bower_components/react/react";

export default class Footer extends React.Component {
  propTypes: {}
  mixins:    []

  getInitialState() {}
  getDefaultProps() { return {} }
  componentWillMount() {}
  componentWillReceiveProps() {}
  componentWillUnmount() {}

  render() {
    return (
      <footer className="footer">
        <p>A product of <a href="https://utensils.io">utensils.io</a> &copy;  2015</p>
      </footer>
    )
  }
};
