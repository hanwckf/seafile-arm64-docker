#!/bin/bash
exec 2>&1
exec /usr/bin/memcached -u memcached -m 256
