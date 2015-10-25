import React, { Component } from 'react';

export default class WidgetContainer extends Component {
  render() {
    return (
      <div className="page-content-wrapper">
          /* BEGIN CONTENT BODY */
          /* BEGIN PAGE HEAD*/
          <div className="page-head">
              <div className="container">
                  /* BEGIN PAGE TITLE */
                  <div className="page-title">
                      <h1>Blank Page </h1>
                  </div>
                  /* END PAGE TITLE */
                  /* BEGIN PAGE TOOLBAR */
                  <div className="page-toolbar">
                      /* BEGIN THEME PANEL */
                      <div className="btn-group btn-theme-panel">
                          <a href="javascript:;" className="btn dropdown-toggle" data-toggle="dropdown">
                              <i className="icon-settings"></i>
                          </a>
                          <div className="dropdown-menu theme-panel pull-right dropdown-custom hold-on-click">
                              <div className="row">
                                  <div className="col-md-6 col-sm-6 col-xs-12">
                                      <h3>THEME COLORS</h3>
                                      <div className="row">
                                          <div className="col-md-6 col-sm-6 col-xs-12">
                                              <ul className="theme-colors">
                                                  <li className="theme-color theme-color-default" data-theme="default">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Default</span>
                                                  </li>
                                                  <li className="theme-color theme-color-blue-hoki" data-theme="blue-hoki">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Blue Hoki</span>
                                                  </li>
                                                  <li className="theme-color theme-color-blue-steel" data-theme="blue-steel">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Blue Steel</span>
                                                  </li>
                                                  <li className="theme-color theme-color-yellow-orange" data-theme="yellow-orange">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Orange</span>
                                                  </li>
                                                  <li className="theme-color theme-color-yellow-crusta" data-theme="yellow-crusta">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Yellow Crusta</span>
                                                  </li>
                                              </ul>
                                          </div>
                                          <div className="col-md-6 col-sm-6 col-xs-12">
                                              <ul className="theme-colors">
                                                  <li className="theme-color theme-color-green-haze" data-theme="green-haze">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Green Haze</span>
                                                  </li>
                                                  <li className="theme-color theme-color-red-sunglo" data-theme="red-sunglo">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Red Sunglo</span>
                                                  </li>
                                                  <li className="theme-color theme-color-red-intense" data-theme="red-intense">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Red Intense</span>
                                                  </li>
                                                  <li className="theme-color theme-color-purple-plum" data-theme="purple-plum">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Purple Plum</span>
                                                  </li>
                                                  <li className="theme-color theme-color-purple-studio" data-theme="purple-studio">
                                                      <span className="theme-color-view"></span>
                                                      <span className="theme-color-name">Purple Studio</span>
                                                  </li>
                                              </ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div className="col-md-6 col-sm-6 col-xs-12 seperator">
                                      <h3>LAYOUT</h3>
                                      <ul className="theme-settings">
                                          <li> Theme Style
                                              <select className="theme-setting theme-setting-style form-control input-sm input-small input-inline tooltips" data-original-title="Change theme style" data-container="body" data-placement="left">
                                                  <option value="boxed" selected="selected">Square corners</option>
                                                  <option value="rounded">Rounded corners</option>
                                              </select>
                                          </li>
                                          <li> Layout
                                              <select className="theme-setting theme-setting-layout form-control input-sm input-small input-inline tooltips" data-original-title="Change layout type" data-container="body" data-placement="left">
                                                  <option value="boxed" selected="selected">Boxed</option>
                                                  <option value="fluid">Fluid</option>
                                              </select>
                                          </li>
                                          <li> Top Menu Style
                                              <select className="theme-setting theme-setting-top-menu-style form-control input-sm input-small input-inline tooltips" data-original-title="Change top menu dropdowns style" data-container="body"
                                              data-placement="left">
                                                  <option value="dark" selected="selected">Dark</option>
                                                  <option value="light">Light</option>
                                              </select>
                                          </li>
                                          <li> Top Menu Mode
                                              <select className="theme-setting theme-setting-top-menu-mode form-control input-sm input-small input-inline tooltips" data-original-title="Enable fixed(sticky) top menu" data-container="body" data-placement="left">
                                                  <option value="fixed">Fixed</option>
                                                  <option value="not-fixed" selected="selected">Not Fixed</option>
                                              </select>
                                          </li>
                                          <li> Mega Menu Style
                                              <select className="theme-setting theme-setting-mega-menu-style form-control input-sm input-small input-inline tooltips" data-original-title="Change mega menu dropdowns style" data-container="body"
                                              data-placement="left">
                                                  <option value="dark" selected="selected">Dark</option>
                                                  <option value="light">Light</option>
                                              </select>
                                          </li>
                                          <li> Mega Menu Mode
                                              <select className="theme-setting theme-setting-mega-menu-mode form-control input-sm input-small input-inline tooltips" data-original-title="Enable fixed(sticky) mega menu" data-container="body"
                                              data-placement="left">
                                                  <option value="fixed" selected="selected">Fixed</option>
                                                  <option value="not-fixed">Not Fixed</option>
                                              </select>
                                          </li>
                                      </ul>
                                  </div>
                              </div>
                          </div>
                      </div>
                      /* END THEME PANEL */
                  </div>
                  /* END PAGE TOOLBAR */
              </div>
          </div>
          /* END PAGE HEAD*/
          /* BEGIN PAGE CONTENT BODY */
          <div className="page-content">
              <div className="container">
                  /* BEGIN PAGE BREADCRUMBS */
                  <ul className="page-breadcrumb breadcrumb">
                      <li>
                          <a href="index.html">Home</a>
                          <i className="fa fa-circle"></i>
                      </li>
                      <li>
                          <span>Layouts</span>
                      </li>
                  </ul>
                  /* END PAGE BREADCRUMBS */
                  /* BEGIN PAGE CONTENT INNER */
                  <div className="page-content-inner">
                      <div className="note note-info">
                          <p> A black page template with a minimal dependency assets to use as a base for any custom page you create </p>
                      </div>
                  </div>
                  /* END PAGE CONTENT INNER */
              </div>
          </div>
          /* END PAGE CONTENT BODY */
          /* END CONTENT BODY */
      </div>
    )
  }
};
