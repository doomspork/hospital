import React, { Component, PropTypes } from 'react';
import { Line } from 'react-chartjs'
import Chart from 'chart.js'

Chart.defaults.global.responsive = true;

const chartOptions = {
  scaleShowLabels: false,
  showScale: false,
  responsive: true,
  scaleShowGridLines: false,
  animationEasing: "easeInOutQuart"
}

function chartjsData(raw) {
  return {
    labels: ['Italy', 'UK', 'USA', 'Germany', 'France', 'Japan'],
    datasets: [
      {
        label: "Response Time",
        fillColor: "rgba(220,220,220,0.2)",
        strokeColor: "rgba(220,220,220,1)",
        pointColor: "rgba(220,220,220,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(220,220,220,1)",
        data: [2500, 1902, 1041, 610, 1245, 952]
      }
    ]
  };
}

export default class HealthCheckSummary extends Component {
  render() {
    return (
      <div className="row">
        <div className="col-md-10">
          <Line data={chartjsData()} options={chartOptions} height="100"/>
        </div>
        <div className="col-md-2">
          <div className="row">
            <div className="col-md-12 col-sm-4">
              <div className="row">
                <div className="col-md-12">
                  <h4><small>Uptime</small></h4>
                </div>
                <div className="col-md-12">
                  <h4>{this.props.uptime} days</h4>
                </div>
              </div>
            </div>
            <div className="col-md-12 col-sm-4">
              <div className="row">
                <div className="col-md-12">
                  <h4><small>Average</small></h4>
                </div>
                <div className="col-md-12">
                  <h4>{this.props.average} ms</h4>
                </div>
              </div>
            </div>
            <div className="col-md-12 col-sm-4">
              <div className="row">
                <div className="col-md-12">
                  <h4><small>Slowest</small></h4>
                </div>
                <div className="col-md-12">
                  <h4>{this.props.slowest} ms</h4>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
};

HealthCheckSummary.propTypes = {
  uptime: PropTypes.number,
  average: PropTypes.number,
  slowest: PropTypes.number,
  timeline: PropTypes.array
}
