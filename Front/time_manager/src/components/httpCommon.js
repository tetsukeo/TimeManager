import axios from 'axios';

export const HTTP = axios.create({
  baseURL: `http://127.0.0.1:4000/api/`,
  headers: {
    Authorization: 'Bearer {localStorage.token}'
  }
})