import React from 'react';

const Header = ({ setFilter }) => {
  const handleFilterChange = (e) => {
    setFilter(e.target.value);
  };

  return (
    <header className="header">
      <h1>Todo List</h1>
      <select onChange={handleFilterChange}>
        <option value="">All</option>
        <option value="pending">Pending</option>
        <option value="completed">Completed</option>
      </select>
    </header>
  );
};

export default Header;
