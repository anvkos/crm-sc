import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/organizations',
  params,
});

export default {
  fetchAll,
};
