create extension if not exists "pgcrypto";

create table account (
    id UUID primary key default gen_random_uuid(),
    public_name varchar (255) not null,
    login_name varchar (255) not null,
    login_password varchar (255) not null,
    unique (public_name),
    unique (login_name)
);

create table home (
    id UUID primary key default gen_random_uuid(),
    public_name varchar (255) not null,
    unique (public_name)
);

create table account_home (
    account_id UUID references account (id) not null,
    home_id UUID references home (id) not null,
    joined_at timestamptz default now(),
    primary key (account_id, home_id)
);

create table home_group (
    id UUID primary key default gen_random_uuid(),
    public_name varchar (255) not null,
    home_id UUID references home (id) not null,
    unique (public_name, home_id)
);

create table plant (
    id UUID primary key default gen_random_uuid(),
    public_name varchar (255) not null,
    scientific_name varchar (255) not null,
    home_group_id UUID references home_group (id) not null,
    unique (public_name, home_group_id)
);
