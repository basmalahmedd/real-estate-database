-- Drop existing tables (if any)
DROP TABLE IF EXISTS Sale, Viewing, Property, Client, Agent;

-- 1. Agent Table
CREATE TABLE Agent (
    agent_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    commission_percent DECIMAL(5,2) CHECK (commission_percent > 0)
);

-- 2. Client Table
CREATE TABLE Client (
    client_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    budget DECIMAL(12,2) CHECK (budget >= 0)
);

-- 3. Property Table
CREATE TABLE Property (
    property_id SERIAL PRIMARY KEY,
    address TEXT NOT NULL,
    price DECIMAL(12,2) CHECK (price > 0),
    bedrooms INT CHECK (bedrooms > 0),
    bathrooms INT CHECK (bathrooms > 0),
    status VARCHAR(20) CHECK (status IN ('Available', 'Sold')),
    agent_id INT REFERENCES Agent(agent_id)
);

-- 4. Viewing Table (Tracks property visits)
CREATE TABLE Viewing (
    viewing_id SERIAL PRIMARY KEY,
    viewing_date DATE NOT NULL,
    property_id INT REFERENCES Property(property_id),
    client_id INT REFERENCES Client(client_id)
);

-- 5. Sale Table (Records sales)
CREATE TABLE Sale (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    sale_price DECIMAL(12,2) CHECK (sale_price > 0),
    property_id INT UNIQUE REFERENCES Property(property_id),
    agent_id INT REFERENCES Agent(agent_id),
    client_id INT REFERENCES Client(client_id)
);