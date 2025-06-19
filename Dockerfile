# Verwende offizielles Nginx Image
FROM nginx:alpine

# Installiere notwendige Pakete
RUN apk add --no-cache openssl && \
    mkdir -p /etc/nginx/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/nginx.key \
    -out /etc/nginx/certs/nginx.crt \
    -subj "/CN=localhost"

# Kopiere Nginx Konfiguration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Kopiere die Webseite in den Container
COPY index.html /usr/share/nginx/html/

# Expose Ports für HTTP und HTTPS
EXPOSE 80
EXPOSE 443

# Starte Nginx im Vordergrund
CMD ["nginx", "-g", "daemon off;"]
