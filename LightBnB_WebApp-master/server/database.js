const properties = require("./json/properties.json");
const users = require("./json/users.json");
const { Pool } = require("pg");

const pool = new Pool({
  user: "vagrant",
  password: "123",
  host: "localhost",
  database: "lightbnb"
});

/// User

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function(email) {
  const queryString = `
  select * 
  from users
  where email = $1`;
  return pool.query(queryString, [email.toLowerCase()])
  .then(res => {
    return res.rows[0];
  });
};
exports.getUserWithEmail = getUserWithEmail;

/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function(id) {
  const queryString = `
  select * 
  from users
  where id = $1`;
  return pool.query(queryString, [id]).then(res => {
    return res.rows[0];
  });
};
exports.getUserWithId = getUserWithId;

/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser = function(user) {
  const queryString = `
  insert into users (name, email, password) 
  values ($1, $2, $3)
  returning *;`;
  return pool
    .query(queryString, [user.name, user.email, user.password])
    .then(res => {
      return res.rows;
    });
};

exports.addUser = addUser;

/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function(guest_id, limit = 10) {
  const queryString = `
  select properties.*, reservations.start_date, reservations.end_date
  from reservations
  join properties on properties.id = reservations.property_id
  where guest_id = $1
  limit $2`;
  return pool.query(queryString, [guest_id, limit]).then(res => {
    return res.rows;
  });
};
exports.getAllReservations = getAllReservations;

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = function(options, limit = 10) {
  // 1
  const queryParams = [];
  // 2
  let queryString = `
  select properties.*, avg(property_reviews.rating) as average_rating
  from properties
  join property_reviews on properties.id = property_id
  `;

  // 3 city
  if (options.city) {
    queryParams.push(`%${options.city}%`);
    queryString += `where city like $${queryParams.length} `;
  }
  // 4 owner_id
  if (options.owner_id) {
    queryParams.push(`${options.owner_id}`);
    queryString += queryParams.length > 0 ? `and ` : `where `;
    queryString += `owner_id = $${queryParams.length} `;
  }
  // 4 minimum_price
  if (options.minimum_price_per_night) {
    queryParams.push(`${options.minimum_price_per_night}`);
    queryString += queryParams.length > 0 ? `and ` : `where `;
    queryString += `cost_per_night >= $${queryParams.length} `;
  }
  // 5 maximum_price
  if (options.maximum_price_per_night) {
    queryParams.push(`${options.maximum_price_per_night}`);
    queryString += queryParams.length > 0 ? `and ` : `where `;
    queryString += `cost_per_night <= $${queryParams.length} `;
  }

  queryString += `
  group by properties.id
  `;
  // 6 minimum_rating
  if (options.minimum_rating) {
    queryParams.push(`${options.minimum_rating}`);
    queryString += `having avg(property_reviews.rating) >= $${
      queryParams.length
    } `;
  }

  queryParams.push(limit);
  queryString += `
  order by cost_per_night
  limit $${queryParams.length};
  `;

  console.log(queryString, queryParams);

  return pool.query(queryString, queryParams).then(res => res.rows);
};

exports.getAllProperties = getAllProperties;

/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function(property) {
  const queryString = `
  insert into properties(owner_id, title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, street, city, province, post_code, country, parking_spaces, number_of_bathrooms, number_of_bedrooms)
  values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
  returning *;`;
  return pool
    .query(queryString, [
      property.owner_id,
      property.title,
      property.description,
      property.thumbnail_photo_url,
      property.cover_photo_url,
      property.cost_per_night,
      property.street,
      property.city,
      property.province,
      property.post_code,
      property.country,
      property.parking_spaces,
      property.number_of_bathrooms,
      property.number_of_bedrooms
    ])
    .then(res => {
      return res.rows;
    });
};

exports.addProperty = addProperty;
