-- smazání všech záznamů z tabulek

CREATE or replace FUNCTION clean_tables() RETURNS void AS $$
declare
  l_stmt text;
begin
  select 'truncate ' || string_agg(format('%I.%I', schemaname, tablename) , ',')
    into l_stmt
  from pg_tables
  where schemaname in ('public');

  execute l_stmt || ' cascade';
end;
$$ LANGUAGE plpgsql;
select clean_tables();

-- reset sekvenci

CREATE or replace FUNCTION restart_sequences() RETURNS void AS $$
DECLARE
i TEXT;
BEGIN
 FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
  LOOP
         EXECUTE 'ALTER SEQUENCE'||' ' || substring(substring(i from '''[a-z_]*')from '[a-z_]+') || ' '||' RESTART 1;';
  END LOOP;
END $$ LANGUAGE plpgsql;
select restart_sequences();
-- konec resetu

-- konec mazání
INSERT INTO storage VALUES (DEFAULT, 1, 900, 3);
INSERT INTO household VALUES (DEFAULT, 'Eriksson');
INSERT INTO household VALUES (DEFAULT, 'Sigmunsson');
INSERT INTO household VALUES (DEFAULT, 'Wahlberg');
INSERT INTO household VALUES (DEFAULT, 'Ekman');
INSERT INTO household VALUES (DEFAULT, 'Adelsköld');
INSERT INTO household VALUES (DEFAULT, 'Söderberg');
INSERT INTO household VALUES (DEFAULT, 'Petersson');
INSERT INTO household VALUES (DEFAULT, 'Ståhlbrand');
INSERT INTO household VALUES (DEFAULT, 'Fransson');
INSERT INTO household VALUES (DEFAULT, 'Rothschild');
INSERT INTO household VALUES (DEFAULT, 'Angstrom');
INSERT INTO household VALUES (DEFAULT, 'Nordin');
INSERT INTO household VALUES (DEFAULT, 'Kindstrand');
INSERT INTO household VALUES (DEFAULT, 'Gunnarsson');
INSERT INTO household VALUES (DEFAULT, 'Björklund');

COMMIT;