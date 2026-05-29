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