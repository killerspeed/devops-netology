create table language ( language_id serial primary key, language varchar (50) unique not null, create_date timestamp default now());

insert into "language" (language) 
values 
('Russian'),('English'),('Ukrainian'),('Arab'),('Deutsch');

create table nationality ( nationality_id serial primary key,nationality varchar (50) unique not null, create_date timestamp default now());

insert into nationality (nationality)
values 
('Slavic'),('American'),('Ukrainian'),('Egyptian'),('German');

create table countries (countries_id serial primary key, countries varchar (50) unique not null, create_date timestamp default now());

insert into countries (countries)
values
('Russia'),('USA'),('Ukraine'),('Egypt'),('Germany');


CREATE TABLE "coun_na" ( countries_id INTEGER REFERENCES countries(countries_id), 
nationality_id INTEGER REFERENCES nationality(nationality_id),
create_date timestamp default now(), 
PRIMARY KEY (nationality_id,countries_id));

CREATE TABLE "la_na" ( language_id INTEGER REFERENCES language(language_id), 
nationality_id INTEGER REFERENCES nationality(nationality_id),
create_date timestamp default now(), 
PRIMARY KEY (nationality_id,language_id));


insert into coun_na (countries_id,nationality_id)
values
(1,1),(2,2),(3,3),(4,4),(5,5);

insert into la_na  (language_id,nationality_id)
values
(1,1),(2,2),(3,3),(4,4),(5,5);


