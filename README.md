# gentoo-portage-backup-cron

[![License](https://img.shields.io/:license-gpl-green.svg)](https://www.gnu.org/licenses/gpl-3.0.txt)
[![pipeline status](https://gitlab.nis.com.ar/proyectos/gentoo-portage-backup-cron/badges/master/pipeline.svg)](https://gitlab.nis.com.ar/proyectos/gentoo-portage-backup-cron/-/commits/master)


Overlay del portage de Gentoo Linux para ebuilds relacionados con [Backup-cron](https://gitlab.nis.com.ar/proyectos/gentoo-portage-backup-cron).

El conjunto de ebuilds que conforman este proyecto es software libre publicado 
bajo la Licencia Pública General de GNU Versión 2 o posterior, según se publica 
en: http://www.gnu.org/licenses/gpl-2.0.txt

## Acerca de Backup-Cron

Backup-cron es un sistema minimalista de generación de copias de resguardo basado 
en herramientas GNU y en la utilización del planificador Cron.

### Documentación de Backup-Cron

Se encuentra accesible en la [wiki de Backup-cron](https://gitlab.nis.com.ar/proyectos/backup-cron/-/wikis/home)

## Portage

Portage es el gestor de paquetes oficial de la distribución [Gentoo Linux](https://es.wikipedia.org/wiki/Gentoo_Linux), 
[Calculate Linux](https://en.wikipedia.org/wiki/Calculate_Linux), [ChromiumOS](https://en.wikipedia.org/wiki/ChromiumOS), 
y [ChromeOS](https://en.wikipedia.org/wiki/ChromeOS), entre otras.

Implementa gestión de dependencias, afinamiento preciso de los paquetes a gusto 
del administrador, instalaciones falsas (al estilo OpenBSD), entornos de prueba 
durante la compilación, desinstalación segura, perfiles de sistema, paquetes 
virtuales, gestión de los ficheros de configuración y múltiples ranuras para 
distintas versiones de un mismo paquete.

El portage dispone de un árbol local que contiene las descripciones de los paquetes 
de software y las funcionalidades necesarias para instalarlos en archivos llamados 
ebuilds. Este árbol se puede sincronizar con un servidor remoto mediante una orden:

<pre>
emerge --sync
</pre> 

### Extender el portage con los ebuilds de este proyecto

Para extender su portage con los ebuilds desarrollados por este proyecto, debe 
crear el archivo _/etc/portage/repos.conf/backup-cron.conf_ con el siguiente contenido:

<pre>
[backup-cron]
location = /var/db/repos/backup-cron
sync-type = git
sync-uri = https://gitlab.nis.com.ar/proyectos/gentoo-portage-backup-cron.git
auto-sync = yes
</pre>
