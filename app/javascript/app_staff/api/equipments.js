import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/equipment',
  params,
});

export const fetchTypes = (params) => request({
  endpoint: '/equipment/types',
  params,
});

export const create = (params) => request({
  endpoint: '/equipment',
  method: 'post',
  data: { equipment: params },
});

export const fetch = (id) => request({
  endpoint: `/equipment/${id}`,
});

export const update = (id, params) => request({
  endpoint: `/equipment/${id}`,
  method: 'patch',
  data: { equipment: params },
});

export default {
  fetchAll,
  fetchTypes,
  create,
  fetch,
  update,
};
