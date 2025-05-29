create extension if not exists "pgcrypto";

create table account (
    id uuid primary key default gen_random_uuid(),
    public_name text not null,
    login_name text not null,
    login_password text not null,
    image_id text,
    unique (login_name)
);

create table home (
    id uuid primary key default gen_random_uuid(),
    public_name text not null,
    description text
);

create table account_home (
    account_id uuid references account (id) not null,
    home_id uuid references home (id) not null,
    primary key (account_id, home_id)
);

create table home_group (
    id uuid primary key default gen_random_uuid(),
    home_id uuid references home (id) not null,
    public_name text not null,
    description text,
    image_id text,
    unique (home_id, public_name)
);

create table plant (
    id uuid primary key default gen_random_uuid(),
    home_group_id uuid references home_group (id) not null,
    public_name text not null,
    scientific_name text not null,
    description text,
    image_id text,
    unique (home_group_id, public_name)
);

create table plant_care_rule (
    id uuid primary key default gen_random_uuid(),
    plant_id uuid references plant (id) not null,
    public_name text not null,
    enabled boolean not null default true,
    cron text not null,
    instructions text,
    unique (plant_id, public_name)
);

create table plant_care_rule_custom (
    id uuid primary key references plant_care_rule (id),
    custom_instructions text not null
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
    amount text not null
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
    details text
);
