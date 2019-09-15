import request from './request';

export const fetchUser = () => request({
  endpoint: '/user',
});

export const signOut = () => request({
  endpoint: '/sign_out',
});

export default fetchUser;
