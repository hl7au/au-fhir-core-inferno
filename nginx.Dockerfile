# Reverse proxy image for the per-PR preview environments
# (aucore-pr-<n>.preview.inferno.sparked-fhir.com, see the aucore-previews
# ApplicationSet in aehrc/sparked-argo). Bakes the same config/nginx.conf used by
# local compose: it proxies / to http://inferno:4567 and /hl7validatorapi/ to
# http://validator-api:3500/, which match the Service names the preview chart
# creates. Pinned to a minor version for reproducible builds; bump deliberately.
FROM nginx:1.31
COPY ./config/nginx.conf /etc/nginx/nginx.conf
