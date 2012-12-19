#!/usr/bin/env ruby
# encoding: utf-8

# habilita o modulo unaccent
CREATE EXTENSION unaccent; #logar no bd template1 como super usuario postgres

#com isso ja e possivel fazer a seguinte consulta ignorando acentos
SELECT title FROM films where unaccent('unaccent', title) ilike unaccent('unaccent', '%impe%')
#retorna => O Império Contra Ataca

#e possivel tbm criar uma funcao personalizada
CREATE function simples(texto varchar) RETURNS text AS 'select lower(unaccent(''unaccent'', $1))' LANGUAGE sql IMMUTABLE STRICT;
# desta forma a mesma consulta acima ficaria assim:
SELECT title FROM films WHERE simples(title) like simples('%impe%');

# inserir dicionario unaccent dentro de uma configuracao de search text
CREATE TEXT SEARCH CONFIGURATION pt ( COPY = portuguese );
ALTER TEXT SEARCH CONFIGURATION pt ALTER MAPPING FOR asciiword, hword, hword_part, word WITH unaccent, portuguese_stem;

#incluir uma coluna especifica pra busca
ALTER TABLE mytable ADD mycolumn tsvector; #tsvector e um tipo de dado

#popular a coluna recem criada
UPDATE mytable SET mycolumn = to_tsvector('pt', coluna_a_ser_clonada);

#exemplo de uso
SELECT title FROM films WHERE coluna_vetorizada @@ to_tsquery('pt', 'Impe:*');
=> O Império Contra Ataca

#para buscar mais de uma palavra use:
SELECT title FROM films WHERE coluna_vetorizada @@ plainto_tsquery('pt', 'imperio contra');

# melhorar performance criando indice 
CREATE INDEX films_gidx ON films USING gin(coluna_vetorizada);

# criar gatilho para atualizar a coluna vetorizada
CREATE TRIGGER nome_do_gatilho BEFORE INSERT OR UPDATE ON sua_tabela FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(coluna_vetorizada, 'public.pt', colunas_pesquisadas);

