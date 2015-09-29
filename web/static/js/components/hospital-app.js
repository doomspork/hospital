import React from "bower_components/react/react";
import Header from "./header"
import Footer from "./footer"

export default React.createClass({
  render() {
    return (
      <div className='container'>
        <Header />
        <Footer />
      </div>
    )
  }
});
