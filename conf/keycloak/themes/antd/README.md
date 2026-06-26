# Keycloak Ant Design Theme for Keycloak 26

A custom Keycloak theme that matches the Ant Design 5.12.0 styling used in the CMDB application. This theme is designed for **Keycloak 26.2.4+**.

## Theme Structure (Keycloak 26)

```
antd/
├── theme.properties              # Main theme configuration
├── login/
│   ├── theme.properties          # Login theme config
│   ├── resources/
│   │   ├── theme.properties      # Resources config
│   │   ├── css/
│   │   │   └── login.css          # Ant Design styles
│   │   ├── js/
│   │   │   └── login.js          # JavaScript (optional)
│   │   └── img/
│   │       └── favicon.ico       # Favicon
│   └── templates/
│       ├── template.ftl          # Base template (required)
│       └── login.ftl             # Login page template
└── account/
    └── theme.properties          # Account theme config
```

## Key Differences from Older Keycloak Versions

1. **Parent theme**: Use `parent=keycloak` instead of `parent=base`
2. **Template location**: Templates must be in `templates/` subdirectory
3. **Resources location**: CSS/JS must be in `resources/css/` and `resources/js/`
4. **Base template**: `template.ftl` is required for macro definitions

## Enabling the Theme

### Option 1: Per Client (Recommended - Already Configured)

The theme is already configured in `/root/cmdb/conf/keycloak/clients/cmdb.json`:

```json
{
  "attributes": {
    "login_theme": "antd"
  }
}
```

### Option 2: Per Realm

1. Log in to Keycloak Admin Console (https://localhost:4443/idm)
2. Navigate to **Realm Settings** → **Themes**
3. Set **Login Theme** to `antd`
4. Click **Save**

### Option 3: Per Account Console

1. Navigate to **Realm Settings** → **Themes**
2. Set **Account Theme** to `antd`
3. Click **Save**

## Troubleshooting

### Theme Not Showing Up

1. **Check theme.properties** - Ensure main theme.properties has correct parent:
   ```properties
   parent=keycloak
   import=common/keycloak
   ```

2. **Check directory structure** - Must match exactly:
   ```
   antd/login/templates/login.ftl
   antd/login/resources/css/login.css
   ```

3. **Check Keycloak logs** - Look for theme loading errors:
   ```bash
   docker-compose logs keycloak | grep -i theme
   ```

4. **Verify volume mount** - Check theme is mounted correctly:
   ```bash
   docker exec -it <container_name> ls -la /opt/keycloak/data/themes/antd
   ```

5. **Restart Keycloak** after theme changes:
   ```bash
   docker-compose restart keycloak
   ```

### Common Issues

| Issue | Solution |
|-------|----------|
| Theme not listed in admin | Check `parent=keycloak` in theme.properties |
| Styles not loading | Verify CSS path: `resources/css/login.css` |
| Templates not loading | Verify templates are in `templates/` subdirectory |
| Old Keycloak theme breaks | Use `parent=keycloak` instead of `parent=base` |

## Styling Reference

### Color Palette

| Color | CSS Variable | Value |
|-------|-------------|-------|
| Primary | `--kc-antd-primary` | `#1677ff` |
| Primary Hover | `--kc-antd-primary-hover` | `#4096ff` |
| Success | `--kc-antd-success` | `#52c41a` |
| Warning | `--kc-antd-warning` | `#faad14` |
| Error | `--kc-antd-error` | `#ff4d4f` |
| Border | `--kc-antd-border` | `#d9d9d9` |

### Typography

- **Font Family**: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial
- **Font Size**: 14px (base)
- **Line Height**: 1.5715

### Spacing

- **Border Radius**: 6px
- **Input Height**: 32px
- **Card Padding**: 24px

## Customization

### Changing Primary Color

Update CSS variables in `login/resources/css/login.css`:

```css
:root {
  --kc-antd-primary: #your-color;
  --kc-antd-primary-hover: #your-hover-color;
}
```

### Adding Custom Logo

1. Place logo in `login/resources/img/`
2. Update `login/templates/login.ftl`:
   ```html
   <img src="${url.resourcesPath}/img/your-logo.png" alt="Logo">
   ```

## Testing

1. **Start Keycloak**:
   ```bash
   docker-compose up -d keycloak
   ```

2. **Access login page**:
   ```
   https://localhost:4443/idm/realms/100000001/protocol/openid-connect/auth
   ```

3. **Verify**:
   - Login card is centered with Ant Design styling
   - Form fields match Ant Design Input component
   - Primary button uses Ant Design blue
   - Responsive design works on mobile

## References

- [Keycloak Theme Documentation](https://www.keycloak.org/ui-customization/themes)
- [Keycloak GitHub Issues - Theme](https://github.com/keycloak/keycloak/issues?q=is%3Aissue+theme)
- [Ant Design Design Tokens](https://ant.design/token/)
