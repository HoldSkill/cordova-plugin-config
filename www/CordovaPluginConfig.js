var AudioPermission = {};
AudioPermission.checkAudioPermission = function(str, callback) {
    cordova.exec(callback, function(error) {
        console.log('error get permission: ', error);
    }, 'CordovaPluginConfig', 'checkAudioPermission');
}
AudioPermission.getAudioPermission = function(str, callback) {
    cordova.exec(callback, function(error) {
        console.log('error get permission: ', error);
    }, 'CordovaPluginConfig', 'getAudioPermission');
}
module.exports = AudioPermission;