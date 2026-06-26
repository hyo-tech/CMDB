<#--
  Ant Design Style Login Page for Keycloak 26
  Uses template.ftl for layout
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage="true">
    <form id="kc-form-login" class="kc-form" action="${url.loginAction}" method="post">
      <div class="kc-form-group">
        <label class="kc-label kc-label-login-title">
          ${msg("signInToYourAccount")}
        </label>
        <label for="username" class="kc-label <#if !usernameHidden??>kc-label-required</#if>">
          <#if !(realm.loginWithEmailAllowed!false)>${msg("username")}<#elseif !(realm.registrationEmailAsUsername!false)>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
        </label>
        <input
          tabindex="1"
          id="username"
          class="kc-input"
          name="username"
          value="${(login.username!'')}"
          type="text"
          <#if usernameHidden??>style="display:none;"</#if>
          autofocus
          autocomplete="username"
          aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
        />
      </div>

      <div class="kc-form-group">
        <label for="password" class="kc-label kc-label-required">
          ${msg("password")}
        </label>
        <div class="kc-password-wrapper">
          <input
            tabindex="2"
            id="password"
            class="kc-input"
            name="password"
            type="password"
            autocomplete="current-password"
            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
          />
          <button type="button" class="kc-password-toggle" aria-label="Show password" tabindex="-1">
            <svg class="kc-eye-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
              <circle cx="12" cy="12" r="3"/>
            </svg>
            <svg class="kc-eye-off-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/>
              <line x1="1" y1="1" x2="23" y2="23"/>
            </svg>
          </button>
        </div>
        <#if messagesPerField.existsError('username','password')>
        <span class="kc-input-error-message">
          ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
        </span>
        </#if>
      </div>

      <div class="kc-form-group kc-form-options">
        <#if (realm.rememberMe!false) && !usernameHidden??>
        <div class="kc-checkbox-group">
          <label class="kc-checkbox">
            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" ${login.rememberMe?string('checked', '')}>
            <span class="kc-checkbox-box"></span>
            <span>${msg("rememberMe")}</span>
          </label>
        </div>
        </#if>

        <#if realm.resetPasswordAllowed!false>
        <div class="kc-form-option">
          <a tabindex="5" href="${url.loginResetCredentialsUrl}" class="kc-link">
            ${msg("doForgotPassword")}
          </a>
        </div>
        </#if>
      </div>

      <div class="kc-form-buttons">
        <input
          type="hidden"
          id="id-hidden-input"
          name="credentialId"
          <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>
        />
        <button
          tabindex="4"
          class="kc-button kc-button-primary"
          name="login"
          id="kc-login"
          type="submit"
          value="${msg("doLogIn")}"
        >
          ${msg("doLogIn")}
        </button>
      </div>
    </form>

    <#if (realm.socialEnabled!false) && social.socialProviders?has_content && social.socialProviders?size gt 0>
    <div id="kc-social-providers" class="kc-social-links">
      <div class="kc-divider">${msg("identity-provider-login-divider")!''}</div>
      <ul class="kc-social-providers-list">
        <#list social.socialProviders?values as provider>
        <li>
          <a
            id="social-${provider.alias}"
            href="${provider.loginUrl}"
            class="kc-social-link"
            type="button"
          >
            <span>${provider.displayName}</span>
          </a>
        </li>
        </#list>
      </ul>
    </div>
    </#if>

    <#if (realm.registrationEnabled!false) && !registrationDisabled??>
    <div id="kc-registration-container">
      <span class="kc-registration-text">
        ${msg("noAccount")}
        <a tabindex="6" href="${url.registrationUrl}" class="kc-link">${msg("doRegister")}</a>
      </span>
    </div>
    </#if>
</@layout.registrationLayout>
