import React, { Component, PropTypes } from 'react';
import { Line } from 'react-chartjs';
import Chart from 'chart.js';
import { clone, fill } from 'lodash';

Chart.defaults.global.responsive = true;

const chartOptions = {
  animationEasing: "easeInOutQuart",
  maintainAspectRatio: false,
  responsive: true,
  responsive: true,
  scaleShowGridLines: false,
  scaleShowLabels: false,
  showScale: false,
  pointDot: false,
  showTooltips: false
}

// Counts the initial minute and the last, so 61
const MINUTES_PER_HOUR = 61;
const LABEL_BLANKS = fill(Array(MINUTES_PER_HOUR), null);

function chartjsData(data) {
  return {
    labels: LABEL_BLANKS,
    datasets: [{
        label: "Avg. Response Time",
        fillColor: "rgba(220,220,220,0.0)",
        strokeColor: "rgb(235, 61, 63)",
        pointColor: "rgba(220,220,220,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(220,220,220,1)",
        data: data.avg
      }]
  };
}

function displayValue(value) {
  if(value == null) {
    return '-';
  } else {
    let rounded = value.toFixed(2)
    return rounded + " ms";
  }
}

export default class HealthCheckSummary extends Component {
  render() {
    const avg = displayValue(this.props.avg),
          max = displayValue(this.props.max),
          min = displayValue(this.props.min),
          uptime = this.props.uptime

    return (
      <div className="row">
        <div>
          <div className="row">
            <div className="col-md-3">
              <div className="row">
                <div className="col-md-12 text-center text-uppercase">
                  Uptime
                </div>
                <div className="col-md-12 text-center">
                  <h4>{uptime} days</h4>
                </div>
              </div>
            </div>
            <div className="col-md-3">
              <div className="row">
                <div className="col-md-12 text-center text-uppercase">
                  Slowest
                </div>
                <div className="col-md-12 text-center">
                  <h4>{max}</h4>
                </div>
              </div>
            </div>
            <div className="col-md-3">
              <div className="row">
                <div className="col-md-12 text-center text-uppercase">
                  Average
                </div>
                <div className="col-md-12 text-center">
                  <h4>{avg}</h4>
                </div>
              </div>
            </div>
            <div className="col-md-3">
              <div className="row">
                <div className="col-md-12 text-center text-uppercase">
                  Fastest
                </div>
                <div className="col-md-12 text-center">
                  <h4>{min}</h4>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="chart-container">
          <Line data={chartjsData(this.props.series)} options={chartOptions}/>
        </div>
      </div>
    )
  }
};

HealthCheckSummary.propTypes = {
  avg: PropTypes.number,
  max: PropTypes.number,
  min: PropTypes.number,
  series: PropTypes.object.isRequired,
  uptime: PropTypes.number
}
