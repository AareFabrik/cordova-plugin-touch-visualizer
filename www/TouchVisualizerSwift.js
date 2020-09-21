var exec = require('cordova/exec');

exports.start = function (config, success, error) {

  config = config || {};
  config.hexRGBAColor = config.hexRGBAColor || "#77AAEECC";
  config.showsTimer = config.showsTimer || false;
  config.showsTouchRadius = config.showsTouchRadius || false;
  config.showsLog = config.showsLog || false;

  exec(success, error, 'TouchVisualizer', 'start', [config.hexRGBAColor, config.showsTimer, config.showsTouchRadius, config.showsLog]);
};

exports.stop = function (success, error) {
  exec(success, error, 'TouchVisualizer', 'stop', []);
};

exports.isEnabled = function (success, error) {
  exec(success, error, 'TouchVisualizer', 'isEnabled', [])
}