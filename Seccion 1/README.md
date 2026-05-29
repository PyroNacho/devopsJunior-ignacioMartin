Se utilizo t3.micro debido a que amazon indicaba que t2.micro estaba de el free tier, tambien como aparentemente el otro candidato estaba trabajando antes que yo, utilize mi nombre alfinal de algunas politicas para evitar sobre-escribir las suyas, por lo que muchas cosas quedaron de la siguiente forma ec2-s3-readonly-role-ignacio


Se utiliza la prinicipio de mínimo privilegio, en este caso únicamente para listar y leer, limitando lo que puede hacer. Esto para prevenir vulnerabilidad y posibles errores que puedan suceder en el momento de trabajar sobre la manica, y asi evitar la alteración o eliminación de archivos de forma no deseada

En las captures se puede observar el funcionamiento de la maquina y como es posible conectarse al S3, pero no es posible copiar archivos a el, ya que esto nos arroja un error