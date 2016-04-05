# gentoo-portage-backup-cron
Overlay del portage de Gentoo Linux para ebuilds relacionados con [Backup-cron](https://proyectos.ingeniovirtual.com.ar/projects/backup-cron).

El conjunto de ebuilds que conforman este proyecto es software libre publicado bajo la Licencia Pública General de GNU, según se publica en: http://www.gnu.org/licenses/gpl-2.0.txt

## Acerca de Backup-Cron

Backup-cron es un sistema minimalista de generación de copias de resguardo basado en herramientas GNU y en la utilización del planificador Cron.

### Documentación de Backup-Cron

Se encuentra accesible en la [wiki de Backup-cron](https://proyectos.ingeniovirtual.com.ar/projects/backup-cron/wiki)

## Portage

Portage es el gestor de paquetes oficial de la distribución de Linux [Gentoo](https://es.wikipedia.org/wiki/Gentoo_Linux) y también el de [Funtoo Linux](https://en.wikipedia.org/wiki/Funtoo_Linux), [Sabayon](https://en.wikipedia.org/wiki/Sabayon_Linux) y [Google Chrome OS](https://es.wikipedia.org/wiki/Chrome_OS) entre otras.

Implementa gestión de dependencias, afinamiento preciso de los paquetes a gusto del administrador, instalaciones falsas (al estilo OpenBSD), entornos de prueba durante la compilación, desinstalación segura, perfiles de sistema, paquetes virtuales, gestión de los ficheros de configuración y múltiples ranuras para distintas versiones de un mismo paquete.

El portage dispone de un árbol local que contiene las descripciones de los paquetes de software y las funcionalidades necesarias para instalarlos en archivos llamados ebuilds. Este árbol se puede sincronizar con un servidor remoto mediante una orden:

<pre>
emerge --sync
</pre> 

### Extender el portage con los ebuilds de este proyecto

Para extender su portage con los ebuilds desarrollados por este proyecto, debe crear el archivo _/etc/portage/repos.conf/backup-cron.conf_ con el siguiente contenido:

<pre>
[backup-cron]
location = /usr/local/portage/backup-cron
sync-depth = 1
sync-type = git
sync-uri = https://github.com/ingeniovirtual/gentoo-portage-backup-cron.git
auto-sync = yes
</pre>

### Problemas con la primera sincronización del repositorio

Para el caso de advertir problemas al sincronizar el repositorio por primera vez, cambie el valor _sync-depth = 1_ por _sync-depth = 0_ en el archivo _/etc/portage/repos.conf/odoo.conf_.

