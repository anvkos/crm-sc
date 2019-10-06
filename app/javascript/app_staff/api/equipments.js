import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/equipment',
  params,
});

export const create = (params) => request({
  endpoint: '/equipment',
  method: 'post',
  data: { equipment: params },
});

export const fetchTypes = (params) => request({
  endpoint: '/equipment/types',
  params,
});

export default {
  fetchAll,
  fetchTypes,
  create,
};
