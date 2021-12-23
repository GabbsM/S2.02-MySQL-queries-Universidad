#Base de dades Universidad


1.Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.

   SELECT apellido1,apellido2,nombre,tipo from persona where tipo = 'alumno' order by apellido1 desc;

2.Esbrina el nom i els dos cognoms dels alumnes que no han donat dalta el seu número de telèfon en la base de dades.

   SELECT nombre,apellido1,apellido2 from persona where telefono is null  and tipo = 'alumno';

3.Retorna el llistat dels alumnes que van néixer en 1999.

   SELECT nombre,fecha_nacimiento from persona where fecha_nacimiento between '1999-01-01' and '1999-12-31';

4.Retorna el llistat de professors que no han donat dalta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.

   SELECT nif,nombre,tipo from persona where tipo = 'profesor' and nif like '%K'; 

5.Retorna el llistat de les assignatures que simparteixen en el primer quadrimestre, en el tercer curs del grau que té lidentificador 7.

   SELECT nombre,cuatrimestre,curso,id_grado from asignatura where curso = 3 and cuatrimestre = 1 and id_grado = 7;

6.Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.

   select persona.apellido1,persona.apellido2,persona.nombre, departamento.nombre from profesor inner join departamento on profesor.id_departamento = departamento.id inner join persona on persona.id = profesor.id_profesor order by persona.apellido1 desc, persona.apellido2 desc, persona.nombre desc;

7.Retorna un llistat amb el nom de les assignatures, any dinici i any de fi del curs escolar de lalumne amb nif 26902806M.

   select persona.nombre, persona.apellido1, alumno_se_matricula_asignatura.id_asignatura,asignatura.nombre,curso_escolar.anyo_inicio,curso_escolar.anyo_fin  from persona
   inner join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno
   inner join asignatura on alumno_se_matricula_asignatura.id_asignatura = asignatura.id
   inner join curso_escolar on curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
   where nif = '26902806M'; 

8. Retornaun llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

   select asignatura.nombre,profesor.id_profesor,asignatura.id_grado from asignatura inner join profesor on asignatura.id_profesor = profesor.id_profesor where id_grado = 4;

9.Retorna un llistat amb tots els alumnes que shan matriculat en alguna assignatura durant el curs escolar 2018/2019.

   select persona.nombre,persona.apellido1,persona.apellido2,id_asignatura,id_curso_escolar from alumno_se_matricula_asignatura
   inner join persona on persona.id = alumno_se_matricula_asignatura.id_alumno
   where id_curso_escolar=5;

#Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.


1.Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

   select persona.nombre,persona.apellido1,persona.apellido2,departamento.nombre from profesor 
   right join departamento on profesor.id_departamento = departamento.id
   right join persona on persona.id = profesor.id_profesor
   order by persona.nombre desc, persona.apellido1 desc,persona.apellido2 desc;

2.Retorna un llistat amb els professors que no estan associats a un departament.

   select persona.nombre,persona.apellido1,persona.apellido2,departamento.nombre from profesor 
   right join departamento on profesor.id_departamento = departamento.id
   right join persona on persona.id = profesor.id_profesor
   where departamento.nombre is null;

3.Retorna un llistat amb els departaments que no tenen professors associats.

   select departamento.nombre from profesor 
   right join departamento on profesor.id_departamento = departamento.id
   right join persona on persona.id = profesor.id_profesor;

4.Retorna un llistat amb els professors que no imparteixen cap assignatura.

   select persona.nombre,persona.apellido1,persona.apellido2 from profesor 
   right join departamento on profesor.id_departamento = departamento.id
   right join persona on persona.id = profesor.id_profesor
   where departamento.nombre is null
   order by persona.nombre desc, persona.apellido1 desc,persona.apellido2 desc;

5.Retorna un llistat amb les assignatures que no tenen un professor assignat.

   select asignatura.nombre,asignatura.id_profesor from asignatura where id_profesor is null;
   
6.Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.


#Consultes resum:

1.Retorna el nombre total dalumnes que hi ha.

   SELECT count(id) as 'alumnos' from persona where tipo = 'alumno';

2. Calcula quants alumnes van néixer en 1999.
 
  SELECT count(fecha_nacimiento) as 'nacidos en 1999'  from persona where fecha_nacimiento between '1999-01-01' and '1999-12-31'

3. Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament 
   i una altra amb el nombre de professors que hi ha en aquest departament. El resultat només ha dincloure els departaments que tenen professors 
   associats i haurà destar ordenat de major a menor pel nombre de professors.

    SELECT * FROM profesor;
    select count(profesor.id_profesor),departamento.nombre from profesor
    inner join departamento on profesor.id_departamento = departamento.id
    group by id_departamento
    order by count(profesor.id_profesor) desc;

4. Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun dells. Tingui en compte que poden existir 
   departaments que no tenen professors associats. Aquests departaments també han daparèixer en el llistat.

   select count(profesor.id_profesor) as 'numero de profesores',departamento.nombre from profesor
   right join departamento on profesor.id_departamento = departamento.id
   group by departamento.id;

5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre dassignatures que té cadascun.
   Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han daparèixer en el llistat.
   El resultat haurà destar ordenat de major a menor pel nombre dassignatures.

   select count(asignatura.id_grado) as 'numero de asignaturas', grado.nombre from grado
   left join asignatura on grado.id = asignatura.id_grado
   group by grado.id
   order by asignatura.id_grado desc;

6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre dassignatures que té cadascun, dels graus que
   tinguin més de 40 assignatures associades.

   select count(asignatura.id_grado) as 'numero de asignaturas', grado.nombre from grado
   inner join asignatura on grado.id = asignatura.id_grado
   where asignatura.id_grado >= 40
   group by grado.id 
   order by asignatura.id_grado desc;

7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus dassignatura. El resultatç
   ha de tenir tres columnes: nom del grau, tipus dassignatura i la suma dels crèdits de totes les assignatures que hi ha daquest tipus.

   select grado.nombre, asignatura.tipo,sum(asignatura.creditos) as 'total creditos' from grado
   join asignatura on grado.id = asignatura.id_grado
   group by asignatura.creditos;

8. 
Retorna un llistat que mostri quants alumnes shan matriculat dalguna assignatura en cadascun dels cursos escolars. El resultat haurà de 
   mostrar dues columnes, una columna amb lany dinici del curs escolar i una altra amb el nombre dalumnes matriculats.

   select curso_escolar.anyo_inicio,count(id_alumno) as 'numero de alumnos matriculados' from alumno_se_matricula_asignatura
   join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
   group by alumno_se_matricula_asignatura.id_alumno;

9. Retorna un llistat amb el nombre dassignatures que imparteix cada professor. El llistat ha de tenir en compte aquells professors que no 
   imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre dassignatures. El resultat 
    estarà ordenat de major a menor pel nombre dassignatures.

   select profesor.id_profesor, persona.nombre, persona.apellido1, persona.apellido2, count(asignatura.id) as 'numero de asignaturas' from profesor
   right join persona on profesor.id_profesor = persona.id
   left join asignatura on profesor.id_profesor = asignatura.id_profesor
   group by profesor.id_profesor;
    
10. Retorna totes les dades de lalumne més jove.

   select max(fecha_nacimiento),persona.nif, persona.nombre, persona.apellido1, persona.apellido2,persona.ciudad, persona.direccion, persona.telefono,persona.sexo from persona;

11. Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.