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

export default {
  fetchAll,
  create,
};
