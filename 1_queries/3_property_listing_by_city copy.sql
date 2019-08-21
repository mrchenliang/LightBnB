-- Property Listings By City

-- When the users come to our home page, they are going to see a list of properties. They will be able to view the properties and filter them by location. They will be able to see all data about the property, including the average rating.

-- Show all details about properties located in Vancouver including their average rating.

-- Select all columns from the properties table for properties located in Vancouver, and the average rating for each property.
-- Order the results from lowest cost_per_night to highest cost_per_night.
-- Limit the number of results to 10.
-- Only show listings that have a rating >= 4 stars.
-- To build this incrementally, you can start by getting all properties without the average rating first.

select properties.id, title, cost_per_night, avg(rating) as average_rating
from properties
join property_reviews
on properties.id = property_id
where city like '%Vancouver%'
group by properties.id
having avg(rating) >= 4
order by cost_per_night
limit 10;
