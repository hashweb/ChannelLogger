--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: logs_stats; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE logs_stats IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: action; Type: TYPE; Schema: public; Owner: jason
--

CREATE TYPE action AS ENUM (
    'message',
    'emote',
    'join',
    'part',
    'quit'
);


ALTER TYPE public.action OWNER TO jason;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: jason; Tablespace: 
--

CREATE TABLE channels (
    id integer NOT NULL,
    channel_name character varying NOT NULL
);


ALTER TABLE public.channels OWNER TO jason;

--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: jason
--

CREATE SEQUENCE channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.channels_id_seq OWNER TO jason;

--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jason
--

ALTER SEQUENCE channels_id_seq OWNED BY channels.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: jason; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    "user" integer NOT NULL,
    content text,
    action action,
    "timestamp" timestamp with time zone DEFAULT now(),
    channel_id integer
);


ALTER TABLE public.messages OWNER TO jason;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: jason
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO jason;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jason
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: user_count; Type: TABLE; Schema: public; Owner: jason; Tablespace: 
--

CREATE TABLE user_count (
    id integer NOT NULL,
    count integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT now(),
    channel_id integer
);


ALTER TABLE public.user_count OWNER TO jason;

--
-- Name: user_count_id_seq; Type: SEQUENCE; Schema: public; Owner: jason
--

CREATE SEQUENCE user_count_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_count_id_seq OWNER TO jason;

--
-- Name: user_count_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jason
--

ALTER SEQUENCE user_count_id_seq OWNED BY user_count.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: jason; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    "user" text,
    host character varying,
    in_use boolean DEFAULT true
);


ALTER TABLE public.users OWNER TO jason;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: jason
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO jason;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jason
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jason
--

ALTER TABLE ONLY channels ALTER COLUMN id SET DEFAULT nextval('channels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jason
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jason
--

ALTER TABLE ONLY user_count ALTER COLUMN id SET DEFAULT nextval('user_count_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jason
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: jason
--

COPY channels (id, channel_name) FROM stdin;
\.


--
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jason
--

SELECT pg_catalog.setval('channels_id_seq', 1, false);


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: jason
--

COPY messages (id, "user", content, action, "timestamp", channel_id) FROM stdin;
\.


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jason
--

SELECT pg_catalog.setval('messages_id_seq', 1, false);


--
-- Data for Name: user_count; Type: TABLE DATA; Schema: public; Owner: jason
--

COPY user_count (id, count, "timestamp", channel_id) FROM stdin;
\.


--
-- Name: user_count_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jason
--

SELECT pg_catalog.setval('user_count_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: jason
--

COPY users (id, "user", host, in_use) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jason
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: channels_pkey; Type: CONSTRAINT; Schema: public; Owner: jason; Tablespace: 
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: jason; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: user_count_pkey; Type: CONSTRAINT; Schema: public; Owner: jason; Tablespace: 
--

ALTER TABLE ONLY user_count
    ADD CONSTRAINT user_count_pkey PRIMARY KEY (id);


--
-- Name: users_id_key; Type: CONSTRAINT; Schema: public; Owner: jason; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_id_key UNIQUE (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

