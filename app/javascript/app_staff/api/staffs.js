import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/staffs',
  params,
});

export default {
  fetchAll,
};
