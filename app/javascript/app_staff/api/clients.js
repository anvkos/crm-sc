import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/clients',
  params,
});

export const create = (params) => request({
  endpoint: '/clients',
  method: 'post',
  data: { client: params },
});

export const verifyUniqueness = (params) => request({
  endpoint: '/clients/verify_uniqueness',
  method: 'post',
  data: { client: params },
});

export const fetch = (id) => request({
  endpoint: `/clients/${id}`,
});

export const update = (id, params) => request({
  endpoint: `/clients/${id}`,
  method: 'patch',
  data: { client: params },
});

export const fetchOrganizations = (id, params) => request({
  endpoint: `/clients/${id}/organizations`,
  params: params,
});

export const addOrganization = (id, params) => request({
  endpoint: `/clients/${id}/organizations`,
  method: 'post',
  data: { client: params },
});

export default {
  fetchAll,
  create,
  fetch,
  update,
  verifyUniqueness,
  fetchOrganizations,
  addOrganization,
};
