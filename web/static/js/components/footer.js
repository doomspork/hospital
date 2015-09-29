let React = require('react');

export default class Footer extends React.Component {
  propTypes: {}
  mixins:    []

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
