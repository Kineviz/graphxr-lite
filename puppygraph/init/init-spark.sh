#!/bin/bash

echo "========================================="
echo "Starting Spark Iceberg Initialization"
echo "========================================="

# Wait for REST catalog to be ready
echo "Waiting for REST catalog to be available..."
until curl -s http://rest:8181/v1/config > /dev/null 2>&1; do
  echo "Waiting for REST catalog..."
  sleep 2
done
echo "REST catalog is ready!"

# Execute init-data.sql using spark-sql
echo "Executing init-data.sql..."
if [ -f /tmp/init-completed ]; then
  echo "Initialization already completed, skipping init-data.sql execution."
elif [ -f /home/iceberg/init/init-data.sql ]; then
  # Use spark-sql without explicit packages since they're configured in spark-defaults.conf
  /opt/spark/bin/spark-sql -f /home/iceberg/init/init-data.sql
  
  if [ $? -eq 0 ]; then
    echo "========================================="
    echo "init-data.sql executed successfully!"
    echo "========================================="
    # Create completion marker for healthcheck
    touch /tmp/init-completed
  else
    echo "========================================="
    echo "ERROR: Failed to execute init-data.sql"
    echo "========================================="
    # Do NOT create marker on failure - let healthcheck fail
    exit 1
  fi
else
  echo "WARNING: init-data.sql not found, skipping initialization"
  # Create marker even if no init file (for development)
  touch /tmp/init-completed
fi

# Start pyspark notebook
echo "Starting PySpark Jupyter Notebook..."
exec pyspark
