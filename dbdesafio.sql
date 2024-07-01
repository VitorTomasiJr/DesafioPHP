--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id integer NOT NULL,
    descricao character varying(255) NOT NULL,
    produto_tipo_id integer NOT NULL,
    preco numeric(10,2) NOT NULL,
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- Name: produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produto_id_seq OWNER TO postgres;

--
-- Name: produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;


--
-- Name: produto_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto_tipo (
    id integer NOT NULL,
    descricao character varying(255) NOT NULL,
    perc_imposto numeric(5,2) NOT NULL,
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL
);


ALTER TABLE public.produto_tipo OWNER TO postgres;

--
-- Name: produto_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_tipo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produto_tipo_id_seq OWNER TO postgres;

--
-- Name: produto_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produto_tipo_id_seq OWNED BY public.produto_tipo.id;


--
-- Name: venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda (
    id integer NOT NULL,
    total_venda numeric(10,2) NOT NULL,
    total_imposto numeric(10,2) NOT NULL
);


ALTER TABLE public.venda OWNER TO postgres;

--
-- Name: venda_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venda_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venda_id_seq OWNER TO postgres;

--
-- Name: venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venda_id_seq OWNED BY public.venda.id;


--
-- Name: venda_itens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda_itens (
    id integer NOT NULL,
    venda_id integer NOT NULL,
    produto_id integer NOT NULL,
    quantidade numeric(10,2) NOT NULL,
    preco_unitario numeric(10,2) NOT NULL,
    perc_imposto numeric(10,2) NOT NULL
);


ALTER TABLE public.venda_itens OWNER TO postgres;

--
-- Name: venda_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venda_itens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venda_itens_id_seq OWNER TO postgres;

--
-- Name: venda_itens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venda_itens_id_seq OWNED BY public.venda_itens.id;


--
-- Name: produto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);


--
-- Name: produto_tipo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto_tipo ALTER COLUMN id SET DEFAULT nextval('public.produto_tipo_id_seq'::regclass);


--
-- Name: venda id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda ALTER COLUMN id SET DEFAULT nextval('public.venda_id_seq'::regclass);


--
-- Name: venda_itens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_itens ALTER COLUMN id SET DEFAULT nextval('public.venda_itens_id_seq'::regclass);


--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (id, descricao, produto_tipo_id, preco, ativo) FROM stdin;
8	Prod 001	7	65.00	S
9	Prod 002	9	32.00	S
10	Prod 003	7	11.00	N
11	Prod 004	10	23.00	S
\.


--
-- Data for Name: produto_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto_tipo (id, descricao, perc_imposto, ativo) FROM stdin;
7	Tipo 001	2.63	S
8	Tipo 002	2.45	N
9	Tipo 002	32.00	S
10	Tipo 015	10.00	S
\.


--
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venda (id, total_venda, total_imposto) FROM stdin;
26	241.50	40.48
27	230.00	23.00
28	65.00	1.71
\.


--
-- Data for Name: venda_itens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario, perc_imposto) FROM stdin;
28	26	8	1.00	65.00	2.63
29	26	9	3.00	32.00	32.00
30	26	11	3.50	23.00	10.00
31	27	11	10.00	23.00	10.00
32	28	8	1.00	65.00	2.63
\.


--
-- Name: produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_id_seq', 11, true);


--
-- Name: produto_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_tipo_id_seq', 10, true);


--
-- Name: venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venda_id_seq', 28, true);


--
-- Name: venda_itens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venda_itens_id_seq', 32, true);


--
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- Name: produto_tipo produto_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto_tipo
    ADD CONSTRAINT produto_tipo_pkey PRIMARY KEY (id);


--
-- Name: venda_itens venda_itens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_itens
    ADD CONSTRAINT venda_itens_pkey PRIMARY KEY (id);


--
-- Name: venda venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id);


--
-- Name: produto produto_produto_tipo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_produto_tipo_id_fkey FOREIGN KEY (produto_tipo_id) REFERENCES public.produto_tipo(id);


--
-- Name: venda_itens venda_itens_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_itens
    ADD CONSTRAINT venda_itens_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- Name: venda_itens venda_itens_venda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_itens
    ADD CONSTRAINT venda_itens_venda_id_fkey FOREIGN KEY (venda_id) REFERENCES public.venda(id);


--
-- PostgreSQL database dump complete
--

