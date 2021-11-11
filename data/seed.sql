
-- Databases
INSERT INTO databases (id, title_en, title_sv, description_en, description_sv, is_popular, malfunction_message, malfunction_message_active, public_access, access_information_code) VALUES(1, 'Database 1 (en)', 'Databas 1 (sv)','en - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', 'sv - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', FALSE, 'down for maintenance', FALSE, TRUE, 'free');
INSERT INTO databases (id, title_en, title_sv, description_en, description_sv, is_popular, malfunction_message, malfunction_message_active, public_access, access_information_code) VALUES(2, 'Database 2 (en)', 'Databas 2 (sv)','en - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', 'sv - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', FALSE, 'down for maintenance', FALSE, TRUE, 'free');
INSERT INTO databases (id, title_en, title_sv, description_en, description_sv, is_popular, malfunction_message, malfunction_message_active, public_access, access_information_code) VALUES(3, 'Database 3 (en)', 'Databas 3 (sv)','en - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', 'sv - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', FALSE, 'down for maintenance', FALSE, TRUE, 'free');
INSERT INTO databases (id, title_en, title_sv, description_en, description_sv, is_popular, malfunction_message, malfunction_message_active, public_access, access_information_code) VALUES(3, 'Database 3 (en)', 'Databas 3 (sv)','en - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', 'sv - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', FALSE, 'down for maintenance', FALSE, TRUE, 'free');
INSERT INTO databases (id, title_en, title_sv, description_en, description_sv, is_popular, malfunction_message, malfunction_message_active, public_access, access_information_code) VALUES(4, 'Aaaaaaaa (en)', 'AAAAAAAA  (sv)','en - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', 'sv - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', FALSE, 'down for maintenance', FALSE, TRUE, 'free');
INSERT INTO databases (id, title_en, title_sv, description_en, description_sv, is_popular, malfunction_message, malfunction_message_active, public_access, access_information_code) VALUES(5, 'Bbbbbbbb (en)', 'Bbbbbbbb (sv)','en - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', 'sv - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', FALSE, 'down for maintenance', FALSE, TRUE, 'free');
INSERT INTO databases (id, title_en, title_sv, description_en, description_sv, is_popular, malfunction_message, malfunction_message_active, public_access, access_information_code) VALUES(6, 'ccccccccccc (en)', 'ccccccccccc (sv)','en - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', 'sv - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin cursus rhoncus purus, id convallis quam ullamcorper et.', FALSE, 'down for maintenance', FALSE, TRUE, 'free');


-- alternative_titles
INSERT INTO alternative_titles (id, title) VALUES (1, 'alt title 1');
INSERT INTO alternative_titles (id, title) VALUES (3, 'alt title 3');
INSERT INTO alternative_titles (id, title) VALUES (4, 'alt title 4');
INSERT INTO alternative_titles (id, title) VALUES (5, 'alt title 5');
INSERT INTO alternative_titles (id, title) VALUES (6, 'alt title 6');
INSERT INTO alternative_titles (id, title) VALUES (7, 'alt title 7');
INSERT INTO alternative_titles (id, title) VALUES (8, 'alt title 8');

INSERT INTO alternative_title_for (database_id, alternative_title_id) VALUES (1, 1);
INSERT INTO alternative_title_for (database_id, alternative_title_id) VALUES (2, 2);
INSERT INTO alternative_title_for (database_id, alternative_title_id) VALUES (2, 3);
INSERT INTO alternative_title_for (database_id, alternative_title_id) VALUES (1, 4);

-- topics
INSERT INTO topics (id, name_en, name_sv) VALUES (1, 'Sci-fi (en)', 'Rymdsaga (sv)');
INSERT INTO topics (id, name_en, name_sv, parent_topic_id) VALUES (2, 'Star wars (en)', 'Stjärnornas krig (sv)', 1);
INSERT INTO topics (id, name_en, name_sv, parent_topic_id) VALUES (3, 'Battlestar Galactica (en)', 'Krigsstjärnan galaxia (sv)', 1);
INSERT INTO topics (id, name_en, name_sv) VALUES (4, 'Voldemort (en)', 'Voldemort (sv)');
INSERT INTO topics (id, name_en, name_sv) VALUES (5, 'Face (en)', 'Ansikte(sv)');
INSERT INTO topics (id, name_en, name_sv, parent_topic_id) VALUES (6, 'Car (en)', 'Bil (sv)', 4);
INSERT INTO topics (id, name_en, name_sv, parent_topic_id) VALUES (7, 'Raw beaf (en)', 'Råbiff (sv)', 4);
INSERT INTO topics (id, name_en, name_sv, parent_topic_id) VALUES (8, 'Hunddagis en', 'Hunddagis (sv)', 4);
INSERT INTO topics (id, name_en, name_sv) VALUES (9, 'hot dog (en)', 'varmkorv (sv)');
INSERT INTO topics (id, name_en, name_sv, parent_topic_id) VALUES (10, 'Bamsekosrv (en)', 'Bamsekorv (sv)', 9);

INSERT INTO topic_for (database_id, topic_id) VALUES (1, 1);
INSERT INTO topic_for (database_id, topic_id) VALUES (1, 2);
INSERT INTO topic_for (database_id, topic_id) VALUES (2, 2);
INSERT INTO topic_for (database_id, topic_id) VALUES (3, 3);

INSERT INTO topic_recommended_for (database_id, topic_id) VALUES (1, 3);
INSERT INTO topic_recommended_for (database_id, topic_id) VALUES (2, 1);
INSERT INTO topic_recommended_for (database_id, topic_id) VALUES (3, 1);

-- Publishers
INSERT INTO publishers (id, title_en, title_sv) VALUES (1, 'Romanjevi publishing (en)', 'Romanjevi publishing (sv)');
INSERT INTO publishers (id, title_en, title_sv) VALUES (2, 'ABC publishing (en)', 'ABC publishing (sv)');
INSERT INTO publishers (id, title_en, title_sv) VALUES (3, 'Skumrask publishing (en)', 'Skumrask publishing (sv)');

-- db and publisher relation

INSERT INTO publisher_for (database_id, publisher_id) VALUES (1,1);
INSERT INTO publisher_for (database_id, publisher_id) VALUES (1,2);
INSERT INTO publisher_for (database_id, publisher_id) VALUES (2,3);
INSERT INTO publisher_for (database_id, publisher_id) VALUES (3,3);

INSERT INTO urls (id, title, url) VALUES (1, 'link title 1', 'www.google.com');
INSERT INTO urls (id, title, url) VALUES (2, 'link title 2', 'www.google.com');
INSERT INTO urls (id, title, url) VALUES (3, 'link title 3', 'www.google.com');
INSERT INTO urls (id, title, url) VALUES (4, 'link title 4', 'www.google.com');
INSERT INTO urls (id, title, url) VALUES (5, 'link title 5', 'www.google.com');

INSERT INTO url_for (database_id, url_id) VALUES (1, 1);
INSERT INTO url_for (database_id, url_id) VALUES (1, 2);
INSERT INTO url_for (database_id, url_id) VALUES (2, 3);
INSERT INTO url_for (database_id, url_id) VALUES (3, 4);

INSERT INTO terms_of_use (id, code) VALUES (1, 'print_article_chapter');
INSERT INTO terms_of_use (id, code) VALUES (2, 'download_article_chapter');
INSERT INTO terms_of_use (id, code) VALUES (3, 'course_pack_print');
INSERT INTO terms_of_use (id, code) VALUES (4, 'gul_course_pack_electronic');
INSERT INTO terms_of_use (id, code) VALUES (5, 'scholarly_sharing');
INSERT INTO terms_of_use (id, code) VALUES (6, 'interlibrary_loan');

INSERT INTO terms_of_use_for (id, database_id, terms_of_use_id, description_sv, description_en, permitted) VALUES (1, 1, 1, 'terms of use description 1 (sv)', 'terms of use description 1 (en)', FALSE);
INSERT INTO terms_of_use_for (id, database_id, terms_of_use_id, description_sv, description_en, permitted) VALUES (2, 2, 1, 'terms of use description 2 (sv)', 'terms of use description 2 (en)', TRUE);
INSERT INTO terms_of_use_for (id, database_id, terms_of_use_id, description_sv, description_en, permitted) VALUES (3, 3, 1, 'terms of use description 3 (sv)', 'terms of use description 3 (en)', FALSE);
INSERT INTO terms_of_use_for (id, database_id, terms_of_use_id, description_sv, description_en, permitted) VALUES (4, 1, 2, 'terms of use description 4 (sv)', 'terms of use description 4 (en)', TRUE);
INSERT INTO terms_of_use_for (id, database_id, terms_of_use_id, description_sv, description_en, permitted) VALUES (5, 2, 3, 'terms of use description 4 (sv)', 'terms of use description 4 (en)', TRUE);
INSERT INTO terms_of_use_for (id, database_id, terms_of_use_id, description_sv, description_en, permitted) VALUES (6, 2, 4, 'terms of use description 4 (sv)', 'terms of use description 4 (en)', TRUE);
INSERT INTO terms_of_use_for (id, database_id, terms_of_use_id, description_sv, description_en, permitted) VALUES (7, 3, 5, 'terms of use description 4 (sv)', 'terms of use description 4 (en)', TRUE);
INSERT INTO terms_of_use_for (id, database_id, terms_of_use_id, description_sv, description_en, permitted) VALUES (8, 3, 6, 'terms of use description 4 (sv)', 'terms of use description 4 (en)', TRUE);


INSERT INTO media_types (id, name_en, name_sv) VALUES (1, 'media type 1 (en)', 'media type 1 (sv)');
INSERT INTO media_types (id, name_en, name_sv) VALUES (2, 'media type 2 (en)', 'media type 2 (sv)');
INSERT INTO media_types (id, name_en, name_sv) VALUES (3, 'media type 3 (en)', 'media type 3 (sv)');
INSERT INTO media_types (id, name_en, name_sv) VALUES (4, 'media type 4 (en)', 'media type 4 (sv)');
INSERT INTO media_types (id, name_en, name_sv) VALUES (5, 'media type 5 (en)', 'media type 5 (sv)');
INSERT INTO media_types (id, name_en, name_sv) VALUES (6, 'media type 6 (en)', 'media type 6 (sv)');

INSERT INTO media_type_for (database_id, media_type_id) VALUES (1,1);
INSERT INTO media_type_for (database_id, media_type_id) VALUES (1,2);
INSERT INTO media_type_for (database_id, media_type_id) VALUES (2,2);
INSERT INTO media_type_for (database_id, media_type_id) VALUES (3,3);
INSERT INTO media_type_for (database_id, media_type_id) VALUES (3,4);
