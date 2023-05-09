 ---Music Store Data Analysis Project using SQL----
 select * from Music_Store..album
 select * from Music_Store..artist
 select * from Music_Store..customer
 select * from Music_Store..invoice
 select * from Music_Store..employee
 select * from Music_Store..genre
 select * from Music_Store..invoice_line
 select * from Music_Store..track
 select * from Music_Store..media_type
 select * from Music_Store..playlist
 select * from Music_Store..playlist_track
 


 -- Question Set 1 - Easy 
 -- Q1: Who is the senior most employee based on job title? 
 select first_name,last_name, title from Music_Store..employee
 order by levels
 
 --Q2: Which countries have the most Invoices?
 select count(*) as total_count,billing_country from Music_Store..invoice
 group by billing_country order by total_count 

 --Q3: What are top 3 values of total invoice?
 select total from Music_Store..invoice order by total
 
 --Q4:/* Which city has the best customers? We would like to throw a 
 --promotional Music Festival in the city we made the most money. 
 --Write a query that returns city that has the highest sum of invoice totals. 
 --Return both the city name & sum of all invoice totals*/

 select billing_city ,round(sum(total),0)as total from Music_Store..invoice 
  Group by billing_city order by total 

 --Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--Write a query that returns the person who has spent the most money.*/
select c.first_name,c.last_name ,sum(i.total) as total_money
from Music_Store..customer c join  Music_Store..invoice i 
on c.customer_id = i.customer_id group by c.first_name,c.last_name
order by total_money desc  


--Question Set 2 - Moderate 

--Q1: Write query to return the email, first name, last name, & 
--Genre of all Rock Music listeners. Return your list ordered 
--alphabetically by email starting with A. */

--Method 1
select c.email,c.first_name,c.last_name from  Music_Store..customer c
join Music_Store..invoice i on c.customer_id =i.customer_id
join Music_Store..invoice_line l on i.invoice_id=l.invoice_id
join Music_Store..track t on t.track_id = l.track_id
join Music_Store..genre g on g.genre_id =t.genre_id
where g.name like 'rock' 

-- Q2: Let'invite the artists who have written the most rock music in our dataset. 
--Write a query that returns the Artist name and total track count. 
select a.name,a.artist_id ,count(a.artist_id) as number_of_songs from Music_Store..artist a
join Music_Store..album al on a.artist_id = al.artist_id
join Music_Store..track t on t.album_id = al.album_id
group by a.name,a.artist_id order by number_of_songs desc

--Q3: Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

select name,milliseconds from Music_Store..track
where milliseconds >(select avg(milliseconds)as average_song_length from Music_Store..track )
order by milliseconds desc

--Q4. use to CTE  to finding to avg millisconds songe 
with eql_cte (total_song) as (select avg(milliseconds)as total_song  from Music_Store..track )
 select total_song from eql_cte
 
 

