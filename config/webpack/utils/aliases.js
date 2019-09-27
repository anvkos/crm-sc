const path = require('path');

const staffPath = '../../../app/javascript/app_staff/';

module.exports = {
  resolve: {
    alias: {
      staffApp: path.resolve(__dirname, staffPath),
      staffApi: path.resolve(__dirname, staffPath, 'api'),
      staffImages: path.resolve(__dirname, staffPath, 'assets/images'),
    }
  }
};
