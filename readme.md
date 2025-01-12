# ecodms-postgres-docker

This docker image is a custom installation of ecodms without a postgres database inside the ecodms docker.
The postgres database needs to be a separate database. (This approach is more docker-native and a custom postgres installation (e. g. cluster) can be used)

## Usage
Build the container with `docker build -t localhost:5000/ecodms src/`

An example `docker-compose.yml` file can be found in this repo.

Current limitations:
- the postgres hostname and credentials cannot be changed

### restore backup
1. map your backup zip file to the docker path of `/data/restore/restore.zip`
2. set the environment variable `BACKUP_RESTORE` to a non-empty value to enable the backup restore process to happen
3. start the container and the restore process will start.
4. after everything worked correctly, remove the environment variable and recreate the container


#### Todo's
- [ ] make env for postgres db
- [ ] shell script with minio backup upload
- [ ] add docker for sharing the scaninput folder


&copy; 2025 Trickfilm400