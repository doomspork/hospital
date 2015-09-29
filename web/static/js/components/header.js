let React = require('react');

export default class Header extends React.Component {
  propTypes: {}
  mixins:    []

  componentWillMount() {}
  componentWillReceiveProps() {}
  componentWillUnmount() {}

  render() {
    return (
      <div className="header clearfix">
        <nav>
          <ul className="nav navbar-nav pull-right">
            <li className="active"><a href="/dashboard"><i className="fa fa-heartbeat fa-2x"></i></a></li>
            <li><a href="/settings"><i className="fa fa-cog fa-2x"></i></a></li>
            <li><a href="/logout"><i className="fa fa-sign-out fa-2x"></i></a></li>
          </ul>
        </nav>
        <h3 className="text-muted">
          <img src="/images/medic.png" width="50px" height="50px" />
          Medic
        </h3>
      </div>
    )
  }
};
