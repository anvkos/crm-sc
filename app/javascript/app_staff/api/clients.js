import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/clients',
  params,
});

export const create = (params) => request({
  endpoint: '/clients',
  method: 'post',
  data: params,
});

export const verifyUniqueness = (params) => request({
  endpoint: '/clients/verify_uniqueness',
  method: 'post',
  data: params,
});

export default {
  fetchAll,
  create,
  verifyUniqueness,
};
