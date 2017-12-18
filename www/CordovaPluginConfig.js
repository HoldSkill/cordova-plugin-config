var exec = require('cordova/exec');
var CordovaPluginConfig = {};
CordovaPluginConfig.LongPressFix = function(callback) {
    console.log('CordovaPluginConfig.LongPressFix');
    exec(callback, CordovaPluginConfig._AudioPermissionErrorEvent, 'CordovaPluginConfig', 'LongPressFix', []);
};
CordovaPluginConfig.checkAudioPermission = function(callback) {
    console.log('CordovaPluginConfig.checkAudioPermission');
    exec(callback, CordovaPluginConfig._AudioPermissionErrorEvent, 'CordovaPluginConfig', 'checkAudioPermission', []);
};
CordovaPluginConfig.getAudioPermission = function(callback) {
    console.log('CordovaPluginConfig.getAudioPermission');
    exec(callback, CordovaPluginConfig._AudioPermissionErrorEvent, 'CordovaPluginConfig', 'getAudioPermission', []);
};
CordovaPluginConfig._AudioPermissionErrorEvent = function(e) {
    cordova.fireWindowEvent("AudioPermissionRrror", {
        message: e
    });
};
module.exports = CordovaPluginConfig;