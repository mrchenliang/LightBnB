INSERT INTO users (name, email, password) 
VALUES ('Stephanie Wolff', 'darius.homenick@tod.ca', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
('Elliot Dickinson', 'derrick_pollich@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
('Erna Cassin', 'miguel.barrows@yahoo.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'), ('Carmel Grant', 'marcelino_durgan@hotmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.');

INSERT INTO properties (owner_id, title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, street, parking_spaces, number_of_bathrooms, number_of_bedrooms, country, city, province, post_code, active)
VALUES (2, 'title', 'description', 'thumb', 'cover', 20, '85 fakestreet', 1, 1, 1, 'canada', 'edmonton','ab','fakepostalcode', true),
(3, 'title', 'description', 'thumb', 'cover', 20,'75 fakestreet', 1, 1, 1, 'canada', 'edmonton', 'ab', 'fakepostalcode', true),
(1, 'title', 'description', 'thumb', 'cover', 20, '95 fakestreet', 1, 1, 1, 'canada', 'edmonton', 'ab', 'fakepostalcode', true);

INSERT INTO reservations (guest_id, property_id, start_date, end_date) 
VALUES (1, 1, '2018-09-11', '2018-09-26'),
(2, 2, '2019-01-04', '2019-02-01'),
(3, 3, '2021-10-01', '2021-10-14');


INSERT INTO property_reviews (guest_id, property_id, reservation_id, rating , message)
VALUES (1, 2, 1, 5, 'great place'), (2, 1, 2, 3, 'okayplace'), (3, 3, 3, 1, 'dont stay here');




