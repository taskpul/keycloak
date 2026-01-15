# Mattercall Keycloak Theme

This folder contains the Mattercall theme assets plus Docker tooling for local dev and production builds.

## Theme structure

```
themes/
└── src/main/resources/theme/mattercall/
    └── login/
        ├── login.ftl
        ├── register.ftl
        ├── theme.properties
        └── resources/
            ├── css/mattercall.css
            └── img/logo.svg
```

## Local development workflow (Docker Compose)

From the repository root:

```bash
docker compose -f mattercall-theme/docker-compose.yml up
```

Open Keycloak at:

```
http://localhost:8080
```

Log in to the admin console with:

```
username: admin
password: admin
```

Then enable the theme:

1. **Realm Settings → Themes**
2. Set **Login Theme** to `mattercall`
3. Click **Save**

Reload the login page to see changes. The theme is volume-mounted, so edits to the FTL/CSS files are picked up immediately after a page refresh.

## Production workflow

### Build and push the image

From the repository root (replace the registry/repo/tag as needed):

```bash
docker build -f mattercall-theme/Dockerfile -t registry.example.com/mattercall/keycloak:1.0.0 .
docker push registry.example.com/mattercall/keycloak:1.0.0
```

### Deploy

Update your deployment to use the new image and configure the hostname:

```bash
kubectl set image deployment/keycloak keycloak=registry.example.com/mattercall/keycloak:1.0.0
kubectl set env deployment/keycloak KC_HOSTNAME=auth.mattercall.com
```

### Enable the theme in Keycloak

1. **Realm Settings → Themes**
2. Set **Login Theme** to `mattercall`
3. Click **Save**

## Notes

- The custom theme inherits from the `keycloak.v2` parent theme.
- To adjust colors, update `themes/src/main/resources/theme/mattercall/login/resources/css/mattercall.css`.
- Replace the placeholder logo at `themes/src/main/resources/theme/mattercall/login/resources/img/logo.svg`.
