var exec = require('cordova/exec');
module.exports = {
    LongPressFix: function(callback) {
        console.log('CordovaPluginConfig.LongPressFix');
        exec(callback, this.AudioPermissionErrorEvent, 'CordovaPluginConfig', 'LongPressFix', []);
    },
    checkAudioPermission: function(callback) {
        console.log('CordovaPluginConfig.checkAudioPermission');
        exec(callback, this.AudioPermissionErrorEvent, 'CordovaPluginConfig', 'checkAudioPermission', []);
    },
    getAudioPermission: function(callback) {
        console.log('CordovaPluginConfig.getAudioPermission');
        this.callback = callback;
        exec(null, this.AudioPermissionErrorEvent, 'CordovaPluginConfig', 'getAudioPermission', []);
    },
    getAudioPermissionStatus(status) {
        this.callback(status);
    },
    AudioPermissionErrorEvent: function(e) {
        cordova.fireWindowEvent("AudioPermissionError", {
            message: e
        });
    }
};