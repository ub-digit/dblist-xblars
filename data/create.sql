DROP TABLE databases;
DROP TABLE alternative_titles;
DROP TABLE alternative_title_for;
DROP TABLE topics;
DROP TABLE topic_for;
DROP TABLE sub_topic_for;
DROP TABLE publishers;
DROP TABLE publisher_for;
DROP TABLE urls;
DROP TABLE url_for;
DROP TABLE terms_of_use;
DROP TABLE terms_of_use_for;
DROP TABLE topic_recommended_for;
DROP TABLE media_types;
DROP TABLE media_type_for;
DROP TABLE sub_topics;

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
    id serial PRIMARY KEY,
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
    id serial PRIMARY KEY,
    url_id int,
    database_id int
);

CREATE TABLE topics (
    id serial PRIMARY KEY,
    name_en text,
    name_sv text
);

CREATE TABLE sub_topics (
    id serial PRIMARY KEY,
    name_en text,
    name_sv text,
    topic_id int
);

CREATE TABLE topic_for (
    id serial PRIMARY KEY,
    database_id int,
    topic_id int,
    is_recommended boolean
);

CREATE TABLE sub_topic_for (
    id serial PRIMARY KEY,
    database_id int,
    sub_topic_id int,
    is_recommended boolean
);

CREATE TABLE topic_recommended_for (
    id serial PRIMARY KEY,
    database_id int,
    topic_id int,
    sub_topic_id int
);

CREATE TABLE publishers (
    id serial PRIMARY KEY,
    title_en text,
    title_sv text
);

CREATE TABLE publisher_for (
    id serial PRIMARY KEY,
    database_id int,
    publisher_id int
);

CREATE TABLE media_types (
    id serial PRIMARY KEY,
    name_en text,
    name_sv text
);

CREATE TABLE media_type_for (
    id serial PRIMARY KEY,
    database_id int,
    media_type_id int
);
