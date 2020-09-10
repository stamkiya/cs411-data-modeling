DATABASE_NAME=$1 # employee_assignment01, employee_a01_2ndmodel

mysqldump -u root $DATABASE_NAME > $1.sql
