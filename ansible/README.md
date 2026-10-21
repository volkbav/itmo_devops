 # P1

- [x] [Руками] Проверяем коннект на сервер 93.77.162.150  
- [x] [Руками] Пишем инвентори  
- [x] [Ansible] Проверяем коннект на hello-world  
- [x] [Ansible] Добавляем собственного пользователя  
- [x] [Ansible] Добавляем приватный ключ этому пользователю  
- [x] [Руками] Проверяем

# P2
- [x] Тестируем ad-hoc команду модули ping, command, copy
- [x] Пишем скрипт, который создает в домашнем каталоге файл (модуль command) и выполняем только в том случае, если этот файл не существует
- [x] Создаем директорию. Копируем в нее файл (заранее определенный - random)
- [x] Тестируем удаление файла (ad-hoc команда) и перезапуск плейбука
- [x] Выясняем версию ядра (uname), регистрируем в переменную, выводим ее модулем debug
## P2*
- [ ] выясняем семейство linux (RH, Debian) и используем соответствующий пакетный менеджер, устанавливаем редактор joe
- [ ] 

## P3
- [x] Исследуем модуль setup в ad-hoc команде
- [x] Выведем все сетевые адаптеры двух машин с их IP адресами
- [x] Установим custom-fact хотя бы на fedora
- [x] Получить такой custom -fact (debug)

## P4
из этого сделать роли.
Либо взять с гитлаба
```
---
- name: Определение семейства Linux и установка Joe
hosts: hello-world
become: yes
gather_facts: true

tasks:
- name: Вывести семейство Linux
ansible.builtin.debug:
msg: "Система принадлежит к семейству: {{ ansible_facts['os_family'] }}"

- name: Установить joe через apt (для Debian/Ubuntu)
ansible.builtin.apt:
name: joe
state: present
update_cache: yes
when: ansible_facts['os_family'] == "Debian"

- name: Установить joe через dnf/yum (для RedHat)
ansible.builtin.dnf:
name: joe
state: present
when: ansible_facts['os_family'] == "RedHat"
```