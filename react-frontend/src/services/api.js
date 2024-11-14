import axios from 'axios';
const API_URL = `${process.env.REACT_APP_API_URL}/todos`;

export const fetchItems = async ({ filterBy, itemId }) => {
  const query = (filterBy) ? `?filter_by=${filterBy}` : ''
  const item = (itemId) ? `/${itemId}` : ''
  const url = [
                API_URL,
                item,
                query
              ].join('')
  const response = await axios.get(url);
  return response.data;
};

export const updateItem = async (id, data) => {
  const response = await axios.put(`${API_URL}/${id}`, data);
  return response.data;
};

export const addItem = async (data) => {
  const response = await axios.post(API_URL, data);
  return response.data;
};

export const deleteItem = async (id) => {
  await axios.delete(`${API_URL}/${id}`);
};

export const completeItem = async (id) => {
  const response = await axios.patch(`${API_URL}/${id}/complete`);
  return response.data;
};
