-- Desafio 1 - Problemas com duplicatas
CREATE SEQUENCE sq INCREMENT 1 MINVALUE 0 MAXVALUE 99999;

CREATE OR REPLACE FUNCTION insere_protocolo()
RETURN trigger AS 
$BODY$
BEGIN
	INSERT INTO atende.solicitacao VALUES(DEFAULT
										 ,NEXTVAL('sq')||"/"||SELECT DATE_PART('YEAR', CURRENT_TIMESTAMP) AS ano
										 ,new.created_at
										 ,new.data_prazo
										 ,new.sequencial
										 ,new.protocolo_mobile);
	RETURN new;
END;
$BODY$ 
language 'plpgsql'

CREATE TRIGGER protocolo_atendimento
BEFORE INSERT
ON atende.solicitacao
FOR EACH ROW
EXECUTE PROCEDURE insere_protocolo();

