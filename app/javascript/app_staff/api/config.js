const token = document.head.querySelector('meta[name="csrf-token"]')

export default {
  API_URL: '/staffs',
  headers: {
    'Accept': 'application/json',
    'X-CSRF-TOKEN': token.content,
  }
};
