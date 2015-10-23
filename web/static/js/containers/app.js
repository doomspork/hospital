import React, { PropTypes, Component } from 'react'
import Footer from '../components/footer'

export default class App extends Component {
  render () {
    return (
      <div id="layout" className={activeClass}>
        <div id="main">
          {/* this will render the child routes */}
          {this.props.children}
        </div>
        <Footer />
      </div>
    )
  }
}
