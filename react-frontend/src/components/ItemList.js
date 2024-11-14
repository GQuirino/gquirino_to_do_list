import React, { useState } from 'react';
import Item from './Item';
import Button from 'react-bootstrap/Button';
import { MdOutlineCreateNewFolder } from "react-icons/md";

const ItemList = ({ items, loadItems}) => {
  const [isNewItem, setIsNewItem] = useState(false);

  return (
    <div className="item-list">
      <Button variant="link" className="icon-button" style={{marginLeft: 'auto'}}>
        <MdOutlineCreateNewFolder size={30} onClick={ () => { setIsNewItem(!isNewItem)} }/>
      </Button>
      <div id='new-item-form'>
        { (isNewItem)?(
          <div>
            <Item
              key={''}
              loadItems={loadItems}
              itemStatus={'new'}
              isNewItem={setIsNewItem}
            />
          </div>
          ):''}
      </div>
      {items.map(item => (
        <Item
          key={item.id}
          itemId={item.id}
          itemStatus={item.status}
          itemTitle={item.title}
          loadItems={loadItems} 
        />
      ))}
    </div>
  );
};

export default ItemList;
