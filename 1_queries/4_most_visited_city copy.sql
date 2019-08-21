-- Most Visited Cities
-- Our product managers want a query to see a list of the most visited cities.

-- Get a list of the most visited cities.

-- Select the name of the city and the number of reservations for that city.
-- Order the results from highest number of reservations to lowest number of reservations.

select city, count(reservations) as total_reservation
from properties
join reservations
on properties.id = property_id
group by city
order by total_reservation DESC;
