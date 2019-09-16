import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/clients',
  params,
});

export default {
  fetchAll,
};
