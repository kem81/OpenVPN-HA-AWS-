## Purpose

To build a new, fully documented, tested and modern replacement for OpenVPN. The previous service, being single-headed is not resiliant and suffers from irregular update schedules.
The solution defined within this repo is built on OpenVPN-Access Server in a cluster configuration.


## Technology/Infrastructure

The foundational infrastructure is established within the AWS cloud platform, leveraging two EC2 instances operating on Ubuntu 22.04. 
These instances are strategically placed in distinct availability zones to enhance system resilience. The OpenVPN application is configured in a cluster mode, complemented by a DNS round-robin configuration facilitated through AWS Route53.

The backend application's data and configuration are stored in an AWS RDS SQL server, configured to operate in a multi-Availability Zone (AZ) setup to ensure redundancy and fault tolerance. Furthermore, the OpenVPN installation and updates are efficiently managed by Ansible, leveraging AWS Systems Manager (SSM). Backups are also scheduled and set using tags with AWS Backup service.


![image](https://github.com/kem81/OpenVPN-HA-AWS-/assets/45514659/ee4d5007-8bd9-43d7-b513-64b1789afdfe)






## People

Kemal Suleyman, DevOps Engineer
