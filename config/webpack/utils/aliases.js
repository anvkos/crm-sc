const path = require('path');

const staffPath = '../../../app/javascript/app_staff/';

module.exports = {
  resolve: {
    alias: {
      staffImages: path.resolve(__dirname, staffPath, 'assets/images'),
      staffApi: path.resolve(__dirname, staffPath, 'api'),
    }
  }
};
