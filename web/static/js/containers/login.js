import React, { Component, PropTypes } from 'react'
import { login } from '../actions/application'

export default class Login extends Component {
  constructor(props) {
    super(props)
    this.state = { email: null, password: null }
  }

  handleInputChange(evt) {
    this.setState({
      [evt.target.name]: evt.target.value
    })
  };

  handleSubmit(evt) {
    evt.preventDefault()
    const { history, store } = this.context;
    const { location } = this.props;

    const nextPath = location.query.nextPathname || '/dashboard';
    store.dispatch(login(this.state, () => {
      // redirect to a secure page
      history.pushState({}, nextPath);
    }))
  };

  render () {
    return (
      <div>
        <div className="header">
          <h1>Login</h1>
        </div>
        <div className="content">
          <form
            className="form-aligned"
            onSubmit={e => this.handleSubmit(e)}
            onChange={e => this.handleInputChange(e)}>
            <fieldset>
              <div className="control-group">
                <label htmlFor="email">Email</label>
                <input type="email" name="email" placeholder="foo@bar.com" />
              </div>
              <div className="control-group">
                <label htmlFor="password">Password</label>
                <input type="password" name="password" placeholder="secret" />
              </div>
              <button type="submit"
                className="btn btn-primary"
                >Login</button>
            </fieldset>
          </form>
        </div>
      </div>
    )
  }
}

Login.contextTypes = {
  store: PropTypes.any,
  history: PropTypes.object.isRequired
}
