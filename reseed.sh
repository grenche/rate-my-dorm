psql rate-my-dorm -f ./migrations/drop.sql && \
psql rate-my-dorm -f ./migrations/createtables.sql && \
psql rate-my-dorm -f ./migrations/seed.sql