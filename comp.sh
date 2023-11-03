#!/bin/bash

gcc server_fast.c -lfcgi -o server_fast
spawn-fcgi -p 8080 ./server_fast
service nginx start
