#!/bin/sh

# El script se detiene si hay errores
set -e
echo "########################################"
echo " Aprovisionando adminpc "
echo "########################################"
echo "-----------------"
echo "Actualizando repositorios"
apk update
apk add curl nmap tcpdump wget bash iputils 
echo "Instalamos también sudo y nano"
apk add sudo
apk add nano 
echo "-------------BLINDANDO ACCESO POR SSH EN MAQUINA WWW-------------"
# Creamos el usuario admin_jlgp y le damos permisos de sudo sin contraseña
apk adduser -D admin_jlgp
passwd -u admin_jlgp
adduser admin_jlgp wheel
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

echo "-------------IMPORTANDO CLAVES SSH DESDE EL ANFITRION-------------"
# Movemos las llaves por Vagrant en /temp 
mkdir -p /home/admin_tu_nombre/.ssh
mv /tmp/id_ed25519 /home/admin_jlgp/.ssh/id_ed25519
mv /tmp/id_ed25519.pub /home/admin_jlgp/.ssh/id_ed25519.pub

# Limpiamos posibles retornos de carro de Windows CRLF
sed -i 's/\r$//' /home/admin_jlgp/.ssh/id_ed25519

# Ajustamos permisos por seguridad 
chown -R admin_jlgp:admin_jlgp /home/admin_jlgp/.ssh
chmod 700 /home/admin_jlgp/.ssh
chmod 600 /home/admin_jlgp/.ssh/id_ed25519
chmod 644 /home/admin_jlgp/.ssh/id_ed25519.pub

echo "------ FIN ------"
