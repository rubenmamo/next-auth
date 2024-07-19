#!/usr/bin/env bash
echo "starting cosmos script"

CONTAINER_NAME=authjs-azure-cosmosdb-test

# Start db
docker run \
    --publish 8081:8081 \
    --publish 10250-10255:10250-10255 \
    --name ${CONTAINER_NAME}  \
    --detach \
    mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator:latest   

echo "Waiting 240s for db to start..."
sleep 240


TESTMODE=NOPK
if vitest run -c ../utils/vitest.config.ts; then
  echo "Executed test with no partition key definition"
else
  docker stop ${CONTAINER_NAME} && exit 1
fi

TESTMODE=ID

if vitest run -c ../utils/vitest.config.ts; then
  echo "Executed test with same as id partition key strategy"
else
  docker stop ${CONTAINER_NAME} && exit 1
fi

TESTMODE=DT

if vitest run -c ../utils/vitest.config.ts; then
  echo "Executed test with same as id dataType strategy"
else
  docker stop ${CONTAINER_NAME} && exit 1
fi

TESTMODE=HC

# Always stop container, but exit with 1 when tests are failing
if vitest run -c ../utils/vitest.config.ts; then
  echo "Executed test with hardcoded partition key strategy"
  docker stop ${CONTAINER_NAME}
else
  docker stop ${CONTAINER_NAME} && exit 1
fi
