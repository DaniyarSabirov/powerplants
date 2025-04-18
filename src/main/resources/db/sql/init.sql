create extension if not exists "pgcrypto";

create table account (
    id uuid primary key default gen_random_uuid(),
    public_name varchar (255) not null,
    login_name varchar (255) not null,
    login_password varchar (255) not null,
    picture_url varchar (255)
);

create table home (
    id uuid primary key default gen_random_uuid(),
    public_name varchar (255) not null,
    description varchar (255)
);

create table account_home (
    account_id uuid references account (id) not null,
    home_id uuid references home (id) not null,
    primary key (account_id, home_id)
);

create table home_group (
    id uuid primary key default gen_random_uuid(),
    home_id uuid references home (id) not null,
    public_name varchar (255) not null,
    description varchar (255),
    picture_url varchar (255),
    unique (home_id, public_name)
);

create table plant (
    id uuid primary key default gen_random_uuid(),
    home_group_id uuid references home_group (id) not null,
    public_name varchar (255) not null,
    scientific_name varchar (255) not null,
    description varchar (255),
    picture_url varchar (255),
    unique (home_group_id, public_name)
);

create table plant_care_rule (
    id uuid primary key default gen_random_uuid(),
    plant_id uuid references plant (id) not null,
    public_name varchar (255) not null,
    enabled boolean not null default true,
    cron varchar (255) not null,
    instructions varchar (255),
    unique (plant_id, public_name)
);

create table plant_care_rule_custom (
    id uuid primary key references plant_care_rule (id),
    custom_instructions varchar (255) not null
);

create table plant_care_rule_water (
    id uuid primary key references plant_care_rule (id),
    amount bigint not null
);

create table plant_care_rule_sunlight (
    id uuid primary key references plant_care_rule (id),
    duration bigint not null
);

create table plant_care_rule_pruning (
    id uuid primary key references plant_care_rule (id),
    amount varchar (255) not null
);

create table plant_care_rule_disabled (
    plant_care_rule_id uuid references plant_care_rule (id) not null,
    account_id uuid references account (id) not null,
    primary key (plant_care_rule_id, account_id)
);

create table plant_care_done (
    id uuid primary key default gen_random_uuid(),
    plant_id uuid references plant (id) not null,
    plant_care_rule_id uuid references plant_care_rule (id) not null,
    completed_by uuid references account (id) not null,
    completed_at timestamptz not null,
    details varchar (255)
);
