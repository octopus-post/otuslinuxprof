# Less38. LDAP. Централизованная авторизация и аутентификация 
- [Less38. LDAP. Централизованная авторизация и аутентификация](#less38-ldap-централизованная-авторизация-и-аутентификация)
    - [Цель:](#цель)
    - [Содержание:](#содержание)
    - [Результаты:](#результаты)
    - [Компетенции](#компетенции)
    - [Задание:](#задание)
    - [Формат сдачи:](#формат-сдачи)
    - [Критерии оценки:](#критерии-оценки)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
- объяснить, что такое LDAP и зачем нужен;
- разобрать базовую настройку LDAP на примере.
  
### Содержание:
- AAA;
- NSS;
- LDAP;
- централизация управления доступом.
 
### Результаты:
- использовать “взрослые” готовые (и не очень) решения.

### Компетенции

Работа с сетевой подсистемой
 - управлять учетным данными с помощью протокола LDAP

 
### Задание:
- Научиться настраивать LDAP-сервер и подключать к нему LDAP-клиентов;
   
Что нужно сделать?

1) Установить FreeIPA
2) Написать Ansible-playbook для конфигурации клиента

Дополнительное задание
3)* Настроить аутентификацию по SSH-ключам
4)** Firewall должен быть включен на сервере и на клиенте

### Формат сдачи: 
Формат сдачи ДЗ - vagrant + ansible

### Критерии оценки:
Статус «Принято» ставится при выполнении следующих условий:
1. Сcылка на репозиторий GitHub.
2. Vagrantfile, который будет разворачивать виртуальные машины
3. Настройка виртуальных машин происходит с помощью Ansible.
4. Документация по каждому заданию:
Создайте файл README.md и снабдите его следующей информацией:
- название выполняемого задания;
- текст задания;
- схема сети;
- особенности проектирования и реализации решения, 
- заметки, если считаете, что имеет смысл их зафиксировать в
репозитории.

### Комментарии к выполнению задания:

1. Порядок выполнения первой части задания: [./appendix/commandset.md#1-установка-freeipa-сервера](./appendix/commandset.md#1-установка-freeipa-сервера)
2. Порядок выполнения второй части задания и проверка результатов: [./appendix/commandset.md#2-ansible-playbook-для-конфигурации-клиента](./appendix/commandset.md#2-ansible-playbook-для-конфигурации-клиента)


### Links:

- [commandset.md](./appendix/commandset.md)
- Статья о LDAP - https://ru.wikipedia.org/wiki/LDAP
- Статья о настройке FreeIPA - https://www.dmosk.ru/miniinstruktions.php?mini=freeipa-centos
- FreeIPA wiki - https://www.freeipa.org/page/Wiki_TODO
- Статья «Chapter 13. Preparing the system for IdM client installation» - https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/installing_identity_management/preparing-the-system-for-ipa-client-installation_installing-identity-management
- Статья «про LDAP по-русски» - https://pro-ldap.ru/

=======

- https://ipa.demo1.freeipa.org
- https://datatracker.ietf.org/doc/html/draft-howard-rfc2307bis#section-2.2.1
- https://datatracker.ietf.org/doc/html/draft-howard-rfc2307bis#section-3
- https://datatracker.ietf.org/doc/html/draft-howard-rfc2307bis#section-4
- https://ldap.com/ldap-oid-reference-guide/
- 
