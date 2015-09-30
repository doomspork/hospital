let { createStore }  = require('redux');
let dashboard        = require('../reducers/dashboard');

// Will prob want to make this return a function where store is actually created when called
module.exports = createStore(dashboard);
