PGDMP  1                    |            gestionAlbergue2    16.2    16.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17061    gestionAlbergue2    DATABASE     ~   CREATE DATABASE "gestionAlbergue2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
 "   DROP DATABASE "gestionAlbergue2";
                postgres    false            �            1259    17390    tokens    TABLE     [   CREATE TABLE public.tokens (
    token character varying,
    id_token integer NOT NULL
);
    DROP TABLE public.tokens;
       public         heap    postgres    false                        1259    17397    tokens_id_token_seq    SEQUENCE     �   CREATE SEQUENCE public.tokens_id_token_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tokens_id_token_seq;
       public          postgres    false    255            �           0    0    tokens_id_token_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tokens_id_token_seq OWNED BY public.tokens.id_token;
          public          postgres    false    256                       2604    17398    tokens id_token    DEFAULT     r   ALTER TABLE ONLY public.tokens ALTER COLUMN id_token SET DEFAULT nextval('public.tokens_id_token_seq'::regclass);
 >   ALTER TABLE public.tokens ALTER COLUMN id_token DROP DEFAULT;
       public          postgres    false    256    255            �          0    17390    tokens 
   TABLE DATA           1   COPY public.tokens (token, id_token) FROM stdin;
    public          postgres    false    255   �
       �           0    0    tokens_id_token_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tokens_id_token_seq', 27, true);
          public          postgres    false    256                       2606    17400    tokens tokens_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id_token);
 <   ALTER TABLE ONLY public.tokens DROP CONSTRAINT tokens_pkey;
       public            postgres    false    255            �   �  x�ݘɒ�JF���h0*,���*���"Ȍ�������,�U'"3ϗ�d'5-ai�ެ��z�0�����z�E��f�A��?��u��M}���(S�%�҇�2�S`L��z՗��=Bw9��S�L�4�V^~��f�|���j��t��m�Dm���{g�0}�{D���r��t��84�������0x�^ �]�,sw,�@�������tJ5u�&���~2e"�m�&љ�NI�ȝQ�P�}.r��{�p�Q�ե�qH�)F�d��c��M�|.@�c��a���͐�"-5���x�w���WJ��V��G/c�:� �f>��#�n{���N���f<�p=:1g�mTͷ~�&��gi�)F����/|� n�j���w����T8�ڟ%�5��@����)F�1z�|�d�_��@�-!���2��K��K��̒<�J�Pc�BF6�cVɇ4%���iV
�5=��P�>
j?_<K�Y�|Ju�zW�7Eq��l�Z>��k��W���SV�Z��Sv�َ�s\���s2����J����~�|�Z����z�[B(l�N�_p����0ſ�>{����{7{Ӭ1v�|�~�w �#����hԝ���ū��ݯ�t-�$�s�܅m2�EÏ��Ǹ��A�G^��!Z�spr6gx�O���"RN�y�
���\TP��t4F�kt��Y�(0(y��W`��á2�QFY��Z=4�1P�Mp��20T@&�̢e�X�A_&0��'�p���'I�.�K��MMU�h8���T�M�%���=�����T����
n{��X�x�q��q"*�n� �j)ro'�&�n%LTǈU:�e6�M~D)�/�p�-�%$¡7A�`'$D^���%�ޑ^���UJ���?B��6�%��k��KCri��˳�}x���W�{ Vǈ%M�#Vi����1�@�K�(e����4϶�d�)��,P�����Q�a�*5�2/1��t�� �Z7��_���p�Z��=p�q��	t,?��e����nJ�7@�_/�:�N��f�]��_�p��lѐ��Ѯ��>;��5h��ƈU����#����W�C[\���,��kv��<{-"�ۈ?T�e̯Ҥ@��H� 
�%�W~o���'+�۷����>0�K��S�F�OB)��N����x�e����1f7�y��IRr{3P�R��l%��e���z�\�I����a��ZC�9�sd�!,@��A"J65SP�]��<'mxQ��u�4���gB�"�K2j�;g�ќ�&W�
�T�}Diqp��/Or>����u�4mΟ���o�Zd�~���4��{��0�c=���+��j�s��Vg#�i�4@_�<������ߍ�N;��Sn9���.�߼G��}:��}��N��A�}�y�O�/��ڭ��i✢3�!��rr���z�O�̿��]�%J�1r�&M�Y�l�H_2�Ҥ<�_�,	�ϴ�zSFa$��dڜ+�~g)���Y�0r���������@=     