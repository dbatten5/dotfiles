#!/usr/bin/env bash

infilmation_key_path="${HOME}/.ssh/infilmation"
infilmation_host="root@138.68.151.231"

# create a backup on the server
ssh -i "${infilmation_key_path}" "${infilmation_host}" \
    'docker exec infilmation_db_1 pg_dump -U postgres -w -F p infilmation > infilmation_dump.sql' \
    ' && docker cp infilmation_db_1:infilmation_dump.sql . 2> /dev/null' \
    ' && docker exec infilmation_db_1 rm infilmation_dump.sql'

# copy backup to local backups
cur_date="$(date +'%s')"
scp -i "${infilmation_key_path}" "${infilmation_host}:~/infilmation_dump.sql" \
    "${HOME}/Desktop/infilmation_dumps/dump_${cur_date}.sql"

# delte backup from server
ssh -i "${infilmation_key_path}" "${infilmation_host}" \
    'rm infilmation_dump.sql'
