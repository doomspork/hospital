import React, { Component, PropTypes } from 'react';
import { Line } from 'react-chartjs';
import Chart from 'chart.js';
import fill from 'lodash/array/fill';
import clone from 'lodash/lang/clone';

Chart.defaults.global.responsive = true;

const chartOptions = {
  scaleShowLabels: false,
  showScale: false,
  responsive: true,
  scaleShowGridLines: false,
  animationEasing: "easeInOutQuart"
}

const MINUTES_PER_DAY = 60;
const LABEL_BLANKS = fill(Array(MINUTES_PER_DAY), '');

function transform_data(raw) {
  let data = {
    min: fill(Array(MINUTES_PER_DAY - raw.length), null),
    max: fill(Array(MINUTES_PER_DAY - raw.length), null),
    avg: fill(Array(MINUTES_PER_DAY - raw.length), null)
  };

  raw.forEach(function(value){
    data.min.push(value.min);
    data.max.push(value.max);
    data.avg.push(value.avg);
  });

  return data;
};

function chartjsData(raw) {
  const data = transform_data(raw);

  return {
    labels: LABEL_BLANKS,
    datasets: [{
        label: "Avg. Response Time",
        fillColor: "rgba(220,220,220,0.2)",
        strokeColor: "rgba(220,220,220,1)",
        pointColor: "rgba(220,220,220,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(220,220,220,1)",
        data: data.avg
      }]
  };
}

export default class HealthCheckSummary extends Component {
  render() {
    const avg = this.props.avg.toFixed(2),
          max = this.props.max.toFixed(2),
          min = this.props.min.toFixed(2),
          uptime = this.props.uptime;

    return (
      <div className="row">
        <div className="col-md-10">
          <Line data={chartjsData(this.props.minutes)} options={chartOptions} height="100"/>
        </div>
        <div className="col-md-2">
          <div className="row">
            <div className="col-md-12 col-sm-4">
              <div className="row">
                <div className="col-md-12">
                  <h4><small>Uptime</small></h4>
                </div>
                <div className="col-md-12">
                  <h4>{uptime} days</h4>
                </div>
              </div>
            </div>
            <div className="col-md-12 col-sm-4">
              <div className="row">
                <div className="col-md-12">
                  <h4><small>Average</small></h4>
                </div>
                <div className="col-md-12">
                  <h4>{avg} ms</h4>
                </div>
              </div>
            </div>
            <div className="col-md-12 col-sm-4">
              <div className="row">
                <div className="col-md-12">
                  <h4><small>Slowest</small></h4>
                </div>
                <div className="col-md-12">
                  <h4>{max} ms</h4>
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
  avg: PropTypes.number,
  max: PropTypes.number,
  min: PropTypes.number,
  minutes: PropTypes.array,
  uptime: PropTypes.number,
}
