1  
  Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
- оба варианта,так как систему необходимо развернуть + планируются частые релизы и доработки

Будет ли центральный сервер для управления инфраструктурой? Будут ли агенты на серверах?  
- Ansible - инструмент подготовки ENV внутри уже подготовленных контейнеров, 
в том числе Terraform - применял бы в части Cloud решений. Так как Ansible инструмент без использования агентов, 
то на сервера не устанавливаются агенты. Ansible - инструмент без центрального сервера.  

Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?
- В части поставленных задач, все, что относится к Private Cloud использовал бы управление конфигурацией, часть сервиса, 
что располагается в Public Cloud - использовал бы инициализацию ресурсов.


2  

vagrant@vagrant:/usr/local/bin$ ll
total 159904
drwxr-xr-x  2 root root     4096 Jul  2 08:03 ./
drwxr-xr-x 10 root root     4096 Jul  2 08:01 ../
-rwxr-xr-x  1 root root 81866210 Dec 17  2020 terraform*
-rwxr-xr-x  1 root root 81866210 Dec 17  2020 terraform_14*
vagrant@vagrant:/usr/local/bin$ terraform_14 --version
Terraform v0.14.3

Your version of Terraform is out of date! The latest version
is 1.2.4. You can update by downloading from https://www.terraform.io/downloads.html
vagrant@vagrant:/usr/local/bin$ terraform --version
Terraform v1.2.4
on linux_amd64
vagrant@vagrant:/usr/local/bin$

 