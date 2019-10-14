import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/organizations',
  params,
});

export const fetch = (id) => request({
  endpoint: `/organizations/${id}`,
});

export const create = (params) => request({
  endpoint: '/organizations',
  method: 'post',
  data: { organization: params },
});

export const update = (id, params) => request({
  endpoint: `/organizations/${id}`,
  method: 'patch',
  data: { organization: params },
});

export const destroy = (id) => request({
  endpoint: `/organizations/${id}`,
  method: 'delete',
});

export const fetchClients = (id, params) => request({
  endpoint: `/organizations/${id}/clients`,
  params: params,
});

export const addClient = (id, params) => request({
  endpoint: `/organizations/${id}/clients`,
  method: 'post',
  data: { organization: params },
});

export default {
  fetchAll,
  fetch,
  create,
  update,
  destroy,
  fetchClients,
  addClient,
};
