# Práctica 1.1 - Preparar infraestructura con Vagrant 
**Autor:** José Luis Golbano Pacheco  
**Módulo:** Seguridad y Alta Disponibilidad (SAD)  
**Curso:** 2ºASIR 2026/27

## Objetivo
El objetivo de esta actividad es desplegar de manera automática una infraestructura de red haciendo uso de Vagrant y VirtualBox. 

## Estructura de la red 
![estructura_red](/images/estructura_red.PNG)  
  
La red interna va a estar organizada en tres subredes:  
 1. **DMZ:** Para alojar los servicios de la empresa. 
 2. **LAN:** Para los empleados de la empresa. 
 3. **GESTION:** Para gestionar los servicios. 

La red en total contará con un despliegue de 6 máquinas virtuales:
1. **gw:** Hará de router y de gateway.
2. **idp:** Servidor de identidad.
3. **adminpc:** Equipo de administración.
4. **empleado:** Equipo de emplado. 
5. **proxy:** Servidor proxy.
6. **www:** Servidor Web. 

## Instrucciones para poder desplegar el proyecto

### Clonar el respositorio
```bash
git clone git@github.com:joseluisgolbano/proyecto_sad_jgolpac081.git
``` 
### Iniciar las máquinas virtuales 
```bash
vagrant up
```

### Comprobar el estado de las máquinas
```bash
vagrant status
```

### Acceder a una máquina virtual
```bash
vagrant ssh 'nombre'
```

### Apagar las máquinas
```bash
vagrant halt
```

### Reiniciar las máquinas
```bash
vagrant reload
```

### Reiniciar las máquinas y ejecutar el aprovisionamiento
```bash
vagrant reload --provision
```

### Eliminar máquinas
```bash
#Para eliminar 1 máquina
vagrant destroy 'nombre'

#Para eliminar todas
vagrant destroy

#Para eliminar solicitando confirmación
vagrant destroy -f
```

## Salida a WAN de las máquinas
Se ha configurado el script `provisions.sh` de la máquina `gw` para que las máquinas tengan acceso a Internet. 
```bash
#Para habilitar el enrutamiento
sysctl -w net.ipv4.ip_forward=1

#Modificar la tabla de enrutamiento para que las máquinas sepan por donde salir con NAT
iptables -t nat -A POSTROUTING -s 172.1.44.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.2.44.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.3.44.0/24 -o eth0 -j MASQUERADE
```

## Comprobaciones del proyecto

### Máquinas creadas
#### Máquinas creadas en Virtual Box
![vbox maquinas creadas](/images/vbox_maquinas.PNG)  

#### Status con vagrant
![vagrant status](/images/1.1.PNG)
### Ping desde la máquina 'empleado'
![ping](/images/6.1.PNG)

### Curl desde la máquina 'empleado'
![curl](/images/6.2.PNG)

### Comando nmap desde la máquina 'adminpc'
![nmap](/images/6.3.PNG)


