```
services:
  gitlab:
    image: gitlab/gitlab-ce:17.3.0-ce.0
    container_name: gitlab
    restart: always
    hostname: 'gitlab.vmtlw.ru'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'https://gitlab.vmtlw.ru'
        nginx['redirect_http_to_https'] = false
        nginx['listen_port'] = 80
        nginx['listen_https'] = false
        nginx['client_max_body_size'] = '2G'
        registry_external_url 'https://gitlab.vmtlw.ru'
        registry_nginx['listen_port'] = 80
        registry_nginx['listen_https'] = false
        registry_nginx['redirect_http_to_https'] = false


    volumes:
      - './config:/etc/gitlab'
      - './logs:/var/log/gitlab'
      - './data:/var/opt/gitlab'
    shm_size: '256m'
    networks:
      - proxy
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.gitlab.rule=Host(`gitlab.vmtlw.ru`)"
      - "traefik.http.routers.gitlab.entrypoints=http"
      - "traefik.http.routers.gitlab.service=gitlab"
      - "traefik.http.routers.gitlab-secure.rule=Host(`gitlab.vmtlw.ru`)"
      - "traefik.http.routers.gitlab-secure.entrypoints=https"
      - "traefik.http.routers.gitlab-secure.service=gitlab"
      - "traefik.http.routers.gitlab-secure.tls.certresolver=letsencrypt"
      - "traefik.http.routers.gitlab-secure.tls=true"
      - "traefik.http.routers.gitlab-secure.middlewares=gitlab-sts"

      - "traefik.http.services.gitlab.loadbalancer.server.port=80"
      - "traefik.http.services.gitlab.loadbalancer.server.scheme=http"
      - "traefik.http.services.gitlab.loadbalancer.passhostheader=true"

      - "traefik.http.routers.registry.rule=Host(`gitlab.vmtlw.ru`)"
      - "traefik.http.routers.registry.entrypoints=http,https"
      - "traefik.http.routers.registry.service=registry"
      - "traefik.http.routers.registry.tls.certresolver=letsencrypt"
      - "traefik.http.routers.registry.tls=true"
      - "traefik.http.services.registry.loadbalancer.server.port=80"
networks:
  proxy:
    external: true
```


