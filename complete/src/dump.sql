--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: gen_uuid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gen_uuid() RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    return (SELECT uuid_in(overlay(overlay(md5(random()::text || ':' || clock_timestamp()::text) placing '4' from 13) placing to_hex(floor(random()*(11-8+1) + 8)::int)::text from 17)::cstring));
END;
$$;


ALTER FUNCTION public.gen_uuid() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_permission_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission_role (
    id integer NOT NULL,
    id_permission integer NOT NULL,
    id_role integer NOT NULL
);


ALTER TABLE public.auth_permission_role OWNER TO postgres;

--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_role_id_seq OWNER TO postgres;

--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_role_id_seq OWNED BY public.auth_permission_role.id;


--
-- Name: auth_person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_person (
    id integer NOT NULL,
    login text NOT NULL,
    password text NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    google_calendar_key text,
    phone_number text,
    login_key text DEFAULT public.gen_uuid() NOT NULL,
    id_role integer NOT NULL
);


ALTER TABLE public.auth_person OWNER TO postgres;

--
-- Name: auth_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_person_id_seq OWNER TO postgres;

--
-- Name: auth_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_person_id_seq OWNED BY public.auth_person.id;


--
-- Name: auth_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_role (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.auth_role OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_role_id_seq OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_role_id_seq OWNED BY public.auth_role.id;


--
-- Name: list_corpus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_corpus (
    id integer NOT NULL,
    title text,
    short_title text NOT NULL,
    addres text
);


ALTER TABLE public.list_corpus OWNER TO postgres;

--
-- Name: list_corpus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.list_corpus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_corpus_id_seq OWNER TO postgres;

--
-- Name: list_corpus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.list_corpus_id_seq OWNED BY public.list_corpus.id;


--
-- Name: list_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_department (
    id integer NOT NULL,
    title text NOT NULL,
    short_title text NOT NULL,
    id_division integer NOT NULL
);


ALTER TABLE public.list_department OWNER TO postgres;

--
-- Name: list_division; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_division (
    id integer NOT NULL,
    title text NOT NULL,
    short_title text NOT NULL
);


ALTER TABLE public.list_division OWNER TO postgres;

--
-- Name: list_employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_employee (
    id integer NOT NULL,
    name text NOT NULL,
    subname text NOT NULL,
    middle_name text,
    id_department integer NOT NULL
);


ALTER TABLE public.list_employee OWNER TO postgres;

--
-- Name: list_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_group (
    id integer NOT NULL,
    course integer NOT NULL,
    title text NOT NULL,
    code text NOT NULL,
    level_education text NOT NULL,
    id_division integer NOT NULL
);


ALTER TABLE public.list_group OWNER TO postgres;

--
-- Name: list_person_employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_person_employee (
    id integer NOT NULL,
    id_person integer NOT NULL,
    id_employee integer NOT NULL
);


ALTER TABLE public.list_person_employee OWNER TO postgres;

--
-- Name: list_person_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.list_person_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_person_employee_id_seq OWNER TO postgres;

--
-- Name: list_person_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.list_person_employee_id_seq OWNED BY public.list_person_employee.id;


--
-- Name: list_person_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_person_group (
    id integer NOT NULL,
    id_person integer NOT NULL,
    id_group integer NOT NULL,
    update boolean DEFAULT false NOT NULL
);


ALTER TABLE public.list_person_group OWNER TO postgres;

--
-- Name: list_person_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.list_person_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_person_group_id_seq OWNER TO postgres;

--
-- Name: list_person_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.list_person_group_id_seq OWNED BY public.list_person_group.id;


--
-- Name: list_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_schedule (
    id integer NOT NULL,
    number_sub_gruop integer NOT NULL,
    title_subject text NOT NULL,
    type_lesson text NOT NULL,
    number_lesson integer NOT NULL,
    day_week integer NOT NULL,
    date_lesson text NOT NULL,
    special text NOT NULL,
    link text NOT NULL,
    pass text NOT NULL,
    zoom_link text NOT NULL,
    zoom_password text NOT NULL,
    id_corpus integer NOT NULL,
    id_employee integer NOT NULL,
    id_group integer NOT NULL,
    number_room text
);


ALTER TABLE public.list_schedule OWNER TO postgres;

--
-- Name: number_lesson_t; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.number_lesson_t (
    less integer NOT NULL,
    t_start text,
    t_stop text
);


ALTER TABLE public.number_lesson_t OWNER TO postgres;

--
-- Name: number_lesson_t_less_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.number_lesson_t_less_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.number_lesson_t_less_seq OWNER TO postgres;

--
-- Name: number_lesson_t_less_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.number_lesson_t_less_seq OWNED BY public.number_lesson_t.less;


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_permission_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_role_id_seq'::regclass);


--
-- Name: auth_person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_person ALTER COLUMN id SET DEFAULT nextval('public.auth_person_id_seq'::regclass);


--
-- Name: auth_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_role ALTER COLUMN id SET DEFAULT nextval('public.auth_role_id_seq'::regclass);


--
-- Name: list_corpus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_corpus ALTER COLUMN id SET DEFAULT nextval('public.list_corpus_id_seq'::regclass);


--
-- Name: list_person_employee id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_employee ALTER COLUMN id SET DEFAULT nextval('public.list_person_employee_id_seq'::regclass);


--
-- Name: list_person_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_group ALTER COLUMN id SET DEFAULT nextval('public.list_person_group_id_seq'::regclass);


--
-- Name: number_lesson_t less; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.number_lesson_t ALTER COLUMN less SET DEFAULT nextval('public.number_lesson_t_less_seq'::regclass);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name) FROM stdin;
1	admin
2	user
\.


--
-- Data for Name: auth_permission_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission_role (id, id_permission, id_role) FROM stdin;
\.


--
-- Data for Name: auth_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_person (id, login, password, name, surname, google_calendar_key, phone_number, login_key, id_role) FROM stdin;
90	mrdatman201	asdfgh0	sdfgfn	sfdg	{"accessToken":"ya29.a0AfH6SMCd0KGprlSF3pS4v7KdTAZhLIgNHOZILaOxQobtFZNcITsgaDRUpVBqH4FObx50Fdi6UiUkrLYZOTBiGg_w5DCYkPi0nuGIiZ76Bz8z6xhR3qTXGJrobUefj-bTVTslFJlFIpArIPkTOl5tLntCwDmMirt5uvo","refreshToken":"1//0czbXHIvh-x1CCgYIARAAGAwSNwF-L9IrKcokGfMGwUXoQmvHl9gI9p9w6EfVW2_0nZaEgQIdSWzx3JHcLmbxuMk8IgQPE7TW4Bo","expiresInSeconds":3533,"expirationTimeMilliseconds":1602904874413}	\\N	7de450ed-5918-41e0-b79c-ddb810706ec6	2
89	mrdatman2014	Yps2psmgr	Игорь	Малофеев	{"accessToken":"ya29.a0AfH6SMDeqevCx3oTGTSH7ovFGSZXTMqxXgBWYBEGkkFhHGJXCGcYVI4JsoWT3YgfGSOdXWAfWcbxLy56s1PHt7BVfqYDd3uUtpu0r-jcoQn2IgPacKXDgzKo7ttBnOpfHaQKQsP6lYKU5UQJVKokdZ6Kbb4vz0wSoKPD","refreshToken":"1//0caJbOhYg-SIQCgYIARAAGAwSNwF-L9IrE4QsqjxPuePbwXiCYPXlAbcnFEPuuk1SLcR6zmvw755lHe-kQ-2TFVW_XNZiEaxKZkw","expiresInSeconds":3585,"expirationTimeMilliseconds":1602904848202}	\\N	0c726f90-a3c0-4b6b-b3fe-51646f99b169	2
2	Daniil01	5mL9VeKBZN7db8D	D	P	{"accessToken":"ya29.a0AfH6SMC9pja7XehM3tKP6mTMlr3Ql3U_w3TGlDR6iQOIbIk-byWJLn8R0l407sGlfd5yCP22CmyDJ3QgyHmPyqy_GdpPexCtbl3GQnGmvqdzxNv5tsM6gxlwWtG13o9X-LgYYFcAeIMI38AefdhHuXvO-j2QZecE7o0","refreshToken":"1//0c9y6_rgeCI_OCgYIARAAGAwSNwF-L9IrOBXAe9O8vP-91WXKxadzGU3v_nOk4AdRNi-gi6ZDHHmEjC99nbLPqBOhjjcL_g4LLvw","expiresInSeconds":2278,"expirationTimeMilliseconds":1602928057451}	\N	3db5c418-d642-4a52-a0a5-91c96c15b63b	2
1	admin01	asdfgh1	gfh	sssss	{"accessToken":"ya29.a0AfH6SMC8LkY3B-KVW9od-kLY2TWIReytPIRDW_5OLNrLGxVzACAJHe58f_JGgsCVqBnefZdmzbrY-YWzLrTi-pQKB0tywv0Q8DNQVFkdXhmnE3YnavCTKbwQPe93_JtisUxA_aRAI3Mg4LSoygdevMnNLzA4n5nj7aA","refreshToken":"1//0cWDEMcoohgnbCgYIARAAGAwSNwF-L9IrUew8MDufsxt6ZrU6thZBVC0rFgUzvQnaO9d0HJUXEd92SI4UEWhG5QVwWYcafWm1wb8","expiresInSeconds":3599,"expirationTimeMilliseconds":1602926588897}	\N	9eddc7bb-16b8-4076-b73b-9bd2389a7212	2
\.


--
-- Data for Name: auth_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_role (id, name) FROM stdin;
1	admin
2	user
\.


--
-- Data for Name: list_corpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_corpus (id, title, short_title, addres) FROM stdin;
0	\N	a	ул. Комсомольcкая, д. 95, Орёл, Орловская обл.
1	\\N	a	ул. Комсомольская, д. 39а, Орёл, Орловская обл.
2	\\N	a	ул. Комсомольская, д. 41, Орёл, Орловская обл.
3	\\N	a	ул. Комсомольская, д. 95, Орёл, Орловская обл.
4	\\N	a	ул. Октябрьская, д.25, Орёл, Орловская обл.
6	\\N	a	ул. Ленина, д. 6а, Орёл, Орловская обл.
5	\\N	a	ул. Ленина, д. 6а, Орёл, Орловская обл.
7	\\N	a	пер. Воскресенский, д. 3, Орёл, Орловская обл.
8	\\N	a	ул. Комсомольская, д. 39б, Орёл, Орловская обл.
9	\\N	a	ул. Московская, д. 159а, Орёл, Орловская обл.
10	\\N	a	ул. Комсомольская, д. 41, Орёл, Орловская обл.
11	\\N	a	Наугорское шоссе, д. 29, Орёл, Орловская обл.
17	\\N	a	ул. Комсомольcкая, д. 95, Орёл, Орловская обл.\\r\\nул. Комсомольская, д. 39а, Орёл, Орловская обл.\\r\\nул. Комсомольская, д. 41, Орёл, Орловская обл.\\r\\nул. Комсомольская, д. 95, Орёл, Орловская обл.\\r\\nул. Октябрьская, д.25, Орёл, Орловская обл.\\r\\nул. Ленина, д. 6а, Орёл, Орловская обл.\\r\\nпер. Воскресенский, д. 3, Орёл, Орловская обл.\\r\\nул. Комсомольская, д. 39б, Орёл, Орловская обл.\\r\\nул. Московская, д. 159а, Орёл, Орловская обл.\\r\\nул. Комсомольская, д. 41, Орёл, Орловская обл.\\r\\nНаугорское шоссе, д. 29, Орёл, Орловская обл.\\r\\nНаугорское шоссе, д. 40, Орёл, Орловская обл.\\r\\nул. Московская, д. 65, Орёл, Орловская обл.\\r\\nпер. Артельный, д. 5, Орёл, Орловская обл.\\r\\nул. Московская, д.34, Орёл, Орловская обл.\\r\\nул. Московская, д. 77, Орёл, Орловская обл.
12	\\N	a	Наугорское шоссе, д. 40, Орёл, Орловская обл.
13	\\N	a	ул. Московская, д. 65, Орёл, Орловская обл.
14	\\N	a	пер. Артельный, д. 5, Орёл, Орловская обл.
15	\\N	a	ул. Московская, д.34, Орёл, Орловская обл.
16	\\N	a	ул. Московская, д. 77, Орёл, Орловская обл.
\.


--
-- Data for Name: list_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_department (id, title, short_title, id_division) FROM stdin;
\.


--
-- Data for Name: list_division; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_division (id, title, short_title) FROM stdin;
5	Архитектурно-строительный институт	АСИ
152	Институт естественных наук и  биотехнологии	 ИЕНиБ
11	Институт естественных наук и биотехнологии	ИЕНиБ
12	Институт заочного и очно-заочного образования	ИВЗО
164	Институт иностранных языков	Иняз
157	Институт педагогики и психологии	ИПиП
7	Институт приборостроения, автоматизации и информационных технологий	ИПАИТ
154	Институт филологии	ИФил
289	Институт экономики и управления	ИЭиУ
167	Исторический факультет	ИстФак
488	Лечебный факультет	ЛФ
124	Политехнический институт имени Н.Н. Поликарпова	ПТИ
155	Социальный факультет	СоцФак
158	Факультет педиатрии, стоматологии и фармации	ФПСиФ
163	Факультет технологии, предпринимательства и сервиса	ФТПиС
26	Факультет физической культуры и спорта	ФФКС
150	Физико-математический факультет	ФизМат
153	Философский факультет	Филос
159	Художественно-графический факультет	ХГФ
2	Юридический институт	ЮИ
\.


--
-- Data for Name: list_employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_employee (id, name, subname, middle_name, id_department) FROM stdin;
\.


--
-- Data for Name: list_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_group (id, course, title, code, level_education, id_division) FROM stdin;
6348	3	81БТ	19.03.01 (а) (о)	бакалавриат	11
6440	3	81ПР	19.03.02 (п) (о)	бакалавриат	11
6441	3	81ТП	19.03.04 (п) (о)	бакалавриат	11
6376	3	81ТД	38.05.02 (с) (о)	специалитет	11
6485	3	82ТД	38.05.02 (с) (о)	специалитет	11
7112	2	91БТ	19.03.01 (а) (о)	бакалавриат	11
7050	2	91ПЖ	19.03.03 (п) (о)	бакалавриат	11
7121	2	91ПР	19.03.02 (п) (о)	бакалавриат	11
7202	2	91ТЭ	38.03.07 (а) (о)	бакалавриат	11
6906	2	91БТ-м	19.04.01 (м) (о)	магистратура	11
6908	2	91ПЖ-м	19.04.03 (м) (о)	магистратура	11
6907	2	91ПР-м	19.04.02 (м) (о)	магистратура	11
6909	2	91ТП-м	19.04.04 (м) (о)	магистратура	11
6891	2	91ТД	38.05.02 (с) (о)	специалитет	11
6543	3	81АП	15.03.04 (п) (о)	бакалавриат	7
6628	3	81БС	12.03.04 (а) (о)	бакалавриат	7
6629	3	81ИБ	10.03.01 (б) (о)	бакалавриат	7
6439	3	81ИВТ	09.03.01 (п) (о)	бакалавриат	7
6345	3	81ИК	11.03.02 (а) (о)	бакалавриат	7
6342	3	81ИТ	09.03.02 (а) (о)	бакалавриат	7
6696	3	81КЭ	11.03.03 (п) (о)	бакалавриат	7
6344	3	81ПГ	09.03.04 (а) (о)	бакалавриат	7
7299	3	81ПИ	09.03.03 (п) (о)	бакалавриат	7
6442	3	81УТ	27.03.04 (п) (о)	бакалавриат	7
6347	3	81ЭЭ	13.03.02 (а) (о)	бакалавриат	7
6695	3	82ПИ	09.03.03 (а) (о)	бакалавриат	7
\.


--
-- Data for Name: list_person_employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_person_employee (id, id_person, id_employee) FROM stdin;
\.


--
-- Data for Name: list_person_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_person_group (id, id_person, id_group, update) FROM stdin;
3	2	6543	f
\.


--
-- Data for Name: list_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_schedule (id, number_sub_gruop, title_subject, type_lesson, number_lesson, day_week, date_lesson, special, link, pass, zoom_link, zoom_password, id_corpus, id_employee, id_group, number_room) FROM stdin;
372810	0	Предпринимательство	лаб	2	1	2020-10-12				null	null	11	7890	6543	205
458839	0	Разработка платформенных и кросплатформенных киберфизических систем	конс	2	6	2020-10-17	Кибернетические и киберфизические системы			null	null	11	3692	6543	205
372801	0	Предпринимательство	лаб	3	1	2020-10-12				null	null	11	7890	6543	205
475665	0	Проектная деятельность	лаб	3	3	2020-10-14				null	null	11	1455	6543	211
470621	0	Предпринимательство	лек	4	2	2020-10-13		https://us04web.zoom.us/j/74056835313?pwd=SWZydDdDU1dxSUFZYVpIa2R6OVQ1Zz09	�?дентификатор конференции: 740 5683 5313 Код доступа: 2VRJP5	null	null	0	7890	6543	ДОТ
475667	0	Проектная деятельность	лаб	4	3	2020-10-14				null	null	11	1455	6543	211
470623	0	Предпринимательство	лек	5	2	2020-10-13		https://us04web.zoom.us/j/74056835313?pwd=SWZydDdDU1dxSUFZYVpIa2R6OVQ1Zz09	�?дентификатор конференции: 740 5683 5313 Код доступа: 2VRJP5	null	null	0	7890	6543	ДОТ
475662	0	Предпринимательство	пр	5	3	2020-10-14				null	null	11	7890	6543	225
475680	0	Предпринимательство	пр	5	4	2020-10-15				null	null	11	7890	6543	227
475660	0	Предпринимательство	пр	6	3	2020-10-14				null	null	11	7890	6543	225
475678	0	Предпринимательство	пр	6	4	2020-10-15				null	null	11	7890	6543	227
372025	0	Разработка платформенных и кросплатформенных киберфизических систем	лаб	7	2	2020-10-13	Кибернетические и киберфизические системы			null	null	11	7251	6543	227
372031	0	Разработка платформенных и кросплатформенных киберфизических систем	лаб	8	2	2020-10-13	Кибернетические и киберфизические системы			null	null	11	7251	6543	227
\.


--
-- Data for Name: number_lesson_t; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.number_lesson_t (less, t_start, t_stop) FROM stdin;
8	T17:15:00-00:00	T18:45:00-00:00
2	T07:10:00-00:00	T08:40:00-00:00
5	T12:40:00-00:00	T13:50:00-00:00
1	T05:30:00-00:00	T07:00:00-00:00
4	T10:40:00-00:00	T12:10:00-00:00
7	T15:40:00-00:00	T17:10:00-00:00
3	T09:00:00-00:00	T10:30:00-00:00
6	T14:00:00-00:00	T15:30:00-00:00
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 1, false);


--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_role_id_seq', 1, false);


--
-- Name: auth_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_person_id_seq', 2, true);


--
-- Name: auth_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_role_id_seq', 1, false);


--
-- Name: list_corpus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.list_corpus_id_seq', 1, false);


--
-- Name: list_person_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.list_person_employee_id_seq', 1, false);


--
-- Name: list_person_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.list_person_group_id_seq', 3, true);


--
-- Name: number_lesson_t_less_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.number_lesson_t_less_seq', 1, false);


--
-- Name: list_division list_division_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_division
    ADD CONSTRAINT list_division_pkey PRIMARY KEY (id);


--
-- Name: list_group list_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_group
    ADD CONSTRAINT list_group_pkey PRIMARY KEY (id);


--
-- Name: list_schedule list_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_pkey PRIMARY KEY (id);


--
-- Name: list_division_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_division_id_idx ON public.list_division USING btree (id);


--
-- Name: list_group_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_code_idx ON public.list_group USING btree (code);


--
-- Name: list_group_course_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_course_idx ON public.list_group USING btree (course);


--
-- Name: list_group_id_division_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_id_division_idx ON public.list_group USING btree (id_division);


--
-- Name: list_group_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_id_idx ON public.list_group USING btree (id);


--
-- Name: list_group_title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_group_title_idx ON public.list_group USING btree (title);


--
-- Name: list_schedule_id_group_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_id_group_idx ON public.list_schedule USING btree (id_group);


--
-- Name: list_schedule_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_id_idx ON public.list_schedule USING btree (id);


--
-- Name: list_schedule_title_subject_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_title_subject_idx ON public.list_schedule USING btree (title_subject);


--
-- Name: list_schedule_type_lesson_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_schedule_type_lesson_idx ON public.list_schedule USING btree (type_lesson);


--
-- Name: list_group list_group_id_division_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_group
    ADD CONSTRAINT list_group_id_division_fkey FOREIGN KEY (id_division) REFERENCES public.list_division(id);


--
-- Name: list_schedule list_schedule_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_id_group_fkey FOREIGN KEY (id_group) REFERENCES public.list_group(id);


--
-- PostgreSQL database dump complete
--

