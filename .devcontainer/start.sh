#!/bin/bash
/opt/mssql/bin/sqlservr &

# Keep container alive
tail -f /dev/null
