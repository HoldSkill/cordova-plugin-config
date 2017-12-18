var CordovaPluginConfig = {};
CordovaPluginConfig.checkAudioPermission = function(str, callback) {
    cordova.exec(callback, function(error) {
        console.log('error get permission: ', error);
    }, 'CordovaPluginConfig', 'checkAudioPermission');
}
CordovaPluginConfig.getAudioPermission = function(str, callback) {
    cordova.exec(callback, function(error) {
        console.log('error get permission: ', error);
    }, 'CordovaPluginConfig', 'getAudioPermission');
}
module.exports = CordovaPluginConfig;