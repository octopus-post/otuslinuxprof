### Пакетные менеджеры
    - RPM Package Manager – Red Hat (.rpm)
    - DPKG – Debian (.deb)
    - Pacman – ArchLinux (.pkg.tar.zst)
    - Snap – Ubuntu
    - Flatpack
    - AppImage
### RPM
- Используется в Red Hat дистрибутивах
- Форматы: *.rpm (бинарные), *.srpm (исходники)
- Базовая утилита: rpm
- Управление с зависимостями: yum, dnf
- Конфигурация в CentOS: /etc/yum, /etc/yum.repos.d

|Команда|Назначение|
|---|---|
|||
rpm -ivh <file> - установка из файла
yum (dnf) install <package> — установка из репозитория
yum localinstall <file> – установка из файла
rpm -Uvh <file> – обновление из файла
rpm -ev <package> – удаление пакета
yum (dnf) remove <package> – удаление пакета
yum update — обновление всех пакетов
dnf upgrade — обновление всех пакетов
yum (dnf) search – поиск пакета
rpm -qi <package> – информация о пакете
rpm -ql <package> – список файлов пакета
rpm -qa – список установленных пакетов
yum makecache — обновить список пакетов
yum check-update – проверить наличие обновлений

### DPKG (DEB)

 - Форматы: *.deb (бинарные), *.tar.xz (исходники)
 - Базовая утилита: dpkg
 - Управление с зависимостями: apt, apt-get, aptitude
 - Конфигурация в Ubuntu: /etc/apt, /etc/apt/sources.list.d

|Команда|Назначение|
|---|---|
|||
dpkg -i <file> — установка из файла
apt install <package\|file> – установка из файла, репозитория
dpkg -r <package> – удаление пакета
apt remove <package> – удаление пакета
apt purge <package> – удаление пакета целиком
apt update – обновление списка пакетов
apt upgrade – обновление всех пакетов
apt -f install — разрешение проблем с пакетами
apt autoremove – удаление ненужных пакетов
apt clean — удалить скачанные пакеты
apt list <pattern> – список пакетов по названию
apt-cache showpkg <package> – информация о пакете
dpkg -L <package> – список установленных файлов

[exemple shellspec.spec](https://github.com/nixuser/package-example/blob/main/shellspec.spec)
