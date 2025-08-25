#!/bin/bash
snapshot=$(curl -s -XPOST http://127.0.0.1:9090/api/v1/admin/tsdb/snapshot|jq .data.name|sed 's/"//g')
tar -czf /vagrant/backups/monitor/${snapshot}.tgz /var/lib/prometheus/snapshots/${snapshot}
rm -rf /var/lib/prometheus/snapshots/*