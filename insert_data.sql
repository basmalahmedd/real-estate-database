-- Insert Agents
INSERT INTO Agent (name, phone, email, commission_percent)
VALUES 
  ('John Doe', '555-1234', 'john@example.com', 2.5),
  ('Jane Smith', '555-5678', 'jane@example.com', 3.0);

-- Insert Clients
INSERT INTO Client (name, phone, email, budget)
VALUES 
  ('Alice Brown', '555-1111', 'alice@example.com', 500000),
  ('Bob Green', '555-2222', 'bob@example.com', 750000);

-- Insert Properties
INSERT INTO Property (address, price, bedrooms, bathrooms, status, agent_id)
VALUES 
  ('123 Main St', 250000, 3, 2, 'Available', 1),
  ('456 Oak Ave', 300000, 4, 3, 'Sold', 2);

-- Insert Viewings
INSERT INTO Viewing (viewing_date, property_id, client_id)
VALUES 
  ('2023-10-15', 1, 1),
  ('2023-10-16', 2, 2);

-- Insert Sales
INSERT INTO Sale (sale_date, sale_price, property_id, agent_id, client_id)
VALUES 
  ('2023-10-20', 300000, 2, 2, 2);