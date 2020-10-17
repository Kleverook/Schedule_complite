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
    number_sub_gruop integer,
    title_subject text,
    type_lesson text,
    number_lesson integer,
    number_room text,
    day_week integer,
    date_lesson text,
    special text,
    link text,
    pass text,
    zoom_link text,
    zoom_password text,
    id_corpus integer,
    id_employee integer,
    id_group integer
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
90	mrdatman201	asdfgh0	sdfgfn	sfdg	{"accessToken":"ya29.a0AfH6SMCd0KGprlSF3pS4v7KdTAZhLIgNHOZILaOxQobtFZNcITsgaDRUpVBqH4FObx50Fdi6UiUkrLYZOTBiGg_w5DCYkPi0nuGIiZ76Bz8z6xhR3qTXGJrobUefj-bTVTslFJlFIpArIPkTOl5tLntCwDmMirt5uvo","refreshToken":"1//0czbXHIvh-x1CCgYIARAAGAwSNwF-L9IrKcokGfMGwUXoQmvHl9gI9p9w6EfVW2_0nZaEgQIdSWzx3JHcLmbxuMk8IgQPE7TW4Bo","expiresInSeconds":3533,"expirationTimeMilliseconds":1602904874413}	\N	7de450ed-5918-41e0-b79c-ddb810706ec6	2
89	mrdatman2014	Yps2psmgr	Игорь	Малофеев	{"accessToken":"ya29.a0AfH6SMDeqevCx3oTGTSH7ovFGSZXTMqxXgBWYBEGkkFhHGJXCGcYVI4JsoWT3YgfGSOdXWAfWcbxLy56s1PHt7BVfqYDd3uUtpu0r-jcoQn2IgPacKXDgzKo7ttBnOpfHaQKQsP6lYKU5UQJVKokdZ6Kbb4vz0wSoKPD","refreshToken":"1//0caJbOhYg-SIQCgYIARAAGAwSNwF-L9IrE4QsqjxPuePbwXiCYPXlAbcnFEPuuk1SLcR6zmvw755lHe-kQ-2TFVW_XNZiEaxKZkw","expiresInSeconds":3585,"expirationTimeMilliseconds":1602904848202}	\N	0c726f90-a3c0-4b6b-b3fe-51646f99b169	2
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
0		a	ул. Комсомольcкая, д. 95, Орёл, Орловская обл.
1	\N	a	ул. Комсомольская, д. 39а, Орёл, Орловская обл.
2	\N	a	ул. Комсомольская, д. 41, Орёл, Орловская обл.
3	\N	a	ул. Комсомольская, д. 95, Орёл, Орловская обл.
4	\N	a	ул. Октябрьская, д.25, Орёл, Орловская обл.
6	\N	a	ул. Ленина, д. 6а, Орёл, Орловская обл.
5	\N	a	ул. Ленина, д. 6а, Орёл, Орловская обл.
7	\N	a	пер. Воскресенский, д. 3, Орёл, Орловская обл.
8	\N	a	ул. Комсомольская, д. 39б, Орёл, Орловская обл.
9	\N	a	ул. Московская, д. 159а, Орёл, Орловская обл.
10	\N	a	ул. Комсомольская, д. 41, Орёл, Орловская обл.
11	\N	a	Наугорское шоссе, д. 29, Орёл, Орловская обл.
17	\N	a	ул. Комсомольcкая, д. 95, Орёл, Орловская обл.\r\nул. Комсомольская, д. 39а, Орёл, Орловская обл.\r\nул. Комсомольская, д. 41, Орёл, Орловская обл.\r\nул. Комсомольская, д. 95, Орёл, Орловская обл.\r\nул. Октябрьская, д.25, Орёл, Орловская обл.\r\nул. Ленина, д. 6а, Орёл, Орловская обл.\r\nпер. Воскресенский, д. 3, Орёл, Орловская обл.\r\nул. Комсомольская, д. 39б, Орёл, Орловская обл.\r\nул. Московская, д. 159а, Орёл, Орловская обл.\r\nул. Комсомольская, д. 41, Орёл, Орловская обл.\r\nНаугорское шоссе, д. 29, Орёл, Орловская обл.\r\nНаугорское шоссе, д. 40, Орёл, Орловская обл.\r\nул. Московская, д. 65, Орёл, Орловская обл.\r\nпер. Артельный, д. 5, Орёл, Орловская обл.\r\nул. Московская, д.34, Орёл, Орловская обл.\r\nул. Московская, д. 77, Орёл, Орловская обл.
12	\N	a	Наугорское шоссе, д. 40, Орёл, Орловская обл.
13	\N	a	ул. Московская, д. 65, Орёл, Орловская обл.
14	\N	a	пер. Артельный, д. 5, Орёл, Орловская обл.
15	\N	a	ул. Московская, д.34, Орёл, Орловская обл.
16	\N	a	ул. Московская, д. 77, Орёл, Орловская обл.
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
7194	2	91Бз	06.03.01З (а) (о)	бакалавриат	152
7195	2	91Бм	06.03.01М (а) (о)	бакалавриат	152
6871	2	91Г	05.03.02 (а) (о)	бакалавриат	152
7192	2	91ПГОбг	44.03.05БГ (б) (о)	бакалавриат	152
7193	2	91ПГОхбж	44.03.05ЕН (б) (о)	бакалавриат	152
7005	2	91ПЧ	06.03.02 (а) (о)	бакалавриат	152
6872	2	91ТБ	20.03.01 (а) (о)	бакалавриат	152
7191	2	91Х	04.03.01 (б) (о)	бакалавриат	152
7006	2	91ЭП	05.03.06 (п) (о)	бакалавриат	152
7303	2	92ПГОбг	44.03.05БГ (б) (о)	бакалавриат	152
7082	2	91Бб-м	06.04.01Б (м) (о)	магистратура	152
7081	2	91Ббф-м	06.04.01БФ (м) (о)	магистратура	152
6896	2	91Г-м	05.04.02 (м) (о)	магистратура	152
7083	2	91ПГОбж-м	44.04.01БЖ (м) (о)	магистратура	152
7084	2	91ПГОен-м	44.04.01ЕН (м) (о)	магистратура	152
6898	2	91ПЧ-м	06.04.02 (м) (о)	магистратура	152
6910	2	91ТБ-м	20.04.01 (м) (о)	магистратура	152
7287	2	91Х-м	04.04.01 (м) (о)	магистратура	152
6897	2	91ЭП-м	05.04.06 (м) (о)	магистратура	152
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
7513	1	01АР	07.03.01 (б) (о)	бакалавриат	5
7525	1	01ГС	07.03.04 (б) (о)	бакалавриат	5
7514	1	01С	08.03.01 (б) (о)	бакалавриат	5
7369	1	01ТБ	20.03.01 (а) (о)	бакалавриат	5
7455	1	01АР-м	07.04.01 (м) (о)	магистратура	5
7604	1	01С-м	08.04.01 (м) (о)	магистратура	5
7593	1	01СУ	08.05.01 (с) (о)	специалитет	5
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
53	89	6441	f
55	90	6543	f
56	90	7514	f
\.


--
-- Data for Name: list_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.list_schedule (id, number_sub_gruop, title_subject, type_lesson, number_lesson, number_room, day_week, date_lesson, special, link, pass, zoom_link, zoom_password, id_corpus, id_employee, id_group) FROM stdin;
458839	0	Разработка платформенных и кросплатформенных киберфизических систем	конс	2	205	6	2020-10-17	Кибернетические и киберфизические системы			null	null	11	3692	6543
470621	0	Предпринимательство	лек	4	Р”РћРў	2	2020-10-13		https://us04web.zoom.us/j/74056835313?pwd=SWZydDdDU1dxSUFZYVpIa2R6OVQ1Zz09	�?дентификатор конференции: 740 5683 5313 Код доступа: 2VRJP5	null	null	0	7890	6543
355430	0	Модуль элективных дисциплин по физической культуре и спорту	пр	2	РЎРїРѕСЂС‚Р·Р°Р»	1	2020-10-12	Рекреационная география и туризм			null	null	3	7725	6871
457434	0	Геоморфология	пр	2	Р”РћРў	2	2020-10-13				null	null	0	6618	6871
457438	0	Геоморфология	пр	2	304	3	2020-10-14				null	null	1	6618	6871
355402	0	Модуль элективных дисциплин по физической культуре и спорту	пр	2	РЎРїРѕСЂС‚Р·Р°Р»	4	2020-10-15	Рекреационная география и туризм			null	null	3	7725	6871
403688	0	Философия	лек	2	Р”РћРў	6	2020-10-17		https://zoom.us/j/92994709231		null	null	0	6702	6871
327331	0	Технология продукции общественного питания	лаб	4	206Р»	5	2020-10-16				 	 	11	1786	6441
309399	0	Модуль элективных дисциплин по физической культуре и спорту	пр	1	Спортзал	1	2020-10-12	Общий профиль			null	null	11	1402	7514
309410	0	Модуль элективных дисциплин по физической культуре и спорту	пр	1	Спортзал	4	2020-10-15	Общий профиль			null	null	11	1402	7514
475667	0	Проектная деятельность	лаб	4	211	3	2020-10-14				null	null	11	1455	6543
464770	0	Основы зоогеографии	лек	5	Р”РћРў	4	2020-10-15	Рекреационная география и туризм	https://us04web.zoom.us/j/9345561417?	UzlqNUZvSE16MmxDRkwrb2V0Y2VSQT09	null	null	0	6610	6871
327000	0	Безопасность продовольственного сырья и продуктов питания	лек	1	221Р»	1	2020-10-12		&amp;#65279;Евгения Хмелева приглашает вас на запланированную конференцию: Zoom.  Тема: лекция 12.10 Время: Это регулярная конференция Начать в любое время  Подключиться к конференции Zoom https://us04web.zoom.us/j/76690905536?pwd=dnExdUJJVnEyRzB3aGpnd2pL		null	null	0	1722	6441
390758	0	Социальное питание	лек	2	221Р»	1	2020-10-12	Технология и организация ресторанного дела	&amp;#65279;Татьяна Серегина приглашает вас на запланированную конференцию: Zoom.  Тема: лекция 9 Социальное питание Время: Это регулярная конференция Начать в любое время  Подключиться к конференции Zoom https://us04web.zoom.us/j/72228646474?pwd=TThvSkZU	Код доступа: 6bkn7U	null	null	11	6821	6441
327020	0	Организация производства и обслуживания на предприятиях общественного питания	лек	2	206Р»	3	2020-10-14		Подключиться к конференции Zoom https://us04web.zoom.us/j/72344723706?pwd=N3A4MU1zVzFPOHByeVlKNWpnK0ljZz09  �?дентификатор конференции: 723 4472 3706 Код доступа: zy2K5i		null	null	0	1042	6441
390806	0	Социальное питание	лаб	5	206Р»	1	2020-10-12	Технология и организация ресторанного дела			null	null	11	6821	6441
314297	0	�?нженерная геология	лек	1	ДОТ	2	2020-10-13		Подключиться к конференции Zoom https://us04web.zoom.us/j/77798460955?pwd=RXdHcWV1dmVNR0ZtVDNKdHFkWkNsZz09	�?дентификатор конференции: 777 9846 0955 Код доступа: 3PsKWH	null	null	0	3096	7514
475798	0	�?стория (история России, всеобщая история)	лек	1	ДОТ	5	2020-10-16		https://us04web.zoom.us/j/78503174172?pwd=amdmMjRlMllFaVprc3RmNmdtd0tkQT09		null	null	0	6201	7514
372339	0	�?нженерная геодезия	лек	1	ДОТ	6	2020-10-17		Подключиться к конференции Zoom https://us04web.zoom.us/j/71403891555?pwd=K3NDZE5FTTJTa0xVcVVzc1pvaTluQT09	�?дентификатор конференции: 714 0389 1555 Код доступа: x75FUG	null	null	0	3096	7514
428080	1	�?ностранный язык	пр	2	408	1	2020-10-12				null	null	11	3817	7514
314277	0	�?нженерная геодезия	лек	2	ДОТ	2	2020-10-13		Подключиться к конференции Zoom https://us04web.zoom.us/j/76613855938?pwd=dUNjMS92N2VmVEZkaTZPNXVSQ2NYUT09	�?дентификатор конференции: 766 1385 5938 Код доступа: 3QE4Ze	null	null	0	3096	7514
324284	0	Безопасность жизнедеятельности	лек	2	225Р»	2	2020-10-13		Подключиться к конференции Zoom https://us04web.zoom.us/j/5680649736?pwd=icNmQtrAoxODQxaO_L7Z4ofBZ1_L5Q	�?дентификатор конференции: 568 064 9736 Код доступа: 5UN42a	 	 	0	5734	6441
480186	0	�?ностранный язык	пр	2	111	3	2020-10-14				null	null	3	5832	7514
428447	1	�?ностранный язык	пр	2	408	4	2020-10-15				null	null	11	3817	7514
313733	0	Физика	лек	2	ДОТ	5	2020-10-16				null	null	0	757	7514
372044	0	Материаловедение	лек	2	ДОТ	6	2020-10-17		https://us04web.zoom.us/j/74335580572?pwd=TGR5ZG1NV0hHK3F5b1dzQWlqVmUwQT09	7zhYZL	null	null	0	63	7514
314350	0	�?нженерная геология	пр	3	223	1	2020-10-12				null	null	16	3096	7514
427642	1	�?нженерная геодезия	лаб	3	231	3	2020-10-14				null	null	16	993	7514
427618	2	�?нженерная геодезия	лаб	3	231	3	2020-10-14				null	null	16	3096	7514
371887	0	Русский язык и культура речи	пр	3	230	4	2020-10-15				null	null	16	5731	7514
395901	0	Основы геоботаники	пр	3	305	1	2020-10-12	Рекреационная география и туризм			null	null	1	6672	6871
395912	0	Основы геоботаники	пр	4	305	1	2020-10-12	Рекреационная география и туризм			null	null	1	6672	6871
363538	0	�?ностранный язык	пр	4	305	2	2020-10-13				null	null	4	6106	6871
464754	0	География почв с основами почвоведения	лек	4	Р”РћРў	4	2020-10-15				null	null	0	6594	6871
314305	0	Материаловедение	лек	3	ДОТ	6	2020-10-17		https://us04web.zoom.us/j/74335580572?pwd=TGR5ZG1NV0hHK3F5b1dzQWlqVmUwQT09	7zhYZL	null	null	0	63	7514
427654	1	�?нженерная геодезия	лаб	4	231	3	2020-10-14				null	null	16	993	7514
427630	2	�?нженерная геодезия	лаб	4	231	3	2020-10-14				null	null	16	3096	7514
314327	0	Высшая математика	пр	4	223	4	2020-10-15				null	null	16	1018	7514
427788	1	Начертательная геометрия и инженерная графика	лаб	4	406	5	2020-10-16				null	null	11	219	7514
427836	2	Начертательная геометрия и инженерная графика	лаб	4	406	5	2020-10-16				null	null	11	5517	7514
454679	0	Русский язык и культура речи	пр	5	229	2	2020-10-13				null	null	16	5731	7514
314316	0	Высшая математика	пр	5	218	3	2020-10-14				null	null	16	1018	7514
480161	0	�?ностранный язык	пр	5	112	4	2020-10-15				null	null	3	5832	7514
427776	1	Начертательная геометрия и инженерная графика	лаб	5	406	5	2020-10-16				null	null	11	219	7514
427808	2	Начертательная геометрия и инженерная графика	лаб	5	406	5	2020-10-16				null	null	11	5517	7514
371933	0	�?стория (история России, всеобщая история)	пр	6	231	2	2020-10-13				null	null	16	6823	7514
475662	0	Предпринимательство	пр	5	225	3	2020-10-14				null	null	11	7890	6543
475680	0	Предпринимательство	пр	5	227	4	2020-10-15				null	null	11	7890	6543
475660	0	Предпринимательство	пр	6	225	3	2020-10-14				null	null	11	7890	6543
372810	0	Предпринимательство	лаб	2	205	1	2020-10-12				null	null	11	7890	6543
470623	0	Предпринимательство	лек	5	Р”РћРў	2	2020-10-13		https://us04web.zoom.us/j/74056835313?pwd=SWZydDdDU1dxSUFZYVpIa2R6OVQ1Zz09	�?дентификатор конференции: 740 5683 5313 Код доступа: 2VRJP5	null	null	0	7890	6543
475678	0	Предпринимательство	пр	6	227	4	2020-10-15				null	null	11	7890	6543
372025	0	Разработка платформенных и кросплатформенных киберфизических систем	лаб	7	227	2	2020-10-13	Кибернетические и киберфизические системы			null	null	11	7251	6543
372031	0	Разработка платформенных и кросплатформенных киберфизических систем	лаб	8	227	2	2020-10-13	Кибернетические и киберфизические системы			null	null	11	7251	6543
405140	0	�?ностранный язык	пр	1	304	1	2020-10-12				null	null	1	7279	6871
327298	0	Организация производства и обслуживания на предприятиях общественного питания	лаб	2	206Р»	6	2020-10-17				null	null	11	1042	6441
464392	0	Менеджмент и маркетинг	лек	3	240Р»	2	2020-10-13				null	null	0	3932	6441
327348	0	Безопасность продовольственного сырья и продуктов питания	лаб	3	207Р»	4	2020-10-15				null	null	11	1722	6441
327321	0	Технология продукции общественного питания	лаб	3	206Р»	5	2020-10-16				 	 	11	1786	6441
390813	0	Социальное питание	лаб	4	206Р»	1	2020-10-12	Технология и организация ресторанного дела			null	null	11	6821	6441
327340	0	Безопасность продовольственного сырья и продуктов питания	лаб	4	207Р»	4	2020-10-15				null	null	11	1722	6441
372801	0	Предпринимательство	лаб	3	205	1	2020-10-12				null	null	11	7890	6543
475665	0	Проектная деятельность	лаб	3	211	3	2020-10-14				null	null	11	1455	6543
327372	0	Технология продукции общественного питания	лек	1	206Р»	3	2020-10-14		https://us04web.zoom.us/j/6912086904?pwd=dURFUGRmNWpMaFp4U2x4NFRaWUpVQT09  �?дентификатор конференции: 691 208 6904	5BqztR	 	 	11	1786	6441
327290	0	Организация производства и обслуживания на предприятиях общественного питания	лаб	1	206Р»	6	2020-10-17				null	null	11	1042	6441
326374	0	Менеджмент и маркетинг	пр	2	239Р»	4	2020-10-15				null	null	11	3932	6441
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

SELECT pg_catalog.setval('public.auth_permission_id_seq', 1, true);


--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_role_id_seq', 1, true);


--
-- Name: auth_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_person_id_seq', 90, true);


--
-- Name: auth_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_role_id_seq', 2, true);


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

SELECT pg_catalog.setval('public.list_person_group_id_seq', 56, true);


--
-- Name: number_lesson_t_less_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.number_lesson_t_less_seq', 1, false);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_role auth_permission_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role
    ADD CONSTRAINT auth_permission_role_pkey PRIMARY KEY (id);


--
-- Name: auth_person auth_person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_person
    ADD CONSTRAINT auth_person_pkey PRIMARY KEY (id);


--
-- Name: auth_role auth_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_role
    ADD CONSTRAINT auth_role_pkey PRIMARY KEY (id);


--
-- Name: list_corpus list_corpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_corpus
    ADD CONSTRAINT list_corpus_pkey PRIMARY KEY (id);


--
-- Name: list_department list_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_department
    ADD CONSTRAINT list_department_pkey PRIMARY KEY (id);


--
-- Name: list_division list_division_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_division
    ADD CONSTRAINT list_division_pkey PRIMARY KEY (id);


--
-- Name: list_employee list_employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_employee
    ADD CONSTRAINT list_employee_pkey PRIMARY KEY (id);


--
-- Name: list_group list_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_group
    ADD CONSTRAINT list_group_pkey PRIMARY KEY (id);


--
-- Name: list_person_employee list_person_employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_employee
    ADD CONSTRAINT list_person_employee_pkey PRIMARY KEY (id);


--
-- Name: list_person_group list_person_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_group
    ADD CONSTRAINT list_person_group_pkey PRIMARY KEY (id);


--
-- Name: list_schedule list_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_pkey PRIMARY KEY (id);


--
-- Name: number_lesson_t number_lesson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.number_lesson_t
    ADD CONSTRAINT number_lesson PRIMARY KEY (less);


--
-- Name: auth_permission_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_id_idx ON public.auth_permission USING btree (id);


--
-- Name: auth_permission_role_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_role_id_idx ON public.auth_permission_role USING btree (id);


--
-- Name: auth_permission_role_id_permission_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_role_id_permission_idx ON public.auth_permission_role USING btree (id_permission);


--
-- Name: auth_permission_role_id_role_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_role_id_role_idx ON public.auth_permission_role USING btree (id_role);


--
-- Name: auth_person_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_id_idx ON public.auth_person USING btree (id);


--
-- Name: auth_person_id_role_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_id_role_idx ON public.auth_person USING btree (id_role);


--
-- Name: auth_person_login_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_login_idx ON public.auth_person USING btree (login);


--
-- Name: auth_person_login_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_login_key_idx ON public.auth_person USING btree (login_key);


--
-- Name: auth_person_phone_number_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_person_phone_number_idx ON public.auth_person USING btree (phone_number);


--
-- Name: auth_role_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_role_id_idx ON public.auth_role USING btree (id);


--
-- Name: auth_role_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_role_name_idx ON public.auth_role USING btree (name);


--
-- Name: list_corpus_addres_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_corpus_addres_idx ON public.list_corpus USING btree (addres);


--
-- Name: list_corpus_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_corpus_id_idx ON public.list_corpus USING btree (id);


--
-- Name: list_corpus_short_title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_corpus_short_title_idx ON public.list_corpus USING btree (short_title);


--
-- Name: list_corpus_title_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_corpus_title_idx ON public.list_corpus USING btree (title);


--
-- Name: list_department_id_division_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_department_id_division_idx ON public.list_department USING btree (id_division);


--
-- Name: list_department_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_department_id_idx ON public.list_department USING btree (id);


--
-- Name: list_division_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_division_id_idx ON public.list_division USING btree (id);


--
-- Name: list_employee_id_department_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_id_department_idx ON public.list_employee USING btree (id_department);


--
-- Name: list_employee_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_id_idx ON public.list_employee USING btree (id);


--
-- Name: list_employee_middle_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_middle_name_idx ON public.list_employee USING btree (middle_name);


--
-- Name: list_employee_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_name_idx ON public.list_employee USING btree (name);


--
-- Name: list_employee_subname_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_employee_subname_idx ON public.list_employee USING btree (subname);


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
-- Name: list_person_employee_id_employee_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_employee_id_employee_idx ON public.list_person_employee USING btree (id_employee);


--
-- Name: list_person_employee_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_employee_id_idx ON public.list_person_employee USING btree (id);


--
-- Name: list_person_employee_id_person_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_employee_id_person_idx ON public.list_person_employee USING btree (id_person);


--
-- Name: list_person_group_id_group_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_group_id_group_idx ON public.list_person_group USING btree (id_group);


--
-- Name: list_person_group_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_group_id_idx ON public.list_person_group USING btree (id);


--
-- Name: list_person_group_id_person_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX list_person_group_id_person_idx ON public.list_person_group USING btree (id_person);


--
-- Name: auth_permission_role auth_permission_role_id_permission_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role
    ADD CONSTRAINT auth_permission_role_id_permission_fkey FOREIGN KEY (id_permission) REFERENCES public.auth_permission(id);


--
-- Name: auth_permission_role auth_permission_role_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role
    ADD CONSTRAINT auth_permission_role_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.auth_role(id);


--
-- Name: auth_person auth_person_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_person
    ADD CONSTRAINT auth_person_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.auth_role(id);


--
-- Name: list_department list_department_id_division_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_department
    ADD CONSTRAINT list_department_id_division_fkey FOREIGN KEY (id_division) REFERENCES public.list_division(id);


--
-- Name: list_employee list_employee_id_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_employee
    ADD CONSTRAINT list_employee_id_department_fkey FOREIGN KEY (id_department) REFERENCES public.list_department(id);


--
-- Name: list_group list_group_id_division_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_group
    ADD CONSTRAINT list_group_id_division_fkey FOREIGN KEY (id_division) REFERENCES public.list_division(id);


--
-- Name: list_person_employee list_person_employee_id_employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_employee
    ADD CONSTRAINT list_person_employee_id_employee_fkey FOREIGN KEY (id_employee) REFERENCES public.list_employee(id);


--
-- Name: list_person_employee list_person_employee_id_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_employee
    ADD CONSTRAINT list_person_employee_id_person_fkey FOREIGN KEY (id_person) REFERENCES public.auth_person(id);


--
-- Name: list_person_group list_person_group_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_group
    ADD CONSTRAINT list_person_group_id_group_fkey FOREIGN KEY (id_group) REFERENCES public.list_group(id);


--
-- Name: list_person_group list_person_group_id_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_person_group
    ADD CONSTRAINT list_person_group_id_person_fkey FOREIGN KEY (id_person) REFERENCES public.auth_person(id);


--
-- Name: list_schedule list_schedule_id_corpus_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_id_corpus_fkey FOREIGN KEY (id_corpus) REFERENCES public.list_corpus(id);


--
-- Name: list_schedule list_schedule_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_schedule
    ADD CONSTRAINT list_schedule_id_group_fkey FOREIGN KEY (id_group) REFERENCES public.list_group(id);


--
-- PostgreSQL database dump complete
--

