# задание из Задания_Number_B
# code "2S"

# Project 2_S - Задание 2 Paramico
import socket
import time
from datetime import datetime
from getpass import getpass
from pprint import pprint

import paramiko

password = getpass()
print(password)

username = input('enter username ')


def send_show_command(
    ip,
    username,
    password,
    enable,
    commands,
    max_bytes=60000,
    short_pause=3,
    long_pause=10,
):
    cl = paramiko.SSHClient()
    cl.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    # connection
    try:
        cl.connect(
            hostname=ip,
            username=username,
            password=password,
            look_for_keys=False,
            allow_agent=False,
        )
    except Exception as e:
        print(e)
        return None
    
    try:
        with cl.invoke_shell() as ssh:
            ssh.send("enable\n")
            ssh.send(f"{enable}\n")  # password for privileged EXEC mode - cisco
            time.sleep(short_pause)
            ssh.send("terminal length 0\n")
            time.sleep(short_pause)
            ssh.recv(max_bytes)

            result = {}
            # send command
            for command in commands:
                ssh.send(f"{command}\n")
                ssh.settimeout(5)
                
                # receive data from session
                output = ""
                while True:
                    try:
                        part = ssh.recv(max_bytes).decode("utf-8")
                        output += part
                        time.sleep(0.5)
                    except socket.timeout:
                        break
                result[command] = output

            return result
    except Exception as e:
        print(f'exception: {e}')
    finally:
        cl.close()


def write_to_file(data, name=''):
    if not data:
        return
    
    time_stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    file_name = f'{time_stamp}_{name}_config.txt'
    with open(
        file_name, 
        'w',
        encoding="utf-8"
    ) as f:
        for command, output in data.items():
            f.write(f"\n===== {command} =====\n")
            f.write(output)
            

devices = ['192.168.100.1', '192.168.100.2', '192.168.100.3']
commands = ['show running-config']
for ip in devices:
    result = send_show_command(
        ip,
        username,
        password,
        "enable123",  # enable = 
        commands,
        )
    
    pprint(result, width=120)
    write_to_file(result, ip)

