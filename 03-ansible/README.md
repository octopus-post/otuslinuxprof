# Less03. Ansible
### Цель:
Написать первые шаги с Ansible.

### Задание:
Подготовить стенд на Vagrant как минимум с одним сервером. На этом сервере используя Ansible необходимо развернуть nginx со следующими условиями:

	- необходимо использовать модуль yum/apt;
	- конфигурационные файлы должны быть взяты из шаблона jinja2 с перемененными;
    - после установки nginx должен быть в режиме enabled в systemd;
    - должен быть использован notify для старта nginx после установки;
    - сайт должен слушать на нестандартном порту - 8080, для этого использовать переменные в Ansible.

### Комментарии:
1. _ansible.cfg_ - файл конфигурации, расположен в домашнем каталоге.
2. _inventory.yml_ - наборы хостов.
3. _less03_playbook.yml_ - плейбук дз.
4. _./templates/nginx.conf.j2_  - шаблон файла конфигурации nginx

Плейбук обновляет пакеты, устанавливает nginx, обновляет конфигурацию nginx из шаблона, перезапускает сервис nginx.
```bash
ansible-playbook less03_playbook.yml
```
> *Задание выполнено без использования Vagrant*

##### Links:
[https://docs.ansible.com/ansible/latest/reference_appendices/config.html](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)

[https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html)
