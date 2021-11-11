DROP TABLE databases;
DROP TABLE alternative_titles;
DROP TABLE alternative_title_for;
DROP TABLE topics;
DROP TABLE topic_for;
DROP TABLE publishers;
DROP TABLE publisher_for;
DROP TABLE urls;
DROP TABLE url_for;
DROP TABLE terms_of_use;
DROP TABLE terms_of_use_for;
DROP TABLE topic_recommended_for;
DROP TABLE media_types;
DROP TABLE media_type_for;

CREATE TABLE databases (
    id serial PRIMARY KEY,
    title_en text,
    title_sv text,
    description_en text,
    description_sv text,
    is_popular boolean,
    public_access boolean,
    malfunction_message_active boolean,
    malfunction_message text,
    access_information_code text
);

CREATE TABLE alternative_titles (
    id serial PRIMARY KEY,
    title text
);

CREATE TABLE alternative_title_for (
    alternative_title_id int,
    database_id int
);


CREATE TABLE terms_of_use (
    id serial PRIMARY KEY,
    code text
);

CREATE TABLE terms_of_use_for (
    id serial PRIMARY KEY,
    description_sv text,
    description_en text,
    permitted boolean,
    database_id int,
    terms_of_use_id int
);

CREATE TABLE urls (
    id serial PRIMARY KEY,
    title text,
    url text
);

CREATE TABLE url_for (
    url_id int,
    database_id int
);

CREATE TABLE topics (
    id serial PRIMARY KEY,
    name_en text,
    name_sv text,
    parent_topic_id int
);

CREATE TABLE topic_for (
    database_id int,
    topic_id int
);

CREATE TABLE topic_recommended_for (
    topic_id int,
    database_id int
);

CREATE TABLE publishers (
    id serial PRIMARY KEY,
    title_en text,
    title_sv text
);

CREATE TABLE publisher_for (
    database_id int,
    publisher_id int
);


CREATE TABLE media_types (
    id serial PRIMARY KEY,
    name_en text,
    name_sv text
);

CREATE TABLE media_type_for (
    database_id int,
    media_type_id int
);