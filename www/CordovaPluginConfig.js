var CordovaPluginConfig = {};
CordovaPluginConfig.checkCordovaPluginConfig = function(str, callback) {
    cordova.exec(callback, function(error) {
        console.log('error get permission: ', error);
    }, 'CordovaPluginConfig', 'checkCordovaPluginConfig');
}
CordovaPluginConfig.getCordovaPluginConfig = function(str, callback) {
    cordova.exec(callback, function(error) {
        console.log('error get permission: ', error);
    }, 'CordovaPluginConfig', 'getCordovaPluginConfig');
}
module.exports = CordovaPluginConfig;