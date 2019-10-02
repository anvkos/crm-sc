import request from './request';

export const fetchAll = (params) => request({
  endpoint: '/staffs',
  params,
});

export const create = (params) => request({
  endpoint: '/staffs',
  method: 'post',
  data: { staff: params },
});

export const fetch = (id) => request({
  endpoint: `/staffs/${id}`,
});

export const update = (id, params) => request({
  endpoint: `/staffs/${id}`,
  method: 'patch',
  data: { staff: params },
});

export default {
  fetchAll,
  create,
  fetch,
  update,
};
