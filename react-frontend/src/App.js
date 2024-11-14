import React, { useEffect, useState } from 'react';
import { fetchItems } from './services/api';
import Header from './components/Header';
import ItemList from './components/ItemList';
import './App.css';

function App() {
  const [items, setItems] = useState([]);
  const [filter, setFilter] = useState('');

  useEffect(() => {
    loadItems({ filterBy: filter });
  }, [filter]);

  const loadItems = async (options={}) => {
    const data = await fetchItems(options);
    setItems(data);
  };


  return (
    <div className="App">
      <Header setFilter={setFilter} setItems={setItems}/>
      <ItemList items={items} loadItems={loadItems} />
    </div>
  );
}

export default App;
