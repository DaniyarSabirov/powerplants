create extension if not exists "pgcrypto";

create table account (
    id UUID primary key default gen_random_uuid(),
    public_name varchar (255) not null,
    login_name varchar (255) not null,
    login_password varchar (255) not null,
    picture_url varchar (255)
);

create table home (
    id UUID primary key default gen_random_uuid(),
    public_name varchar (255) not null,
    description varchar (255)
);

create table account_home (
    account_id UUID references account (id) not null,
    home_id UUID references home (id) not null,
    primary key (account_id, home_id)
);

create table home_group (
    id UUID primary key default gen_random_uuid(),
    home_id UUID references home (id) not null,
    public_name varchar (255) not null,
    description varchar (255),
    picture_url varchar (255),
    unique (home_id, public_name)
);

create table plant (
    id UUID primary key default gen_random_uuid(),
    home_group_id UUID references home_group (id) not null,
    public_name varchar (255) not null,
    scientific_name varchar (255) not null,
    description varchar (255),
    picture_url varchar (255),
    unique (home_group_id, public_name)
);

create table plant_care_rule (
    id UUID primary key default gen_random_uuid(),
    plant_id UUID references plant (id) not null,
    public_name varchar (255) not null,
    enabled boolean not null default true,
    cron varchar (255) not null,
    instructions varchar (255),
    unique (plant_id, public_name)
);

create table plant_care_rule_disabled (
    plant_care_rule_id UUID references plant_care_rule (id) not null,
    account_id UUID references account (id) not null,
    primary key (plant_care_rule_id, account_id)
);

create table plant_care_done (
    id UUID primary key default gen_random_uuid(),
    plant_id UUID references plant (id) not null,
    plant_care_rule_id UUID references plant_care_rule (id) not null,
    completed_by UUID references account (id) not null,
    completed_at timestamptz not null,
    details varchar (255)
);

create table plant_care_rule_custom (
    id UUID primary key default gen_random_uuid(),
    plant_care_rule_id UUID references plant_care_rule (id) not null,
    instructions varchar (255) not null
);

create table plant_care_rule_water (
    id UUID primary key default gen_random_uuid(),
    plant_care_rule_id UUID references plant_care_rule (id) not null,
    amount bigint not null
);

create table plant_care_rule_sunlight (
    id UUID primary key default gen_random_uuid(),
    plant_care_rule_id UUID references plant_care_rule (id) not null,
    duration bigint not null
);

create table plant_care_rule_pruning (
    id UUID primary key default gen_random_uuid(),
    plant_care_rule_id UUID references plant_care_rule (id) not null,
    amount varchar (255) not null
);
