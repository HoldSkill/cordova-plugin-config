var CordovaPluginConfig = {};
CordovaPluginConfig.checkAudioPermission = function(callback) {
    cordova.exec(callback, function(error) {
        console.log('error get permission: ', error);
    }, 'CordovaPluginConfig', 'checkAudioPermission');
}
CordovaPluginConfig.getAudioPermission = function(callback) {
    cordova.exec(callback, function(error) {
        console.log('error get permission: ', error);
    }, 'CordovaPluginConfig', 'getAudioPermission');
}
module.exports = CordovaPluginConfig;