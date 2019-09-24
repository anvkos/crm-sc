import axios from 'axios';
import config from './config';

const transformFromApi = (data) => {
  if (!data) {
    return data;
  }
  if (Array.isArray(data) === true) {
    return data.map(item => transformApiItem(item));
  }
  return transformApiItem(data);
}

const transformApiItem = (data) => ({id: data.id, modelType: data.type, ...data.attributes })

export default function request({
  method,
  endpoint,
  params,
  data,
  headers = {},
}) {
  if (!config.API_URL) {
    throw new Error('You forgot about API_URL!');
  }
  const url = `${config.API_URL}${endpoint}`;
  return axios
    .request({
      method: method || 'get',
      url,
      params,
      data,
      timeout: 5000,
      headers: { ...config.headers, ...headers },
    })
    .then(response => transformFromApi(response.data.data));
}
