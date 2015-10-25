import React, { Component } from 'react';

export default class Sidebar extends Component {
  render() {
    return (
      /* TODO: Implement resposive sidebar toggler
      <a href="javascript:;" className="page-quick-sidebar-toggler">
          <i className="icon-login"></i>
      </a>
      */
      <div className="page-quick-sidebar-wrapper" data-close-on-body-click="false">
          <div className="page-quick-sidebar">
              <ul className="nav nav-tabs">
                  <li className="active">
                      <a href="javascript:;" data-target="#quick_sidebar_tab_1" data-toggle="tab"> Users
                          <span className="badge badge-danger">2</span>
                      </a>
                  </li>
                  <li>
                      <a href="javascript:;" data-target="#quick_sidebar_tab_2" data-toggle="tab"> Alerts
                          <span className="badge badge-success">7</span>
                      </a>
                  </li>
                  <li className="dropdown">
                      <a href="javascript:;" className="dropdown-toggle" data-toggle="dropdown"> More
                          <i className="fa fa-angle-down"></i>
                      </a>
                      <ul className="dropdown-menu pull-right">
                          <li>
                              <a href="javascript:;" data-target="#quick_sidebar_tab_3" data-toggle="tab">
                                  <i className="icon-bell"></i> Alerts </a>
                          </li>
                          <li>
                              <a href="javascript:;" data-target="#quick_sidebar_tab_3" data-toggle="tab">
                                  <i className="icon-info"></i> Notifications </a>
                          </li>
                          <li>
                              <a href="javascript:;" data-target="#quick_sidebar_tab_3" data-toggle="tab">
                                  <i className="icon-speech"></i> Activities </a>
                          </li>
                          <li className="divider"></li>
                          <li>
                              <a href="javascript:;" data-target="#quick_sidebar_tab_3" data-toggle="tab">
                                  <i className="icon-settings"></i> Settings </a>
                          </li>
                      </ul>
                  </li>
              </ul>
          </div>
      </div>
    )
  }
};
