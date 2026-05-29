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