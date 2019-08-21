-- All My Reservations
-- When a user is logged in, they will have an option to view all of their reservations. This page will show details about a reservation and details about the property associated with the reservation.

-- Show all reservations for a user.

-- Select all columns from the reservations table, all columns from the properties table, and the average rating of the property.
-- Order the results from most recent start_date to least recent start_date.
-- These will end up being filtered by either "Upcoming Reservations" or "Past Reservations", so only get reservations where the end_date is in the past.
-- Use now()::date to get today's date.
-- This will only be for a single user, so use 1 for the user_id.
-- Limit the results to 10.

select properties.id as id, title, cost_per_night, reservations.start_date, avg(property_reviews.rating)
from properties
join reservations on properties.id = reservations.property_id
join property_reviews on properties.id = property_reviews.property_id
where reservations.end_date < now()::date and reservations.guest_id = 1
group by properties.id, reservations.start_date, cost_per_night
order by reservations.start_date
limit 10;