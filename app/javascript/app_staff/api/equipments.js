import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/equipment',
  params,
});

export default {
  fetchAll,
};
