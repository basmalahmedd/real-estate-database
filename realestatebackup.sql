--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agent (
    agent_id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone character varying(20) NOT NULL,
    email character varying(100),
    commission_percent numeric(5,2),
    CONSTRAINT agent_commission_percent_check CHECK ((commission_percent > (0)::numeric))
);


ALTER TABLE public.agent OWNER TO postgres;

--
-- Name: agent_agent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agent_agent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agent_agent_id_seq OWNER TO postgres;

--
-- Name: agent_agent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agent_agent_id_seq OWNED BY public.agent.agent_id;


--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    client_id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone character varying(20) NOT NULL,
    email character varying(100),
    budget numeric(12,2),
    CONSTRAINT client_budget_check CHECK ((budget >= (0)::numeric))
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_client_id_seq OWNER TO postgres;

--
-- Name: client_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_client_id_seq OWNED BY public.client.client_id;


--
-- Name: property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.property (
    property_id integer NOT NULL,
    address text NOT NULL,
    price numeric(12,2),
    bedrooms integer,
    bathrooms integer,
    status character varying(20),
    agent_id integer,
    CONSTRAINT property_bathrooms_check CHECK ((bathrooms > 0)),
    CONSTRAINT property_bedrooms_check CHECK ((bedrooms > 0)),
    CONSTRAINT property_price_check CHECK ((price > (0)::numeric)),
    CONSTRAINT property_status_check CHECK (((status)::text = ANY ((ARRAY['Available'::character varying, 'Sold'::character varying])::text[])))
);


ALTER TABLE public.property OWNER TO postgres;

--
-- Name: property_property_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.property_property_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.property_property_id_seq OWNER TO postgres;

--
-- Name: property_property_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.property_property_id_seq OWNED BY public.property.property_id;


--
-- Name: sale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale (
    sale_id integer NOT NULL,
    sale_date date NOT NULL,
    sale_price numeric(12,2),
    property_id integer,
    agent_id integer,
    client_id integer,
    CONSTRAINT sale_sale_price_check CHECK ((sale_price > (0)::numeric))
);


ALTER TABLE public.sale OWNER TO postgres;

--
-- Name: sale_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sale_sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sale_sale_id_seq OWNER TO postgres;

--
-- Name: sale_sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sale_sale_id_seq OWNED BY public.sale.sale_id;


--
-- Name: viewing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.viewing (
    viewing_id integer NOT NULL,
    viewing_date date NOT NULL,
    property_id integer,
    client_id integer
);


ALTER TABLE public.viewing OWNER TO postgres;

--
-- Name: viewing_viewing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.viewing_viewing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.viewing_viewing_id_seq OWNER TO postgres;

--
-- Name: viewing_viewing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.viewing_viewing_id_seq OWNED BY public.viewing.viewing_id;


--
-- Name: agent agent_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agent ALTER COLUMN agent_id SET DEFAULT nextval('public.agent_agent_id_seq'::regclass);


--
-- Name: client client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN client_id SET DEFAULT nextval('public.client_client_id_seq'::regclass);


--
-- Name: property property_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.property ALTER COLUMN property_id SET DEFAULT nextval('public.property_property_id_seq'::regclass);


--
-- Name: sale sale_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale ALTER COLUMN sale_id SET DEFAULT nextval('public.sale_sale_id_seq'::regclass);


--
-- Name: viewing viewing_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viewing ALTER COLUMN viewing_id SET DEFAULT nextval('public.viewing_viewing_id_seq'::regclass);


--
-- Data for Name: agent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.agent (agent_id, name, phone, email, commission_percent) FROM stdin;
1	John Doe	555-1234	john@example.com	2.50
2	Jane Smith	555-5678	jane@example.com	3.00
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (client_id, name, phone, email, budget) FROM stdin;
1	Alice Brown	555-1111	alice@example.com	500000.00
2	Bob Green	555-2222	bob@example.com	750000.00
\.


--
-- Data for Name: property; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.property (property_id, address, price, bedrooms, bathrooms, status, agent_id) FROM stdin;
1	123 Main St	250000.00	3	2	Available	1
2	456 Oak Ave	300000.00	4	3	Sold	2
\.


--
-- Data for Name: sale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sale (sale_id, sale_date, sale_price, property_id, agent_id, client_id) FROM stdin;
1	2023-10-20	300000.00	2	2	2
\.


--
-- Data for Name: viewing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.viewing (viewing_id, viewing_date, property_id, client_id) FROM stdin;
1	2023-10-15	1	1
2	2023-10-16	2	2
\.


--
-- Name: agent_agent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.agent_agent_id_seq', 2, true);


--
-- Name: client_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_client_id_seq', 2, true);


--
-- Name: property_property_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.property_property_id_seq', 2, true);


--
-- Name: sale_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sale_sale_id_seq', 1, true);


--
-- Name: viewing_viewing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.viewing_viewing_id_seq', 2, true);


--
-- Name: agent agent_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_email_key UNIQUE (email);


--
-- Name: agent agent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_pkey PRIMARY KEY (agent_id);


--
-- Name: client client_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_email_key UNIQUE (email);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (client_id);


--
-- Name: property property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_pkey PRIMARY KEY (property_id);


--
-- Name: sale sale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT sale_pkey PRIMARY KEY (sale_id);


--
-- Name: sale sale_property_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT sale_property_id_key UNIQUE (property_id);


--
-- Name: viewing viewing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viewing
    ADD CONSTRAINT viewing_pkey PRIMARY KEY (viewing_id);


--
-- Name: property property_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(agent_id);


--
-- Name: sale sale_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT sale_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agent(agent_id);


--
-- Name: sale sale_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT sale_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(client_id);


--
-- Name: sale sale_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT sale_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);


--
-- Name: viewing viewing_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viewing
    ADD CONSTRAINT viewing_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(client_id);


--
-- Name: viewing viewing_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viewing
    ADD CONSTRAINT viewing_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);


--
-- PostgreSQL database dump complete
--

