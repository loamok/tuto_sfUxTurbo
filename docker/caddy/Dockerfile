# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/develop/develop-images/multistage-build/#stop-at-a-specific-build-stage
# https://docs.docker.com/compose/compose-file/#target


# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG CADDY_VERSION=2

FROM caddy:${CADDY_VERSION}-builder-alpine AS sfuxturbo_caddy_builder

RUN xcaddy build \
	--with github.com/dunglas/mercure/caddy \
	--with github.com/dunglas/vulcain/caddy

FROM caddy:${CADDY_VERSION} AS sfuxturbo_caddy

WORKDIR /srv/app

COPY --from=dunglas/mercure:v0.11 /srv/public /srv/mercure-assets/
COPY --from=sfuxturbo_caddy_builder /usr/bin/caddy /usr/bin/caddy
