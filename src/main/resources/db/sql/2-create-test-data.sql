
insert into account (public_name, login_name, login_password) values ('michael', 'michael', 'michael');

insert into account (public_name, login_name, login_password) values ('artur', 'artur', 'artur');

insert into account (public_name, login_name, login_password) values ('daniyar', 'daniyar', 'daniyar');

insert into account (public_name, login_name, login_password) values ('luis', 'luis', 'luis');


insert into home (id, public_name, description) values ('50e14f43-dd4e-412f-864d-78943ea28d91', 'Berlin Wohnung', 'Meine Wohnung in Berlin');
insert into home (id, public_name, description) values ('7edb3b2e-869c-485b-af70-76a934e0fcfd', 'Studentenwohnheim', 'Ich habe ja auch noch ein Studentenwohnheim');

insert into home (id, public_name, description) values ('67e32b59-3348-4dc3-9645-75c60b6f50cc', 'Mein Zuhause', 'Meine Wohnung in der Zellerau');


insert into account_home (account_id, home_id) values ((select id from account where login_name = 'michael'), (select id from home where public_name = 'Berlin Wohnung'));
insert into account_home (account_id, home_id) values ((select id from account where login_name = 'artur'), (select id from home where public_name = 'Berlin Wohnung'));
insert into account_home (account_id, home_id) values ((select id from account where login_name = 'daniyar'), (select id from home where public_name = 'Berlin Wohnung'));
insert into account_home (account_id, home_id) values ((select id from account where login_name = 'luis'), (select id from home where public_name = 'Berlin Wohnung'));

insert into account_home (account_id, home_id) values ((select id from account where login_name = 'michael'), (select id from home where public_name = 'Studentenwohnheim'));

insert into account_home (account_id, home_id) values ((select id from account where login_name = 'luis'), (select id from home where public_name = 'Mein Zuhause'));
insert into account_home (account_id, home_id) values ((select id from account where login_name = 'michael'), (select id from home where public_name = 'Mein Zuhause'));


insert into home_group (id, home_id, public_name, description) values ('4c8f6d82-e4c6-4478-92eb-d9342500f006', (select id from home where public_name = 'Berlin Wohnung'), 'Wohnzimmer', 'Viele Pflanzen');
insert into home_group (id, home_id, public_name, description) values ('7472cba2-6037-488f-b5aa-53b1c39fe450', (select id from home where public_name = 'Berlin Wohnung'), 'Schlafzimmer', 'Viel Sonnenlicht');
insert into home_group (id, home_id, public_name, description) values ('6b72e68d-e596-4e11-a190-bedbded40cc2', (select id from home where public_name = 'Berlin Wohnung'), 'Balkon', 'paar Topfpflanzen');

insert into home_group (id, home_id, public_name, description) values ('331541d6-617d-4464-b7d0-9b346b87f41c', (select id from home where public_name = 'Studentenwohnheim'), 'Schlafzimmer', 'Kakteen');

insert into home_group (id, home_id, public_name, description) values ('b77cc1a0-91ec-4d64-bb6d-21717737ea3c', (select id from home where public_name = 'Mein Zuhause'), 'Wohnzimmer', 'hier stehen ein paar Pflanzen');
