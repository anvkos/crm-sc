import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/organizations',
  params,
});

export const create = (params) => request({
  endpoint: '/organizations',
  method: 'post',
  data: { organization: params },
});

export default {
  fetchAll,
  create,
};
