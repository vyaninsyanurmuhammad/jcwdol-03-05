-- Create db name as purwadhika_student, purwadhika_schedule, purwadhika_branch

create database purwadhika_student;
create database purwadhika_schedule;
create database purwadhika_branch;

-- Show list of database with name contain purwadhika.

show databases like "purwadhika%";

-- Delete database purwadhika_schedule

drop database purwadhika_schedule;

-- Create table name as Students in purwadhika_student db, with field id, last_name, first_name, address, city.
-- The id field should be in integer type while the rest is varchar.

use purwadhika_student;

create table Students (
	id integer,
	last_name varchar(255),
    first_name varchar(255),
    address varchar(255),
    city varchar(255)
);

-- Add email column into table Students with type varchar.

alter table Students add email varchar(255);

-- Add gender, batch_code, phone_number, alternative_phone_number column in single query.

alter table Students add gender varchar(255), add batch_code varchar(255), add phone_number varchar(255), add alternative_phone_number varchar(255);

-- Change alternative_phone_number column name into description with varchar type.

alter table Students change alternative_phone_number description varchar(255);

-- Remove column gender in table Students

alter table Students drop column gender;

-- Since you already create purwadhika_branch database, use that db to complete this exercise.

use purwadhika_branch;

-- Try to create table with output look like image

create table Branches (
	id integer,
	branch_name varchar(255),
    pic varchar(255),
    address varchar(255),
    city varchar(255),
    province varchar(255)
);

insert into Branches values (1, "BSD", "THOMAS", "GREEN OFFICE PARK 9", "BSD", "TANGERANG");
insert into Branches values (2, "JKT", "BUDI", "MSIG TOWER", "JAKARTA SELATAN", "JAKARTA");
insert into Branches values (2, "BTM", "ANGEL", "NONGSA", "BATAM", "KEP. RIAU");

select * from Branches;

-- Change PIC name into Dono if city is BSD

update Branches set pic = "DONO" where city = "BSD";

select * from Branches;

-- Add another branch with branch name BLI, pic is Tono, address is Gianyar, city is Gianyar, province is Bali

insert into Branches values (3, "BLI", "TONO", "GIANYAR", "GIANYAR", "BALI");

select * from Branches;

-- Go to https://dev.mysql.com/doc/index-other.html and download sakila db. Extract and import sakila data intoyour MySQL.
-- Display the first and last names of all actors from the table actor.

SELECT last_name FROM sakila.actor;

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first
-- name, "Joe." What is one query would you use to obtain this information?

SELECT * FROM sakila.actor WHERE first_name = "Joe";

-- Display the address, district, and city_id from address only for district: California, Alberta and Mekka

SELECT ad.address, ad.district, ad.city_id FROM sakila.address ad
WHERE district in ("California", "Alberta", "Mekka");

-- Count actor with last name WOOD from table actors.

SELECT count(last_name) as total_actor FROM actor WHERE last_name = 'WOOD';

-- Shows list of customer_id and sum of amount spent that made payment more than 20

SELECT customer_id, SUM(amount) as total from sakila.payment GROUP BY customer_id;

-- Add new actor into table actors with name JHONNY DAVIS

INSERT INTO sakila.actor (first_name, last_name) 
VALUES ("JHONNY", "DAVIS");

-- There are several new actor to add. Add new actor into table actors with name ADAM DAVIS, JEREMY DAVIS,
-- CRAIG DAVIS, STEVE DAVIS in a single query.

INSERT INTO sakila.actor (first_name, last_name) 
VALUES ("ADAM", "DAVIS"), ("JEREMY", "DAVIS"), ("CRAIG", "DAVIS"), ("STEVE", "DAVIS");

-- Count how many actors with last name DAVIS
SELECT count(last_name)  as total_actor FROM sakila.actor WHERE last_name = "DAVIS";

-- Delete actor with last name DAVIS and first name JENNIFER.
-- Menonaktifkan pengecekan foreign key sementara

SET foreign_key_checks = 0;

-- Menghapus entri dari tabel anak (film_actor) yang terkait dengan aktor yang akan dihapus

DELETE FROM sakila.film_actor 
WHERE actor_id IN (
    SELECT actor_id 
    FROM sakila.actor 
    WHERE first_name = "JENNIFER" AND last_name ="DAVIS"
);

-- Menghapus aktor dari tabel induk (actor)

DELETE FROM sakila.actor 
WHERE first_name = "JENNIFER" AND last_name ="DAVIS";

-- Mengaktifkan kembali pengecekan foreign key

SET foreign_key_checks = 1;

-- Update actor with last name DAVIS and change his/her first name into GEORGE

UPDATE sakila.actor SET first_name = "GEORGE" WHERE last_name="DAVIS";

-- Find top 10 actor with the most perform on film.

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fc.film_id) AS qty_film
FROM sakila.film_actor fc 
JOIN sakila.actor a ON fc.actor_id = a.actor_id 
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY qty_film DESC
LIMIT 10;

-- Display title, description, length, and rating from film, where special features include deleted scenes and behind
-- the scenes order by most length

SELECT title, description, length, rating, special_features FROM sakila.film
WHERE special_features LIKE "%Deleted Scenes%"
ORDER BY length DESC;

-- Display country and total of inactive customer (active = 0) from country where customer active = 0 order by the
-- highest inactive (active = 0) customer

SELECT co.country, COUNT(ci.country_id) as jml_country
FROM sakila.customer c
JOIN sakila.address a ON c.address_id = a.address_id
JOIN sakila.city ci ON ci.city_id = a.city_id
JOIN sakila.country co ON co.country_id = ci.country_id
WHERE active = 0
GROUP BY co.country
ORDER BY jml_country DESC;