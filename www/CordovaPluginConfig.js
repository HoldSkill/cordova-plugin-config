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
        exec(callback, this.AudioPermissionErrorEvent, 'CordovaPluginConfig', 'getAudioPermission', []);
    },
    AudioPermissionErrorEvent: function(e) {
        console.log(e);
        cordova.fireWindowEvent("AudioPermissionError", {
            message: e
        });
    }
};