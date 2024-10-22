# MonkeFe Code Server
This is a containerized version of `code-server`, instead of using the official docker image, this project is based on `fedora:latest` in order to have more recent versions of the dependencies.
## How to use
### Build the image
```bash
docker build -t mfe-code-server-* .
```
### Run the container
#### Detached 
```bash
docker run -d -p "8080:8080" -v '/path/to/project:/home/monke/workspaces/project' -e <...> mfe-code-server-*
```
#### `docker-compose` (recommended)
For custom builds:
```yaml
services:
  web:
    build: . 
    ports:
      - "8080:8080"
      - "8443:8443"
    environment:
      - AUTHENTICATION_MODE=password
      - HASHED_PASSWORD=${HASHED_PASSWORD}
      - HTTPS=false
      - PORT=8080
      - DEBUG=
    volumes:
      - ./certs:/certs
```
Or use prebuilt images:
##### x86
```yaml
services:
  web:
    image: mfe-code-server-x86:latest
    ports:
      - "8080:8080"
      - "8443:8443"
    environment:
      - AUTHENTICATION_MODE=password
      - HASHED_PASSWORD=${HASHED_PASSWORD}
      - HTTPS=false
      - PORT=8080
      - DEBUG=
    volumes:
      - ./certs:/certs
```
##### ARM
```yaml
services:
  web:
    image: mfe-code-server-arm:latest
    ports:
      - "8080:8080"
      - "8443:8443"
    environment:
      - AUTHENTICATION_MODE=password
      - HASHED_PASSWORD=${HASHED_PASSWORD}
      - HTTPS=false
      - PORT=8080
      - DEBUG=
    volumes:
      - ./certs:/certs
```
### Environment Variables
The whole execution is modified by using specific environment variables, the following table shows the available variables and their default values:
| Variable | Default Value | Description |
|----------|---------------|-------------|
| AUTHENTICATION_MODE | password | The authentication mode to access the code-server, it can be `password` or `hashed` |
| PASSWORD | password | The password to access the code-server |
| HASHED_PASSWORD | | The hashed password to access the code-server |
| PORT | 8080 | The port to expose the code-server |
| HTTPS | false | Enable HTTPS |
| GITHUB_TOKEN | | The GitHub token to access the GitHub API |
| DEBUG | false | Enable debug mode (log the executed command) |
### HTTPS and certificates
If you want to enable HTTPS, you need to provide a volume mounted to `/certs` with the following files:
- `cert.pem`: The certificate file
- `key.pem`: The key file
### TODO
- [ ] Write example for `docker run` and `docker-compose`
- [ ] Write example for `HTTPS` and certificates
- [ ] Write example for `GITHUB_TOKEN`
- [ ] Handle `$EXTENSIONS` to install extensions
- [ ] Handle `$SETTINGS` to set the settings.json
- [ ] Handle `$WORKSPACE` to set the workspace

