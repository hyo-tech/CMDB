<#--
  Reset Password Page for Keycloak 26
  Email/username entry form for the "Choose User" step of the
  reset-credentials flow.

  NOTE: In Keycloak 26, this template (login-reset-password.ftl) is used
  for the "Choose User" step (email entry), NOT for the actual password
  reset. The password entry form is in login-update-password.ftl.

  displayInfo=false — the info section (email instruction text) is not
  needed here since the template macro's <#nested "info"> mechanism would
  duplicate the entire form if displayInfo=true.

  Locale preservation: Keycloak's LocaleUtil.processLocaleParam() reads the
  "kc_locale" query parameter and stores it as the "locale_user_requested"
  auth session note, which is the highest-priority locale source in
  DefaultLocaleSelectorProvider. We pass kc_locale in the form action URL
  so the info page (shown after email submission) uses the same locale.
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=false>
    <#assign formAction = url.loginAction>
    <#if locale.currentLanguageTag?has_content>
      <#assign formAction = formAction + (formAction?contains('?')?then('&', '?')) + 'kc_locale=' + locale.currentLanguageTag?url('UTF-8')>
    </#if>
    <form id="kc-reset-password-form" class="kc-form" action="${formAction}" method="post">

        <div class="kc-form-group">
            <label for="username" class="kc-label kc-label-required">
                <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
            </label>
            <input
                type="text"
                id="username"
                name="username"
                class="kc-input"
                autofocus
                value="${(auth.attemptedUsername!'')}"
                aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
            />
            <#if messagesPerField.existsError('username')>
            <span class="kc-input-error-message">
                ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
            </span>
            </#if>
        </div>

        <div class="kc-form-options">
            <a href="${url.loginUrl}" class="kc-link">${msg("backToLogin")}</a>
        </div>

        <div class="kc-form-buttons">
            <button
                type="submit"
                class="kc-button kc-button-primary"
            >
                ${msg("doSubmit")}
            </button>
        </div>
    </form>

</@layout.registrationLayout>
