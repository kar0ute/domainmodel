
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const CustomerList = () => {
  const [customers, setCustomers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [editCustomer, setEditCustomer] = useState(null);

  useEffect(() => {
    fetchCustomers();
  }, []);

  const fetchCustomers = () => {
    axios.get('http://localhost:8000/index.php')
      .then(response => {
        if (response.data.records) {
          setCustomers(response.data.records);
        } else {
          setError("No customer records found.");
        }
        setLoading(false);
      })
      .catch(error => {
        setError("There was an error fetching the customers!");
        setLoading(false);
      });
  };

  const handleEdit = (customer) => {
    setEditCustomer(customer);
  };

  const handleDelete = (customerId) => {
    axios.delete(`http://localhost:8000/index.php?id=${customerId}`)
      .then(() => {
        fetchCustomers();
      })
      .catch(error => {
        setError("There was an error deleting the customer!");
      });
  };

  const handleSave = () => {
    axios.put(`http://localhost:8000/index.php`, editCustomer)
      .then(() => {
        fetchCustomers();
        setEditCustomer(null);
      })
      .catch(error => {
        setError("There was an error updating the customer!");
      });
  };

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>{error}</div>;
  }

  return (
    <div>
      <h4>Customer List</h4>
      <hr/>
      <ol>
        {customers.map(customer => (
          <li key={customer.id}>
            {editCustomer && editCustomer.id === customer.id ? (
              <div>
                <input
                  type="text"
                  value={editCustomer.name}
                  onChange={(e) => setEditCustomer({ ...editCustomer, name: e.target.value })}
                />
                <input
                  type="email"
                  value={editCustomer.email}
                  onChange={(e) => setEditCustomer({ ...editCustomer, email: e.target.value })}
                />
                <input
                  type="date"
                  value={editCustomer.order_date}
                  onChange={(e) => setEditCustomer({ ...editCustomer, order_date: e.target.value })}
                />
                <input
                  type="number"
                  value={editCustomer.amount}
                  onChange={(e) => setEditCustomer({ ...editCustomer, amount: e.target.value })}
                />
                <button onClick={handleSave}>Save</button>
                <button onClick={() => setEditCustomer(null)}>Cancel</button>
              </div>
            ) : (
              <div>
                {customer.name} - {customer.email} - {customer.order_date} - {customer.amount}€
                <button onClick={() => handleEdit(customer)}>Edit</button>
                <button onClick={() => handleDelete(customer.id)}>Delete</button>
              </div>
            )}
          </li>
        ))}
      </ol>
    </div>
  );
};

export default CustomerList;
