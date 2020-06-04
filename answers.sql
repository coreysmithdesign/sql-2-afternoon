--PRACTICE JOINS

--1
select *
from invoice
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
where invoice_line.unit_price > 0.99;

--2
select i.invoice_date, c.first_name, c.last_name, i.total
from invoice i
join customer c on i.customer_id = c.customer_id;

--3
select c.first_name, c.last_name, e.first_name, e.last_name
from employee e
join customer c on c.support_rep_id = e.employee_id;

--4
select a.title, ar.name
from album a
join artist ar on a.artist_id = ar.artist_id

--5
select pt.track_id
from playlist_track pt
join playlist pl on pl.playlist_id = pt.playlist_id
where pl.name = 'Music';

--6
select t.name
from track t
join playlist_track pt on pt.track_id = t.track_id
where pt.playlist_id = 5;

--7
select t.name, p.name
from playlist_track pl
join playlist p on pl.playlist_id = p.playlist_id
join track t on pl.track_id = t.track_id

--8
select t.name, a.title
from track t
join album a on t.album_id = a.album_id
join genre g on t.genre_id = g.genre_id
where g.name = 'Alternative & Punk';

-- PRACTICE NESTED QUERIES

--1
select *
from invoice
where invoice_id in (
	select invoice_id
  from invoice_line
  where unit_price > 0.99
);

--2
select *
from playlist_track
where playlist_id in (
	select playlist_id
  from playlist
  where name = 'Music'
);

--3
select name
from track
where track_id in (
	select track_id
  from playlist_track
  where playlist_id = 5
);

--4
select *
from track
where genre_id in (
	select genre_id
  from genre
  where name = 'Comedy'
);

--5
select *
from track
where album_id in (
	select album_id
  from album
  where name = 'Fireball'
);

--6
select *
from track
where album_id in (
	select album_id
  from album
  where artist_id in (
  	select artist_id
    from artist
    where name = 'Queen'
  )
);

-- PRACTICE UPDATING ROWS

--1
update customer
set fax = null
where fax is not null;

--2
update customer
set company = 'Self'
where company is null;

--3
update customer
set last_name = 'Thompson'
where first_name = 'Julia'
and last_name = 'Barnett';

--4
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

--5
update track
set composer = 'The darkness around us'
where genre_id = (
	select genre_id
  from genre
  where name = 'Metal'
)
and composer is null;

-- GROUP BY

--1
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

--2
select count(*), g.name
from track t
join genre g on g.genre_id = t.genre_id
where g.name = 'Pop' or g.name = 'Rock'
group by g.name;

--3
select ar.name,
count(*)
from album al
join artist ar on ar.artist_id = al.artist_id
group by ar.name;

-- DISTINCT

--1
select distinct composer
from track;

--2
select distinct billing_postal_code
from invoice;

--3
select distinct company
from customer;

-- DELETE

--1
delete from practice_delete
where type = 'bronze';

--2
delete from practice_delete
where type = 'silver';

--3
delete from practice_delete
where value = 150;

-- ECOMMERCE SIM

-- create tables
create table users (
	user_id serial primary key,
  name varchar(50),
  email varchar(50)
);
create table products (
	product_id serial primary key,
  name varchar(100),
  price integer
);
create table orders (
	order_id serial primary key,
  product_id integer references products(product_id)
)


-- add users
insert into users (
	email, name
) values
('Mr Roger Rabbit', 'rr@toontown.com'),
('Mr T', 'mrt@hotmail.com'),
('Jones Jacob', 'jj@me.com'),
('Some barking dog', 'wontzipit@woof.org');
-- add product
insert into products (
	price, name
) values
(200, 'iPhoen'),
(600, 'Antroid'),
(100, 'LT'),
(1000, 'SamSong');

-- add orders
insert into orders (
	product_id
) values
(1),
(2),
(3),
(3);

-- get products for firstorder
select *
from products p
join orders o on o.product_id = p.product_id
where order_id = 1;

-- get all orders
select * from orders;

-- get order id 3
select sum(price)
from orders o
join products p on o.product_id = p.product_id
where o.order_id = 3;

-- add foreign key to users from orders
alter table orders
add column user_id integer references users(user_id);

-- add data to user_id in orders user_id
update orders
set user_id = 4
where order_id = 4;
select * from orders;

-- get all orders for user 2
select *
from orders o
join users u on o.user_id = u.user_id
where u.user_id = 2;

-- count how many order a user has
select count(u.user_id)
from orders o
join users u on o.user_id = u.user_id
where u.user_id = 2;
