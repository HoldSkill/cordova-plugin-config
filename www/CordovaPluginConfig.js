var exec = require('cordova/exec');
module.exports = {
    LongPressFix: function(callback) {
        console.log('CordovaPluginConfig.LongPressFix');
        exec(callback, this._AudioPermissionErrorEvent, 'CordovaPluginConfig', 'LongPressFix', []);
    },
    checkAudioPermission: function(callback) {
        console.log('CordovaPluginConfig.checkAudioPermission');
        exec(callback, this._AudioPermissionErrorEvent, 'CordovaPluginConfig', 'checkAudioPermission', []);
    },
    getAudioPermission: function(callback) {
        console.log('CordovaPluginConfig.getAudioPermission');
        exec(callback, this._AudioPermissionErrorEvent, 'CordovaPluginConfig', 'getAudioPermission', []);
    },
    _AudioPermissionErrorEvent = function(e) {
        cordova.fireWindowEvent("AudioPermissionRrror", {
            message: e
        });
    }
};