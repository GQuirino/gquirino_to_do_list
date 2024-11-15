import axios from 'axios';
import { FETCH_ALL_TODO_QUERY, FETCH_TODO_QUERY }from './graphql/todo_queries'
const HOST = process.env.REACT_APP_API_HOST;
const API_URL = `${process.env.REACT_APP_API_HOST}/api/v1`;
const TODO_RESOURCE = '/todos'

export const fetchItems = async ({ filterBy, itemId }) => {
  const response = await axios.post(`${HOST}/graphql`, { query: (itemId) ? FETCH_TODO_QUERY(itemId) : FETCH_ALL_TODO_QUERY(filterBy) });
  const response_data = response.data.data
  return (itemId) ? response_data.todo : response_data.todos
};

export const updateItem = async (id, data) => {
  const response = await axios.put(`${API_URL}/${TODO_RESOURCE}/${id}`, data);
  return response.data.to_do;
};

export const addItem = async (data) => {
  const response = await axios.post(`${API_URL}/${TODO_RESOURCE}`, data);
  return response.data.to_do;
};

export const deleteItem = async (id) => {
  await axios.delete(`${API_URL}/${TODO_RESOURCE}/${id}`);
};

export const completeItem = async (id) => {
  const response = await axios.patch(`${API_URL}/${TODO_RESOURCE}/${id}/complete`);
  return response.data.to_do;
};
