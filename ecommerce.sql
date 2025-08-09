DROP TABLE IF EXISTS Return;
DROP TABLE IF EXISTS CreditCard;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Staff;

CREATE TABLE Staff (
  staff_id INT NOT NULL PRIMARY KEY,
  name CHAR(50) NOT NULL
);

CREATE TABLE Customer (
  customer_id INT NOT NULL PRIMARY KEY,
  name CHAR(50) NOT NULL
);

CREATE TABLE Product (
  product_id INT NOT NULL PRIMARY KEY,
  name CHAR(50) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  staff_id INT NOT NULL,
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

CREATE TABLE Purchase (
  purchase_id INT NOT NULL PRIMARY KEY,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  staff_id INT NOT NULL,
  purchase_date DATE NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id),
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

CREATE TABLE CreditCard (
  card_id INT NOT NULL PRIMARY KEY,
  customer_id INT NOT NULL,
  card_number CHAR(20) NOT NULL,
  expiry_date DATE NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Return (
  return_id INT NOT NULL PRIMARY KEY,
  purchase_id INT NOT NULL,
  return_date DATE NOT NULL,
  FOREIGN KEY (purchase_id) REFERENCES Purchase(purchase_id)
);




INSERT INTO Staff (staff_id, name) VALUES
(1, 'Ozzy Osbourne'),
(2, 'Jake Sweeney');

INSERT INTO Customer (customer_id, name) VALUES
(1, 'Michael Jordan'),
(2, 'Patrick Rothfuss');

-- Insert sample data into Product
INSERT INTO Product (product_id, name, price, staff_id) VALUES
(1, 'Blender', 199.99, 1),
(2, 'Phone', 699.99, 2),
(3, 'Apple', 0.99, 1);

INSERT INTO Purchase (purchase_id, customer_id, product_id, staff_id, purchase_date) VALUES
(1, 1, 1, 1, '2025-08-01'),
(2, 2, 2, 2, '2025-08-02'),
(3, 1, 3, 1, '2025-08-03');

INSERT INTO CreditCard (card_id, customer_id, card_number, expiry_date) VALUES
(1, 1, '1234-5678-9012-3456', '2027-12-31'),
(2, 2, '8675-3098-6753-0900', '2026-06-30');

INSERT INTO Return (return_id, purchase_id, return_date) VALUES
(1, 2, '2025-08-05');
