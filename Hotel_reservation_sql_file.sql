create database hotel_reservation;

use hotel_reservation;

select * from Hotel_Reservation;

select COUNT(*) row_count
	from Hotel_Reservation;

select 
	SUM( case when Booking_ID is null then 1 else 0 END) null_value_booking_id,
	SUM( case when no_of_adults is null then 1 else 0 END) null_value_no_of_adults,
	SUM( case when no_of_children is null then 1 else 0 END) null_value_no_of_children,
	SUM( case when no_of_week_nights is null then 1 else 0 END) null_value_no_of_week_nights,
	SUM( case when no_of_weekend_nights is null then 1 else 0 END) null_value_no_of_weekend_nights,
	SUM( case when type_of_meal_plan is null then 1 else 0 END) null_value_type_of_meal_plan,
	SUM( case when room_type_reserved is null then 1 else 0 END) null_value_room_type_reserved,
	SUM( case when lead_time is null then 1 else 0 END) null_value_lead_time,
	SUM( case when arrival_date is null then 1 else 0 END) null_value_arrival_date,
	SUM( case when market_segment_type is null then 1 else 0 END) null_value_market_segment_type,
	SUM( case when avg_price_per_room is null then 1 else 0 END) null_value_avg_price_per_room,
	SUM( case when booking_status is null then 1 else 0 END) null_value_booking_status
from Hotel_Reservation;


--What is the total number of reservations in the dataset?

select COUNT(*) row_count
	from Hotel_Reservation;

--Which meal plan is the most popular among guests?

select type_of_meal_plan,COUNT(type_of_meal_plan) value_count_meal_plan
	 from Hotel_Reservation
     group by type_of_meal_plan
     order by value_count_meal_plan desc;

--What is the average price per room for reservations involving children?

alter table Hotel_Reservation
alter column avg_price_per_room decimal;

alter table Hotel_Reservation
alter column no_of_children int;

select AVG(avg_price_per_room) as avg_price 
from Hotel_Reservation
where no_of_children != 0;

--How many reservations were made for the year 20XX (replace XX with the desired year)?

select COUNT(*) no_of_reservations
  from Hotel_Reservation
  where SUBSTRING(arrival_date,7,4) = '2018';


-- What is the most commonly booked room type?

 select room_type_reserved, count(room_type_reserved) no_of_room_book
	from Hotel_Reservation
	group by room_type_reserved
	order by no_of_room_book desc;


--How many reservations fall on a weekend (no_of_weekend_nights > 0)?

select count(*) no_of_reservation_fall_on_weekend
	from Hotel_Reservation
	where  no_of_week_nights > 0;


--What is the highest and lowest lead time for reservations?

select MAX(lead_time) as highest_lead_time , MIN(lead_time) as lowest_lead_time
from Hotel_Reservation;


--What is the most common market segment type for reservations?

select market_segment_type, count(market_segment_type) no_of_reservations
	from Hotel_Reservation
	group by market_segment_type
	order by no_of_reservations desc;


--How many reservations have a booking status of "Confirmed"?

select COUNT(*) no_of_reservation
	from Hotel_Reservation
	where booking_status='Not_Canceled';


--What is the total number of adults and children across all reservations?

alter table Hotel_Reservation
alter column no_of_adults decimal;

alter table Hotel_Reservation
alter column no_of_children int;

select SUM(no_of_children) total_children, SUM(no_of_adults) total_adults
	from Hotel_Reservation


--What is the average number of weekend nights for reservations involving children?

alter table Hotel_Reservation
alter column no_of_weekend_nights int;

select round(AVG(no_of_weekend_nights),2) as average_no_of_weekend_night 
	from Hotel_Reservation
	where no_of_children > 0;


--How many reservations were made in each month of the year?

select SUBSTRING(arrival_date,7,4) as year_1 ,SUBSTRING(arrival_date,4,2) as month_1,count(*) as no_of_reservation
from Hotel_Reservation
group by SUBSTRING(arrival_date,7,4),SUBSTRING(arrival_date,4,2)
order by SUBSTRING(arrival_date,7,4)


--What is the average number of nights (both weekend and weekday) spent by guests for each room
--type?

alter table Hotel_Reservation
alter column no_of_weekend_nights int
alter table Hotel_Reservation
alter column no_of_week_nights int

select room_type_reserved,(AVG(no_of_weekend_nights) + AVG(no_of_week_nights)) as avergae_number_of_nights
	from Hotel_Reservation
	group by room_type_reserved;


--For reservations involving children, what is the most common room type, and what is the average
--price for that room type?


select room_type_reserved, Sum(avg_price_per_room) average_price
	from Hotel_Reservation
	where no_of_children > 0
	group by room_type_reserved
	order by average_price desc;



--Find the market segment type that generates the highest average price per room.

select market_segment_type,round(AVG(avg_price_per_room),2) average_price_per_room
	from Hotel_Reservation
	group by market_segment_type
	order by average_price_per_room desc;