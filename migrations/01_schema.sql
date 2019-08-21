CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE rates (
  id SERIAL PRIMARY KEY,
  start_date DATE,
  end_date DATE,
  cost_per_night INTEGER,
  property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE
);

CREATE TABLE guest_review (
  id SERIAL PRIMARY KEY,
  guest_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  reservation_id INTEGER REFERENCES reservations(id) ON DELETE CASCADE,
  rating INTEGER,
  messages VARCHAR(255)
);

CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  guest_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE,
  start_date DATE,
  end_date DATE
);

CREATE TABLE property_reviews (
  id SERIAL PRIMARY KEY,
  guest_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  reservation_id INTEGER REFERENCES reservations(id) ON DELETE CASCADE,
  property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE,
  rating INTEGER,
  messages VARCHAR(255)
);

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(255),
  description VARCHAR(255),
  thumbnail_photo_url VARCHAR(255),
  cover_photo_url VARCHAR(255),
  cost_per_night INTEGER,
  street VARCHAR(255),
  parking_spaces boolean,
  number_of_bathrooms INTEGER,
  number_of_bedrooms INTEGER,
  country VARCHAR(255),
  city VARCHAR(255),
  province VARCHAR(255),
  post_code VARCHAR(255),
  active boolean
);