create table auth_permission
(
    id   serial not null
        constraint auth_permission_pkey
            primary key,
    name text   not null
);

alter table auth_permission
    owner to postgres;

create index auth_permission_id_idx
    on auth_permission (id);

create table auth_role
(
    id   serial not null
        constraint auth_role_pkey
            primary key,
    name text   not null
);

alter table auth_role
    owner to postgres;

create table auth_permission_role
(
    id            serial  not null
        constraint auth_permission_role_pkey
            primary key,
    id_permission integer not null
        constraint auth_permission_role_id_permission_fkey
            references auth_permission,
    id_role       integer not null
        constraint auth_permission_role_id_role_fkey
            references auth_role
);

alter table auth_permission_role
    owner to postgres;

create index auth_permission_role_id_idx
    on auth_permission_role (id);

create index auth_permission_role_id_permission_idx
    on auth_permission_role (id_permission);

create index auth_permission_role_id_role_idx
    on auth_permission_role (id_role);

create table auth_person
(
    id                  serial                  not null
        constraint auth_person_pkey
            primary key,
    login               text                    not null,
    password            text                    not null,
    name                text                    not null,
    surname             text                    not null,
    google_calendar_key text,
    phone_number        text,
    login_key           text default gen_uuid() not null,
    id_role             integer                 not null
        constraint auth_person_id_role_fkey
            references auth_role
);

alter table auth_person
    owner to postgres;

create index auth_person_id_idx
    on auth_person (id);

create index auth_person_id_role_idx
    on auth_person (id_role);

create index auth_person_login_idx
    on auth_person (login);

create index auth_person_login_key_idx
    on auth_person (login_key);

create index auth_person_phone_number_idx
    on auth_person (phone_number);

create index auth_role_id_idx
    on auth_role (id);

create index auth_role_name_idx
    on auth_role (name);

create table list_corpus
(
    id          serial not null
        constraint list_corpus_pkey
            primary key,
    title       text,
    short_title text   not null,
    addres      text
);

alter table list_corpus
    owner to postgres;

create index list_corpus_addres_idx
    on list_corpus (addres);

create index list_corpus_id_idx
    on list_corpus (id);

create index list_corpus_short_title_idx
    on list_corpus (short_title);

create index list_corpus_title_idx
    on list_corpus (title);

create table list_division
(
    id          integer not null
        constraint list_division_pkey
            primary key,
    title       text    not null,
    short_title text    not null
);

alter table list_division
    owner to postgres;

create table list_department
(
    id          integer not null
        constraint list_department_pkey
            primary key,
    title       text    not null,
    short_title text    not null,
    id_division integer not null
        constraint list_department_id_division_fkey
            references list_division
);

alter table list_department
    owner to postgres;

create index list_department_id_division_idx
    on list_department (id_division);

create index list_department_id_idx
    on list_department (id);

create index list_division_id_idx
    on list_division (id);

create table list_employee
(
    id            integer not null
        constraint list_employee_pkey
            primary key,
    name          text    not null,
    subname       text    not null,
    middle_name   text,
    id_department integer not null
        constraint list_employee_id_department_fkey
            references list_department
);

alter table list_employee
    owner to postgres;

create index list_employee_id_department_idx
    on list_employee (id_department);

create index list_employee_id_idx
    on list_employee (id);

create index list_employee_middle_name_idx
    on list_employee (middle_name);

create index list_employee_name_idx
    on list_employee (name);

create index list_employee_subname_idx
    on list_employee (subname);

create table list_group
(
    id              integer not null
        constraint list_group_pkey
            primary key,
    course          integer not null,
    title           text    not null,
    code            text    not null,
    level_education text    not null,
    id_division     integer not null
        constraint list_group_id_division_fkey
            references list_division
);

alter table list_group
    owner to postgres;

create index list_group_code_idx
    on list_group (code);

create index list_group_course_idx
    on list_group (course);

create index list_group_id_division_idx
    on list_group (id_division);

create index list_group_id_idx
    on list_group (id);

create index list_group_title_idx
    on list_group (title);

create table list_person_employee
(
    id          serial  not null
        constraint list_person_employee_pkey
            primary key,
    id_person   integer not null
        constraint list_person_employee_id_person_fkey
            references auth_person,
    id_employee integer not null
        constraint list_person_employee_id_employee_fkey
            references list_employee
);

alter table list_person_employee
    owner to postgres;

create index list_person_employee_id_employee_idx
    on list_person_employee (id_employee);

create index list_person_employee_id_idx
    on list_person_employee (id);

create index list_person_employee_id_person_idx
    on list_person_employee (id_person);

create table list_person_group
(
    id        serial                not null
        constraint list_person_group_pkey
            primary key,
    id_person integer               not null
        constraint list_person_group_id_person_fkey
            references auth_person,
    id_group  integer               not null
        constraint list_person_group_id_group_fkey
            references list_group,
    update    boolean default false not null
);

alter table list_person_group
    owner to postgres;

create index list_person_group_id_group_idx
    on list_person_group (id_group);

create index list_person_group_id_idx
    on list_person_group (id);

create index list_person_group_id_person_idx
    on list_person_group (id_person);

create table list_schedule
(
    id               integer not null
        constraint list_schedule_pkey
            primary key,
    number_sub_gruop integer,
    title_subject    text,
    type_lesson      text,
    number_lesson    integer,
    number_room      text,
    day_week         integer,
    date_lesson      text,
    special          text,
    link             text,
    pass             text,
    zoom_link        text,
    zoom_password    text,
    id_corpus        integer
        constraint list_schedule_id_corpus_fkey
            references list_corpus,
    id_employee      integer,
    id_group         integer
        constraint list_schedule_id_group_fkey
            references list_group
);

alter table list_schedule
    owner to postgres;

create table number_lesson_t
(
    less    serial not null
        constraint number_lesson
            primary key,
    t_start text,
    t_stop  text
);

alter table number_lesson_t
    owner to postgres;

create function gen_uuid() returns text
    language plpgsql
as
$$
BEGIN
    return (SELECT uuid_in(overlay(overlay(md5(random()::text || ':' || clock_timestamp()::text) placing '4' from 13)
                                   placing to_hex(floor(random() * (11 - 8 + 1) + 8)::int)::text from 17)::cstring));
END;
$$;

alter function gen_uuid() owner to postgres;


