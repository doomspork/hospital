webpackHotUpdate(0,{

/***/ 270:
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ('value' in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

	var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; desc = parent = getter = undefined; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; continue _function; } } else if ('value' in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError('Cannot call a class as a function'); } }

	function _inherits(subClass, superClass) { if (typeof superClass !== 'function' && superClass !== null) { throw new TypeError('Super expression must either be null or a function, not ' + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

	var _react = __webpack_require__(2);

	var _react2 = _interopRequireDefault(_react);

	var _reactRedux = __webpack_require__(159);

	var _componentsHeader = __webpack_require__(271);

	var _componentsHeader2 = _interopRequireDefault(_componentsHeader);

	var _componentsWidgetContainer = __webpack_require__(272);

	var _componentsWidgetContainer2 = _interopRequireDefault(_componentsWidgetContainer);

	var _componentsSidebar = __webpack_require__(273);

	var _componentsSidebar2 = _interopRequireDefault(_componentsSidebar);

	var _componentsPreFooter = __webpack_require__(274);

	var _componentsPreFooter2 = _interopRequireDefault(_componentsPreFooter);

	var _componentsFooter = __webpack_require__(269);

	var _componentsFooter2 = _interopRequireDefault(_componentsFooter);

	var _componentsHealthChecks = __webpack_require__(275);

	var _componentsHealthChecks2 = _interopRequireDefault(_componentsHealthChecks);

	var _actionsHealthChecks = __webpack_require__(311);

	var Dashboard = (function (_Component) {
	  _inherits(Dashboard, _Component);

	  function Dashboard() {
	    _classCallCheck(this, Dashboard);

	    _get(Object.getPrototypeOf(Dashboard.prototype), 'constructor', this).apply(this, arguments);
	  }

	  _createClass(Dashboard, [{
	    key: 'componentDidMount',
	    value: function componentDidMount() {
	      var dispatch = this.props.dispatch;

	      dispatch((0, _actionsHealthChecks.fetchHealthChecks)());
	    }
	  }, {
	    key: 'render',
	    value: function render() {
	      _react2['default'].createElement('div', null);
	    }
	  }]);

	  return Dashboard;
	})(_react.Component);

	;

	Dashboard.propTypes = {
	  checksById: _react.PropTypes.object,
	  csrf: _react.PropTypes.string
	};

	var mapStateToProps = function mapStateToProps(state) {
	  return {
	    checksById: state.healthChecks.checksById,
	    csrf: state.csrfToken
	  };
	};

	module.exports = (0, _reactRedux.connect)(mapStateToProps)(Dashboard);

/***/ }

})