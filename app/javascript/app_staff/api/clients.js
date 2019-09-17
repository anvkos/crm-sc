import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/clients',
  params,
});

export const create = (params) => request({
  endpoint: '/clients',
  method: 'post',
  params,
});

export default {
  fetchAll,
  create,
};
