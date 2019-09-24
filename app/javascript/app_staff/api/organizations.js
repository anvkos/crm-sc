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

export const destroy = (id) => request({
  endpoint: `/organizations/${id}`,
  method: 'delete',
})

export default {
  fetchAll,
  create,
  destroy,
};
