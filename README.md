# Seccion 1

Se utilizo t3.micro debido a que amazon indicaba que t2.micro estaba de el free tier, tambien como aparentemente el otro candidato estaba trabajando antes que yo, utilize mi nombre alfinal de algunas politicas para evitar sobre-escribir las suyas, por lo que muchas cosas quedaron de la siguiente forma ec2-s3-readonly-role-ignacio

Se utiliza la prinicipio de mínimo privilegio, en este caso únicamente para listar y leer, limitando lo que puede hacer. Esto para prevenir vulnerabilidad y posibles errores que puedan suceder en el momento de trabajar sobre la manica, y asi evitar la alteración o eliminación de archivos de forma no deseada

En las captures se puede observar el funcionamiento de la maquina y como es posible conectarse al S3, pero no es posible copiar archivos a el, ya que esto nos arroja un error

# Seccion 2

# 1. ¿Cuál es la causa raíz del error de compilación y cómo lo resolverías?

El log nos indica que el error es debido a una incompatibilidad de version en el proyecto, ya que nos indica  Source option 5 is no longer supported", tambien nos indica que el error nos lo da maven, por lo que hay que actualizar es la version de java, en este caso a una superior de 7

# 2. ¿Por qué falla el SCP? Lista al menos 3 posibles causas y cómo verificarías cada una.

En este caso el scp puede fallar por varias razones, siendo algunas de estas:

- El servidor se encuentre fuera de servicio, ya que el log nos dice timeout
- En caso de amazon, error en el security group o que no tenga los permisos suficientes y que el SG nos corte el paso
- Problemas en la configuracion de red o enrutamiento

En caso de que sea un error por security group y/o que se nos este bloqueando el puerto nosotros podriamos entrar, realizar un nc o un nmap a el puerto que queremos comprobar, en este caso siendo el 22 y ahi ver el estado del mismo, en caso de estar "filtered" es porque el firewall o SG tiene el puerto bloqueado

# 3. ¿En qué orden priorizas los arreglos y por qué? 

Nuestro objetivo es siempre mantener el sistema funcional para el usuario, y en este caso nuestra prioridad seria arreglar maven, ya que lo que mantiene al servicio funcionando, no nos sirve arreglar la red si el servicios fallara de todas formas, y dependiendo de la urgencia se pueden crear excepciones para levantar la rad hasta tener todo funcional, por lo cual el orden seria

- Maven, Ci/CD
- red

# Seccion 3

# 1. ¿Qué patrón ves en api-payments? ¿Qué hipótesis tienes?

Se ve un experimentados picos de uso de CPU superiores al 90 esto durante horarios concretos, al rededor de las 2 AM con duraciones aproximadas de 8 minutos

Es posible que un cronjob o algun proceso este este usando mas cpu de lo esperada, siendo esta un backup u otro tipo de proceso

En el peor de los casos, es posible que sea un ataque, ya que ese horario no es el de un usuario normal

# 2. ¿Qué harías de inmediato con db-replica Disk > 85% continua?

Ya que la alarma nos inidica que es continua, eso nos quiere decir que el disco esta apunto de llenarse, lo primero seria entrar en el sistema de archivos y ver que es lo que lo esta llenando, ya que algunos casos esto puede deverese a la acumulacion de logs de algunos programas o servicios y de ser ese el caso tendriamos que revisar porque nos esta sucediendo esto

Si es crecimiento real de datos, solicitaría una ampliación de volumen del disco

# 3. ¿Qué relación hay entre los eventos del 25-May a las 09:45 y 09:47?

Es un error de falla en los servicios, primero cae el auth-service y luego cae el api-payments, La conclusión seria que api-payments depende de auth-service para validar los tokens u otros permisos de los usuarios antes de procesar un pago, al caerse la autenticación, la API de pagos no pudo resolver las peticiones y cae también.

# Parte B — Comandos Linux (10 pts):

Escribe el comando bash para cada tarea sobre un archivo catalina.log:
1. Filtrar líneas con ERROR o SEVERE y guardarlas en errores.log.

grep -E "ERROR|SEVERE" catalina.log > errores.log

2. Contar ocurrencias de OutOfMemoryError.

grep -c "OutOfMemoryError" catalina.log

3. Extraer todas las IPs únicas con formato x.x.x.x.

grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" catalina.log | sort -u

# Seccion 4

En la carpeta se encuentras las capturas del bash y ademas una pequeña guia de uso demostrando su funcionalidad 
