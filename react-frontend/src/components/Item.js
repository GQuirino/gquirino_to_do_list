import React, { useEffect, useState } from 'react';
import { updateItem, fetchItems, completeItem, deleteItem, addItem } from '../services/api';
import Card from 'react-bootstrap/Card';
import FloatingLabel from 'react-bootstrap/FloatingLabel';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import { CiEdit } from 'react-icons/ci'; 
import { LuCheckSquare } from "react-icons/lu";
import { IoSaveOutline } from "react-icons/io5";
import { MdDeleteOutline } from "react-icons/md";

const Item = ({ itemTitle, itemStatus, itemId, loadItems, isNewItem }) => {
  const [item, setItem] = useState(null);
  const [title, setTitle] = useState(itemTitle); 
  const [status, setStatus] = useState(itemStatus);
  const [description, setDescription] = useState('');
  const [validated, setValidated] = useState(false);

  const isStatusCompleted = () => status === "completed"
  const isStatusPending = () => status === "pending"
  const isStatusNew = () => status === "new"

  const [isEditing, setIsEditing] = useState(isStatusNew());

  
  const handleUpdate = async () => {
    const data = await updateItem(item.id, { title, description });
    setItem(data);
    setTitle(data.title);
    setDescription(data.description);
    setIsEditing(false);
  };

  const handleCreate = async () => {
    const data = await addItem({ title: title, description: description, status: 'pending' });
    setItem(data);
    setTitle(data.title);
    setDescription(data.description);
    setStatus(data.status)
    setIsEditing(false);
  };

  const handleSubmit = async (event) => {
    const form = event.currentTarget;
    if (form.checkValidity() === false) {
      event.preventDefault();
      event.stopPropagation();
    }else{
      isStatusNew() ? await handleCreate() : await handleUpdate()
    }
    
    setValidated(true);
  };

  const fetchItem = async () => {
    let id = itemId || (item && item.id)
    if (id) {
      const data = await fetchItems({itemId: id});
      setItem(data);
      setTitle(data.title);
      setDescription(data.description);
      setStatus(data.status);
    }
  };

  useEffect(() => {
    if(isEditing){
      fetchItem();
    }
  }, [isEditing]);


  const checkItem = async () => {
    let id = itemId || (item && item.id)
    if (id) {
      await completeItem(id)
    }
    await fetchItem();
    setIsEditing(false);
  }

  const handleDelete = async () => {
    let id = itemId || (item && item.id)
    const confirmDelete = window.confirm(`Are you sure you want to delete this item?`);
    if (confirmDelete && id) {
      await deleteItem(id);
      await loadItems();
      setIsEditing(false);
    }
  }

  const handleCancel = async () => {
    setIsEditing(false);
    isNewItem(false);
  }
  
  const headerTitle = () => {
    let title = (item) ? item.title : itemTitle
    if (isStatusCompleted()){
      return <strike>{title}</strike>
    } else {
      return title
    }
  }

  return (
    <Card className={`item ${status}`}>
      {
        ((title && status) || isStatusNew()) ? (
          <Card.Body>
            <div className="item-header">
              <h3>
                { headerTitle() }
              </h3>
                { (isStatusPending())?(
                  <div style={{display: 'flex'}}>
                    <Button variant="link" className="icon-button" onClick={ () => { setIsEditing(!isEditing)} }>
                      <CiEdit size={24} />
                    </Button>
                    <Button variant="link" className="icon-button" onClick={checkItem}>
                      <LuCheckSquare size={24}/>
                    </Button>
                  </div>
                ):''}
            </div>
            { isEditing && (
              <Form noValidate validated={validated} onSubmit={handleSubmit}>
                <FloatingLabel controlId="title" label="Title" className="mb-3">
                  <Form.Control type="text" value={title} onChange={(e) => setTitle(e.target.value)}  required/>
                </FloatingLabel>

                <FloatingLabel controlId="description" label="Description" className="mb-3">
                  <Form.Control as="textarea" value={description} onChange={(e) => setDescription(e.target.value)}  required/>
                </FloatingLabel>

                <div className="buttons-container">
                  <Button variant="link" className="icon-button" type="submit">
                    <IoSaveOutline size={24} />
                  </Button>
                  <Button variant="link" className="icon-button" onClick={isStatusNew() ? handleCancel : handleDelete}>
                    <MdDeleteOutline size={24}/>
                  </Button>
                </div>
              </Form>
            ) }
          </Card.Body>
        ) : (
          <div className="item-header" onClick={ () => { setIsEditing(!isEditing)} }>
            <h3>Loading Item</h3>
          </div>
        )
      }
    </Card>
  );
};

export default Item;
