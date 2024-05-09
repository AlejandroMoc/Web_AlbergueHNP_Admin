PGDMP  1                    |            gestionAlbergue3    16.2    16.2 c    L           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            M           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            N           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            O           1262    25583    gestionAlbergue3    DATABASE     ~   CREATE DATABASE "gestionAlbergue3" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
 "   DROP DATABASE "gestionAlbergue3";
                postgres    false                        2615    25584    pgagent    SCHEMA        CREATE SCHEMA pgagent;
    DROP SCHEMA pgagent;
                postgres    false            P           0    0    SCHEMA pgagent    COMMENT     6   COMMENT ON SCHEMA pgagent IS 'pgAgent system tables';
                   postgres    false    7                        3079    25585    pgagent 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgagent WITH SCHEMA pgagent;
    DROP EXTENSION pgagent;
                   false    7            Q           0    0    EXTENSION pgagent    COMMENT     >   COMMENT ON EXTENSION pgagent IS 'A PostgreSQL job scheduler';
                        false    2                       1255    25743    calcular_deuda_cliente(integer)    FUNCTION       CREATE FUNCTION public.calcular_deuda_cliente(cliente_id integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE 
    deuda DECIMAL(10, 2);
BEGIN
    SELECT SUM(monto_T)
    INTO deuda
    FROM Pago
    WHERE id_Cliente = cliente_id;

    RETURN deuda;
END;
$$;
 A   DROP FUNCTION public.calcular_deuda_cliente(cliente_id integer);
       public          postgres    false                       1255    25744 )   calcular_suma_servicios_por_tipo(integer)    FUNCTION     �  CREATE FUNCTION public.calcular_suma_servicios_por_tipo(id_cliente integer) RETURNS TABLE(servicio1 integer, servicio2 integer, servicio3 integer, servicio4 integer, servicio5 integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
BEGIN
    -- Inicializar todas las variables a 0
    servicio1 := 0;
    servicio2 := 0;
    servicio3 := 0;
    servicio4 := 0;
    servicio5 := 0;

    -- Obtener la cantidad de servicios por tipo
    FOR rec IN SELECT id_Servicio, SUM(cant) AS suma_cantidades
               FROM "servcliente" sc
               WHERE sc.id_Cliente = calcular_suma_servicios_por_tipo.id_cliente
               GROUP BY id_Servicio
    LOOP
        -- Asignar la cantidad correspondiente a la columna de servicio adecuada
        CASE rec.id_Servicio
            WHEN 1 THEN servicio1 := rec.suma_cantidades;
            WHEN 2 THEN servicio2 := rec.suma_cantidades;
            WHEN 3 THEN servicio3 := rec.suma_cantidades;
            WHEN 4 THEN servicio4 := rec.suma_cantidades;
            WHEN 5 THEN servicio5 := rec.suma_cantidades;
        END CASE;
    END LOOP;

    -- Devolver la fila con las cantidades de servicios por tipo
    RETURN NEXT;
END;
$$;
 K   DROP FUNCTION public.calcular_suma_servicios_por_tipo(id_cliente integer);
       public          postgres    false                       1255    25745    gencargodiario_proc() 	   PROCEDURE     
  CREATE PROCEDURE public.gencargodiario_proc()
    LANGUAGE plpgsql
    AS $$
	DECLARE
	BEGIN
		INSERT INTO pago (id_cliente, notas_p, monto_t, fecha_p)
		SELECT id_cliente, 'Cobro Automático Diario', -20.00, NOW()
		FROM huesped
		WHERE fecha_s IS NULL;
	END;
	$$;
 -   DROP PROCEDURE public.gencargodiario_proc();
       public          postgres    false                       1255    25746 '   genservcliente_proc(integer, integer[]) 	   PROCEDURE       CREATE PROCEDURE public.genservcliente_proc(IN cliente_id integer, IN listservice integer[])
    LANGUAGE plpgsql
    AS $$
DECLARE
servicio_info INT[];
servicio_id INT;
cantidad INT;
BEGIN
FOREACH servicio_info SLICE 1 IN ARRAY listService
LOOP
servicio_id := servicio_info[1];
cantidad := servicio_info[2];
IF cantidad > 0 THEN
INSERT INTO "servcliente" ("id_cliente", "id_servicio", "cant", "fecha_u", "tipo_cliente")
VALUES (cliente_id, servicio_id, cantidad, CURRENT_TIMESTAMP, FALSE);
END IF;
END LOOP;
END;
$$;
 \   DROP PROCEDURE public.genservcliente_proc(IN cliente_id integer, IN listservice integer[]);
       public          postgres    false                       1255    25747 .   genservcliente_prochuesped(integer, integer[]) 	   PROCEDURE       CREATE PROCEDURE public.genservcliente_prochuesped(IN cliente_id integer, IN listservice integer[])
    LANGUAGE plpgsql
    AS $$
DECLARE
servicio_info INT[];
servicio_id INT;
cantidad INT;
BEGIN
FOREACH servicio_info SLICE 1 IN ARRAY listService
LOOP
servicio_id := servicio_info[1];
cantidad := servicio_info[2];
IF cantidad > 0 THEN
INSERT INTO "servcliente" ("id_cliente", "id_servicio", "cant", "fecha_u", "tipo_cliente")
VALUES (cliente_id, servicio_id, cantidad, CURRENT_TIMESTAMP, TRUE);
END IF;
END LOOP;
END;
$$;
 c   DROP PROCEDURE public.genservcliente_prochuesped(IN cliente_id integer, IN listservice integer[]);
       public          postgres    false                       1255    25748 $   getclientsbyfiltergeneral_func(text)    FUNCTION     |  CREATE FUNCTION public.getclientsbyfiltergeneral_func(whereclause text) RETURNS TABLE(id_cliente integer, id_cama integer, nombre_c character varying, apellidos_c character varying, fecha_i timestamp without time zone, lugar_o character varying, carnet character varying, nivel_se integer, total numeric, vetado boolean)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY EXECUTE
	'SELECT DISTINCT cliente.id_cliente, huesped.id_cama, cliente.nombre_c, cliente.apellidos_c, huesped.fecha_i, cliente.lugar_o, cliente.carnet, cliente.nivel_se, total,
	CASE WHEN vetado.id_cliente IS NOT NULL THEN TRUE ELSE FALSE END AS Vetado
	FROM cliente
	LEFT JOIN huesped ON cliente.id_cliente = huesped.id_cliente
	LEFT JOIN vetado ON cliente.id_cliente = vetado.id_cliente
	LEFT JOIN absolutedeudas ON cliente.id_cliente = absolutedeudas.id_cliente
	' || whereClause || '
	ORDER BY total DESC';
END;
$$;
 G   DROP FUNCTION public.getclientsbyfiltergeneral_func(whereclause text);
       public          postgres    false                       1255    25749 $   getclientsbyfilterhuesped_func(text)    FUNCTION     }  CREATE FUNCTION public.getclientsbyfilterhuesped_func(whereclause text) RETURNS TABLE(id_cliente integer, id_cama integer, nombre_c character varying, apellidos_c character varying, fecha_i timestamp without time zone, lugar_o character varying, carnet character varying, nivel_se integer, total numeric, vetado boolean)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY EXECUTE
	'SELECT DISTINCT cliente.id_cliente, huesped.id_cama, cliente.nombre_c, cliente.apellidos_c, huesped.fecha_i, cliente.lugar_o, cliente.carnet, cliente.nivel_se, total,
	CASE WHEN vetado.id_cliente IS NOT NULL THEN TRUE ELSE FALSE END AS Vetado
	FROM cliente
	RIGHT JOIN huesped ON cliente.id_cliente = huesped.id_cliente
	LEFT JOIN vetado ON cliente.id_cliente = vetado.id_cliente
	LEFT JOIN absolutedeudas ON cliente.id_cliente = absolutedeudas.id_cliente
	' || whereClause || '
	ORDER BY total DESC';
END;
$$;
 G   DROP FUNCTION public.getclientsbyfilterhuesped_func(whereclause text);
       public          postgres    false                       1255    25750 &   getclientsbyfilterservicios_func(text)    FUNCTION     �  CREATE FUNCTION public.getclientsbyfilterservicios_func(whereclause text) RETURNS TABLE(id_cliente integer, nombre_c character varying, apellidos_c character varying, tipo_cliente boolean, carnet character varying, desayuno bigint, comida bigint, cena bigint, l_fecha_u timestamp without time zone, nivel_se integer, total numeric, vetado boolean)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY EXECUTE
	'SELECT cliente.id_cliente, nombre_c, apellidos_c, tipo_cliente, carnet,
	SUM(CASE WHEN servCliente.id_servicio = 3 THEN servCliente.cant ELSE 0 END) AS Desayuno,
    	SUM(CASE WHEN servCliente.id_servicio = 4 THEN servCliente.cant ELSE 0 END) AS Comida,
    	SUM(CASE WHEN servCliente.id_servicio = 5 THEN servCliente.cant ELSE 0 END) AS Cena,
	MAX(servCliente.fecha_u) AS l_fecha_u,
	nivel_se, total,
	CASE WHEN vetado.id_cliente IS NOT NULL THEN TRUE ELSE FALSE END AS Vetado
	FROM cliente
	RIGHT JOIN servCliente ON cliente.id_cliente = servCliente.id_cliente
	LEFT JOIN vetado ON cliente.id_cliente = vetado.id_cliente
	LEFT JOIN absoluteDeudas ON cliente.id_cliente = absoluteDeudas.id_cliente
	' || whereClause || '
	GROUP BY cliente.id_cliente, servCliente.tipo_cliente, absoluteDeudas.total, vetado.id_cliente
	ORDER BY l_fecha_u DESC';
END;
$$;
 I   DROP FUNCTION public.getclientsbyfilterservicios_func(whereclause text);
       public          postgres    false                       1255    25751 )   getclientsbyfiltervisitaprevia_func(text)    FUNCTION     �  CREATE FUNCTION public.getclientsbyfiltervisitaprevia_func(whereclause text) RETURNS TABLE(id_cliente integer, id_cama integer, nombre_c character varying, apellidos_c character varying, fecha_i timestamp without time zone, fecha_s timestamp without time zone, lugar_o character varying, carnet character varying, nivel_se integer, total numeric, vetado boolean)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY EXECUTE
	'SELECT DISTINCT cliente.id_cliente, logsalidas.id_cama, cliente.nombre_c, cliente.apellidos_c, logsalidas.fecha_i, logsalidas.fecha_s, cliente.lugar_o, cliente.carnet, cliente.nivel_se, total,
	CASE WHEN vetado.id_cliente IS NOT NULL THEN TRUE ELSE FALSE END AS Vetado
	FROM cliente
	RIGHT JOIN logsalidas ON cliente.id_cliente = logsalidas.id_cliente
	LEFT JOIN vetado ON cliente.id_cliente = vetado.id_cliente
	LEFT JOIN absoluteDeudas ON cliente.id_cliente = absoluteDeudas.id_cliente
	' || whereClause || '
	ORDER BY total DESC;';
END;
$$;
 L   DROP FUNCTION public.getclientsbyfiltervisitaprevia_func(whereclause text);
       public          postgres    false                       1255    25752    registrarsalida_func()    FUNCTION     .  CREATE FUNCTION public.registrarsalida_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO logSalidas (id_cliente, id_cama, fecha_i, fecha_s)
VALUES (OLD.id_cliente, OLD.id_cama, OLD.fecha_i, NEW.fecha_s);
DELETE FROM huesped WHERE id_cliente = OLD.id_cliente;
RETURN OLD;
END;
$$;
 -   DROP FUNCTION public.registrarsalida_func();
       public          postgres    false            �            1259    25753    cliente    TABLE     6  CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    id_usuario integer,
    carnet character varying,
    nombre_c character varying,
    apellidos_c character varying,
    lugar_o character varying,
    notas_c character varying,
    sexo boolean,
    paciente boolean,
    nivel_se integer
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    25758    pago    TABLE     �   CREATE TABLE public.pago (
    id_pago integer NOT NULL,
    id_cliente integer,
    notas_p character varying,
    monto_t numeric(7,2),
    fecha_p timestamp without time zone
);
    DROP TABLE public.pago;
       public         heap    postgres    false            �            1259    25763    deudaclientes    VIEW     �   CREATE VIEW public.deudaclientes AS
 SELECT cliente.id_cliente,
    sum(pago.monto_t) AS total
   FROM (public.cliente
     LEFT JOIN public.pago ON ((cliente.id_cliente = pago.id_cliente)))
  GROUP BY cliente.id_cliente
  ORDER BY (sum(pago.monto_t));
     DROP VIEW public.deudaclientes;
       public          postgres    false    233    232    233            �            1259    25767    absolutedeudas    VIEW     o   CREATE VIEW public.absolutedeudas AS
 SELECT id_cliente,
    abs(total) AS total
   FROM public.deudaclientes;
 !   DROP VIEW public.absolutedeudas;
       public          postgres    false    234    234            �            1259    25771    area    TABLE     [   CREATE TABLE public.area (
    id_area integer NOT NULL,
    nombre_a character varying
);
    DROP TABLE public.area;
       public         heap    postgres    false            �            1259    25776    area_id_Area_seq    SEQUENCE     �   ALTER TABLE public.area ALTER COLUMN id_area ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."area_id_Area_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    236            �            1259    25777    cama    TABLE     P   CREATE TABLE public.cama (
    id_cama integer NOT NULL,
    id_zona integer
);
    DROP TABLE public.cama;
       public         heap    postgres    false            �            1259    25780    cama_id_Cama_seq    SEQUENCE     �   ALTER TABLE public.cama ALTER COLUMN id_cama ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."cama_id_Cama_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    238            �            1259    25781    colorescama    VIEW     -  CREATE VIEW public.colorescama AS
 SELECT id_cliente,
        CASE
            WHEN (total > (- (40)::numeric)) THEN '#8cbcfc'::text
            WHEN (total <= (- (40)::numeric)) THEN '#EE7171'::text
            ELSE NULL::text
        END AS color
   FROM public.deudaclientes
  ORDER BY id_cliente;
    DROP VIEW public.colorescama;
       public          postgres    false    234    234            �            1259    25785    huesped    TABLE     �   CREATE TABLE public.huesped (
    id_cliente integer,
    id_cama integer,
    fecha_i timestamp without time zone,
    fecha_s timestamp without time zone
);
    DROP TABLE public.huesped;
       public         heap    postgres    false            �            1259    25788    camasgralinfo    VIEW     ?  CREATE VIEW public.camasgralinfo AS
 SELECT cama.id_cama,
    cama.id_zona,
    cl.id_cliente,
    cl.carnet,
    cl.nombre_c,
    cl.apellidos_c,
    deudaclientes.total AS balance,
    colorescama.color
   FROM ((((public.cama
     LEFT JOIN public.huesped ON ((cama.id_cama = huesped.id_cama)))
     LEFT JOIN public.cliente cl ON ((huesped.id_cliente = cl.id_cliente)))
     LEFT JOIN public.deudaclientes ON ((huesped.id_cliente = deudaclientes.id_cliente)))
     LEFT JOIN public.colorescama ON ((huesped.id_cliente = colorescama.id_cliente)))
  ORDER BY cama.id_cama;
     DROP VIEW public.camasgralinfo;
       public          postgres    false    232    241    241    240    240    238    238    234    234    232    232    232            �            1259    25793    cliente_id_Cliente_seq    SEQUENCE     �   ALTER TABLE public.cliente ALTER COLUMN id_cliente ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."cliente_id_Cliente_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    232            �            1259    25794    jobs    TABLE     V   CREATE TABLE public.jobs (
    entry_job timestamp without time zone DEFAULT now()
);
    DROP TABLE public.jobs;
       public         heap    postgres    false            �            1259    25798 
   logsalidas    TABLE     �   CREATE TABLE public.logsalidas (
    id_cliente integer,
    id_cama integer,
    fecha_i timestamp without time zone,
    fecha_s timestamp without time zone
);
    DROP TABLE public.logsalidas;
       public         heap    postgres    false            �            1259    25801    paciente    TABLE     �   CREATE TABLE public.paciente (
    carnet character varying NOT NULL,
    id_area integer,
    nombre_p character varying,
    apellidos_p character varying
);
    DROP TABLE public.paciente;
       public         heap    postgres    false            �            1259    25806    pago_id_Pago_seq    SEQUENCE     �   ALTER TABLE public.pago ALTER COLUMN id_pago ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."pago_id_Pago_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    233            �            1259    25807    servcliente    TABLE     �   CREATE TABLE public.servcliente (
    id_cliente integer,
    id_servicio integer,
    cant integer,
    fecha_u timestamp without time zone,
    tipo_cliente boolean
);
    DROP TABLE public.servcliente;
       public         heap    postgres    false            �            1259    25810    servicio    TABLE     }   CREATE TABLE public.servicio (
    id_servicio integer NOT NULL,
    nombre_s character varying,
    cargo_s numeric(7,2)
);
    DROP TABLE public.servicio;
       public         heap    postgres    false            �            1259    25815    servicio_id_Servicio_seq    SEQUENCE     �   ALTER TABLE public.servicio ALTER COLUMN id_servicio ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."servicio_id_Servicio_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    249                        1259    25916    tokens    TABLE     [   CREATE TABLE public.tokens (
    token character varying,
    id_token integer NOT NULL
);
    DROP TABLE public.tokens;
       public         heap    postgres    false                       1259    25923    tokens_id_token_seq    SEQUENCE     �   CREATE SEQUENCE public.tokens_id_token_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tokens_id_token_seq;
       public          postgres    false    256            R           0    0    tokens_id_token_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tokens_id_token_seq OWNED BY public.tokens.id_token;
          public          postgres    false    257            �            1259    25816    usuario    TABLE     �   CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre_u character varying,
    contrasena character varying
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �            1259    25821    usuario_id_Usuario_seq    SEQUENCE     �   ALTER TABLE public.usuario ALTER COLUMN id_usuario ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."usuario_id_Usuario_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    251            �            1259    25822    vetado    TABLE     �   CREATE TABLE public.vetado (
    id_usuario integer,
    id_cliente integer,
    notas_v character varying,
    fecha_v timestamp without time zone
);
    DROP TABLE public.vetado;
       public         heap    postgres    false            �            1259    25827    zona    TABLE     [   CREATE TABLE public.zona (
    id_zona integer NOT NULL,
    nombre_z character varying
);
    DROP TABLE public.zona;
       public         heap    postgres    false            �            1259    25832    zona_id_Zona_seq    SEQUENCE     �   ALTER TABLE public.zona ALTER COLUMN id_zona ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."zona_id_Zona_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    254            ^           2604    25924    tokens id_token    DEFAULT     r   ALTER TABLE ONLY public.tokens ALTER COLUMN id_token SET DEFAULT nextval('public.tokens_id_token_seq'::regclass);
 >   ALTER TABLE public.tokens ALTER COLUMN id_token DROP DEFAULT;
       public          postgres    false    257    256            7          0    25586    pga_jobagent 
   TABLE DATA           I   COPY pgagent.pga_jobagent (jagpid, jaglogintime, jagstation) FROM stdin;
    pgagent          postgres    false    217   �       8          0    25595    pga_jobclass 
   TABLE DATA           7   COPY pgagent.pga_jobclass (jclid, jclname) FROM stdin;
    pgagent          postgres    false    219   0�       9          0    25605    pga_job 
   TABLE DATA           �   COPY pgagent.pga_job (jobid, jobjclid, jobname, jobdesc, jobhostagent, jobenabled, jobcreated, jobchanged, jobagentid, jobnextrun, joblastrun) FROM stdin;
    pgagent          postgres    false    221   M�       ;          0    25653    pga_schedule 
   TABLE DATA           �   COPY pgagent.pga_schedule (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths) FROM stdin;
    pgagent          postgres    false    225   j�       <          0    25681    pga_exception 
   TABLE DATA           J   COPY pgagent.pga_exception (jexid, jexscid, jexdate, jextime) FROM stdin;
    pgagent          postgres    false    227   ��       =          0    25695 
   pga_joblog 
   TABLE DATA           X   COPY pgagent.pga_joblog (jlgid, jlgjobid, jlgstatus, jlgstart, jlgduration) FROM stdin;
    pgagent          postgres    false    229   ��       :          0    25629    pga_jobstep 
   TABLE DATA           �   COPY pgagent.pga_jobstep (jstid, jstjobid, jstname, jstdesc, jstenabled, jstkind, jstcode, jstconnstr, jstdbname, jstonerror, jscnextrun) FROM stdin;
    pgagent          postgres    false    223   ��       >          0    25711    pga_jobsteplog 
   TABLE DATA           |   COPY pgagent.pga_jobsteplog (jslid, jsljlgid, jsljstid, jslstatus, jslresult, jslstart, jslduration, jsloutput) FROM stdin;
    pgagent          postgres    false    231   ލ       6          0    25771    area 
   TABLE DATA           1   COPY public.area (id_area, nombre_a) FROM stdin;
    public          postgres    false    236   ��       8          0    25777    cama 
   TABLE DATA           0   COPY public.cama (id_cama, id_zona) FROM stdin;
    public          postgres    false    238   ��       4          0    25753    cliente 
   TABLE DATA           �   COPY public.cliente (id_cliente, id_usuario, carnet, nombre_c, apellidos_c, lugar_o, notas_c, sexo, paciente, nivel_se) FROM stdin;
    public          postgres    false    232   �       :          0    25785    huesped 
   TABLE DATA           H   COPY public.huesped (id_cliente, id_cama, fecha_i, fecha_s) FROM stdin;
    public          postgres    false    241   �       <          0    25794    jobs 
   TABLE DATA           )   COPY public.jobs (entry_job) FROM stdin;
    public          postgres    false    244   Z�       =          0    25798 
   logsalidas 
   TABLE DATA           K   COPY public.logsalidas (id_cliente, id_cama, fecha_i, fecha_s) FROM stdin;
    public          postgres    false    245   Ȑ       >          0    25801    paciente 
   TABLE DATA           J   COPY public.paciente (carnet, id_area, nombre_p, apellidos_p) FROM stdin;
    public          postgres    false    246   �       5          0    25758    pago 
   TABLE DATA           N   COPY public.pago (id_pago, id_cliente, notas_p, monto_t, fecha_p) FROM stdin;
    public          postgres    false    233   ��       @          0    25807    servcliente 
   TABLE DATA           [   COPY public.servcliente (id_cliente, id_servicio, cant, fecha_u, tipo_cliente) FROM stdin;
    public          postgres    false    248   ��       A          0    25810    servicio 
   TABLE DATA           B   COPY public.servicio (id_servicio, nombre_s, cargo_s) FROM stdin;
    public          postgres    false    249   :�       H          0    25916    tokens 
   TABLE DATA           1   COPY public.tokens (token, id_token) FROM stdin;
    public          postgres    false    256   ��       C          0    25816    usuario 
   TABLE DATA           C   COPY public.usuario (id_usuario, nombre_u, contrasena) FROM stdin;
    public          postgres    false    251   ��       E          0    25822    vetado 
   TABLE DATA           J   COPY public.vetado (id_usuario, id_cliente, notas_v, fecha_v) FROM stdin;
    public          postgres    false    253   "�       F          0    25827    zona 
   TABLE DATA           1   COPY public.zona (id_zona, nombre_z) FROM stdin;
    public          postgres    false    254   s�       S           0    0    area_id_Area_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."area_id_Area_seq"', 10, true);
          public          postgres    false    237            T           0    0    cama_id_Cama_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."cama_id_Cama_seq"', 65, true);
          public          postgres    false    239            U           0    0    cliente_id_Cliente_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."cliente_id_Cliente_seq"', 7, true);
          public          postgres    false    243            V           0    0    pago_id_Pago_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."pago_id_Pago_seq"', 88, true);
          public          postgres    false    247            W           0    0    servicio_id_Servicio_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."servicio_id_Servicio_seq"', 5, true);
          public          postgres    false    250            X           0    0    tokens_id_token_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.tokens_id_token_seq', 1, true);
          public          postgres    false    257            Y           0    0    usuario_id_Usuario_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."usuario_id_Usuario_seq"', 3, true);
          public          postgres    false    252            Z           0    0    zona_id_Zona_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."zona_id_Zona_seq"', 3, true);
          public          postgres    false    255            �           2606    25834    area area_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id_area);
 8   ALTER TABLE ONLY public.area DROP CONSTRAINT area_pkey;
       public            postgres    false    236            �           2606    25836    cama cama_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cama
    ADD CONSTRAINT cama_pkey PRIMARY KEY (id_cama);
 8   ALTER TABLE ONLY public.cama DROP CONSTRAINT cama_pkey;
       public            postgres    false    238            �           2606    25838    cliente cliente_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    232            �           2606    25840    paciente paciente_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (carnet);
 @   ALTER TABLE ONLY public.paciente DROP CONSTRAINT paciente_pkey;
       public            postgres    false    246            �           2606    25842    pago pago_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (id_pago);
 8   ALTER TABLE ONLY public.pago DROP CONSTRAINT pago_pkey;
       public            postgres    false    233            �           2606    25844    servicio servicio_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_pkey PRIMARY KEY (id_servicio);
 @   ALTER TABLE ONLY public.servicio DROP CONSTRAINT servicio_pkey;
       public            postgres    false    249            �           2606    25926    tokens tokens_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id_token);
 <   ALTER TABLE ONLY public.tokens DROP CONSTRAINT tokens_pkey;
       public            postgres    false    256            �           2606    25846    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    251            �           2606    25848    zona zona_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.zona
    ADD CONSTRAINT zona_pkey PRIMARY KEY (id_zona);
 8   ALTER TABLE ONLY public.zona DROP CONSTRAINT zona_pkey;
       public            postgres    false    254            �           2620    25849    huesped registrarsalida_trigger    TRIGGER     �   CREATE TRIGGER registrarsalida_trigger AFTER UPDATE ON public.huesped FOR EACH ROW WHEN (((old.fecha_s IS DISTINCT FROM new.fecha_s) AND (new.fecha_s IS NOT NULL))) EXECUTE FUNCTION public.registrarsalida_func();
 8   DROP TRIGGER registrarsalida_trigger ON public.huesped;
       public          postgres    false    284    241    241            �           2606    25850    cama fk_cama_zona    FK CONSTRAINT     �   ALTER TABLE ONLY public.cama
    ADD CONSTRAINT fk_cama_zona FOREIGN KEY (id_zona) REFERENCES public.zona(id_zona) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ;   ALTER TABLE ONLY public.cama DROP CONSTRAINT fk_cama_zona;
       public          postgres    false    254    3472    238            �           2606    25855    cliente fk_cliente_paciente    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cliente_paciente FOREIGN KEY (carnet) REFERENCES public.paciente(carnet) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 E   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cliente_paciente;
       public          postgres    false    246    232    3466            �           2606    25860    cliente fk_cliente_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cliente_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;
 D   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cliente_usuario;
       public          postgres    false    251    3470    232            �           2606    25865    huesped fk_huesped_cama    FK CONSTRAINT     �   ALTER TABLE ONLY public.huesped
    ADD CONSTRAINT fk_huesped_cama FOREIGN KEY (id_cama) REFERENCES public.cama(id_cama) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;
 A   ALTER TABLE ONLY public.huesped DROP CONSTRAINT fk_huesped_cama;
       public          postgres    false    3464    241    238            �           2606    25870    huesped fk_huesped_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.huesped
    ADD CONSTRAINT fk_huesped_cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 D   ALTER TABLE ONLY public.huesped DROP CONSTRAINT fk_huesped_cliente;
       public          postgres    false    232    3458    241            �           2606    25875    logsalidas fk_logSalidas_cama    FK CONSTRAINT     �   ALTER TABLE ONLY public.logsalidas
    ADD CONSTRAINT "fk_logSalidas_cama" FOREIGN KEY (id_cama) REFERENCES public.cama(id_cama) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 I   ALTER TABLE ONLY public.logsalidas DROP CONSTRAINT "fk_logSalidas_cama";
       public          postgres    false    3464    238    245            �           2606    25880     logsalidas fk_logSalidas_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.logsalidas
    ADD CONSTRAINT "fk_logSalidas_cliente" FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 L   ALTER TABLE ONLY public.logsalidas DROP CONSTRAINT "fk_logSalidas_cliente";
       public          postgres    false    3458    245    232            �           2606    25885    paciente fk_paciente_area    FK CONSTRAINT     �   ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT fk_paciente_area FOREIGN KEY (id_area) REFERENCES public.area(id_area) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;
 C   ALTER TABLE ONLY public.paciente DROP CONSTRAINT fk_paciente_area;
       public          postgres    false    236    246    3462            �           2606    25890    pago fk_pago_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.pago
    ADD CONSTRAINT fk_pago_cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 >   ALTER TABLE ONLY public.pago DROP CONSTRAINT fk_pago_cliente;
       public          postgres    false    3458    232    233            �           2606    25895 "   servcliente fk_servCliente_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.servcliente
    ADD CONSTRAINT "fk_servCliente_cliente" FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;
 N   ALTER TABLE ONLY public.servcliente DROP CONSTRAINT "fk_servCliente_cliente";
       public          postgres    false    232    248    3458            �           2606    25900 #   servcliente fk_servCliente_servicio    FK CONSTRAINT     �   ALTER TABLE ONLY public.servcliente
    ADD CONSTRAINT "fk_servCliente_servicio" FOREIGN KEY (id_servicio) REFERENCES public.servicio(id_servicio) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 O   ALTER TABLE ONLY public.servcliente DROP CONSTRAINT "fk_servCliente_servicio";
       public          postgres    false    3468    248    249            �           2606    25905    vetado fk_vetado_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.vetado
    ADD CONSTRAINT fk_vetado_cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 B   ALTER TABLE ONLY public.vetado DROP CONSTRAINT fk_vetado_cliente;
       public          postgres    false    232    253    3458            �           2606    25910    vetado fk_vetado_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.vetado
    ADD CONSTRAINT fk_vetado_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;
 B   ALTER TABLE ONLY public.vetado DROP CONSTRAINT fk_vetado_usuario;
       public          postgres    false    251    253    3470            7      x������ � �      8      x������ � �      9      x������ � �      ;      x������ � �      <      x������ � �      =      x������ � �      :      x������ � �      >      x������ � �      6   �   x�3�t�,*M?�6�ˈ�WO�3�$�(/�˘�?/9?',c�闚V�r��)�^�����e�4�g�%r�s�&��%&gޜ�e�霟W\�S��e�X�����_�eh�Z������X����� 4�,�      8   |   x�˱�0�X*�ǀ������ a��=;��eֳ{��ޙ."�U|�Y��]��#�0�#�0�#���9�HH��<��ED�(D!
Q�B"� �"� �"� шF4�k�ݙ|���ʶ)I      4   �   x�=�1n1E��)��v�_9�	b	($R�4fwV���܆2���bS�i���k������n�uL7]$f���_��*]/��t呬� ЈYa�����s�	>��aG��~r��H'5h���\-��������;��Ŧ_�;��'����{��q?�u88�>"�ʦ�r�����䑵ʁ�쉃Åq��6��F��$���M.
P��!�P�T�      :   F   x�M˱�0�ڞ"��E~&��s h�>l�#�;��J��/O#?�K��ʐ�)R�}�p���	      <   ^   x����� �?U���9cL-鿎�/���GZ��X��yiN��&�A�b�$��O�!�0=(W0�An䘠`��tQ����& �N�}��f��R��HM      =      x������ � �      >   �   x�%�M
�0����)r�D�5Ū4��q3ڠ���I�"7r��3�b��~��ݦ<���a߾�HWVE�O.�?���I�"�Ih��&<d��=!k�\%�/��� �%&�:[�f�&�5���Vˆ�z���'��ն!(9QEj!t��`q�^��La��Hl?����=���\�@�      5   �  x���=��0Fk��������[d�tiҥqb�p��n�g��B)1lD��*�G=���8���8_��t=��i8x���� |@!�����t�L�&BTD
������㽬޳y{YĂ��:�A���Ba.�^��i/�������ҍ���D'�L_�i|��:����z�6����	�ű@�	3��Y���.�>Z��ƣG��$Y�|��oy�?-�I���s��-��,�>X����r�N�b���⾡�b��H���N�Ž�'�}��YK
�W%I�"X�<Z�<Y��_���]���/�v}�JM�H��G�=֒����Q���J�=r�X_�?jm����RrO��|9���s~9�Ǐ?�O�_�s=���zJV�Y	���q��{���׆!T��;���w\�����{ǫ�e�S˵���k��K�����K��k����_�s�~W��      @   �   x��л�0E�xU��ٷ[�+p�
��XrDB|��\	���&x�-\�A��J�5�´���&��[�B�߄$�G+n�T��Kk�-l�˲��cҭ�M~�r�w>$�Q�Pm�WC��\�����!u)8��t�%�^_ⴔ��^���8��>�+r�      A   F   x�3�JMOLI-J�46�30�2�tJ<�1��1�tI-N�,���4�p:��f�$B���Ωy0N� S`      H     x��]o�0 E����2�<*)��-(�͒�/�R��D���c��<�soo�w��*S1� U�.y��h��UT1�V�Š]W�wdF-��u<�5ߪl 7d�Gñ�U���4������Gs��Iб1p� M̒r�{����J����Z�{��#�U�	���z⅐w�(�ݳ��K�9)�,5L��Y�<��:�@,q�b<��eH��YH��LXe�{���9��3�$0#�G����N���3�G��ϕ�y/b5      C   q   x�3����L�K�LL���346�2�t/M,J�L�L�� AcΌ��DN�$C��D�$�"/���B�|�T#W�Ҳ$�p���0ϲ�tcOWgǠ`�Ҵ�r��`�"�T�=... hH!T      E   A   x�]ʻ� К7E���3���}���*)�s��|���i��*�))JN��=���Ml�
�      F   (   x�3��-�J-�2����M*J�2�t�,�IL������ ���     