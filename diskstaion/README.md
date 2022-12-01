## Diskstation Configuration

![](img/Diskstation.png)

Diskstation DS918+.
* Intel Celeron J3455 Quad Core 1.5 burst up to 2.3 GHz
* 4GB DDR3L Memory
* 4x 8TB WD Red NAS Drive
* Dual RJ-45 1GbE LAN in IEEE 802.3ad Draft V1 XOR Link aggregation

### Internal Applications
| Logo | Name | Description |
|---|---|---|
| ![iSCSI](img/SANManager_128.png) | iSCSI LUN | Storage over Network|
| ![LDAP](img/LDAPServer_128.png) | LDAP | Centralized user management |
| ![Drive](img/DriveAdminConsole_128.png) | Drive | Distributed File Synchronization |
| ![DNS](img/DNS_128.png) | Internal DNS | For internal DNS to avoid leaving Domain |
| ![Hyper Backup](img/HyperBackup_128.png)  | Hyper Backup | Local and Remote Backup Snapshots |
| ![MariaDB](img/MariaDB_128.png) | MariaDB | MySQL like database (Unused) |
| ![Docker](img/docker_128.png) | Docker  | See [Docker Section](##Docker Containers) |


### Docker Containers
The following containers are "production" and running at all times.

| Logo | Name | Description |
|---|---|---|
| ![Authelia](img/Authelia_128.png) | [Authelia](https://www.authelia.com) | HTTPAuthProxy allowing LDAP authentication via Basic or oAuth |
| ![Traefik](img/traefik-seeklogo.com.svg) | [Traefik](https://traefik.io/) | Loadbalancer From Internet to Diskstation and K3S |
| ![Prometheus](img/Prometheus_software_logo.svg) | [Prometheus](https://prometheus.io/) | Monitoring of network trafik |
| ![Grafana](img/grafana-seeklogo.com.svg) | [Grafana](https://grafana.com/) | Presentation ofmonitoring data  |
| ![Registry](img/Registry_128.png) | [Docker Registry](https://hub.docker.com/_/registry) | Internal Docker registry for home built containers. |

## Loadbalancer Configuration
Traefik diverts trafic from Internet to Diskstation or K3s based on DNS.

Traefik can also divert Authentication to Authelia that does LDAP lookups for users and realms using 
[ForwardAuth Middleware](https://doc.traefik.io/traefik/middlewares/http/forwardauth/)


![](img/Diskstation-LoadBalancer.drawio.png)

[Back](../about-homelab/README.md)