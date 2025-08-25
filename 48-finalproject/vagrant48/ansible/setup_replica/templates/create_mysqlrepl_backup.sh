#!/bin/bash
mysqladmin stop-replica
mysqldump --all-databases > {{ backup_dir }}/mysqlrepl/mysqlrepl_dump_$(date +"%Y-%m-%d_%H:%M").sql
mysqladmin start-replica
