#!/bin/python

file = open('/proc/meminfo', 'r')
memory_total = int(file.readline().split()[1])
file.readline()
memory_available = int(file.readline().split()[1])
print(f"{round((memory_total - memory_available) / 1024 / 1024, 1)} GiB")
