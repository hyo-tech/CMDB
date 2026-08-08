<#--
  Forgot Password Page for Keycloak 26
  Password reset request form

  displayInfo=false — the registration link info section is rendered directly
  in the main content below. The template macro's <#nested "info"> mechanism
  would duplicate the entire form if displayInfo=true, since this template
  doesn't use the "; section" parameter syntax to distinguish main vs info content.
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=true displayInfo=false>
    <#-- Preserve locale through form submission so Keycloak uses the correct
         locale when sending the reset email and rendering the info page.
         Keycloak's LocaleUtil.processLocaleParam() reads "kc_locale" and
         stores it as "locale_user_requested" auth session note. -->
    <#assign formAction = url.loginAction>
    <#if locale.currentLanguageTag?has_content>
      <#assign formAction = formAction + (formAction?contains('?')?then('&', '?')) + 'kc_locale=' + locale.currentLanguageTag?url('UTF-8')>
    </#if>
    <form id="kc-reset-password-form" class="kc-form" action="${formAction}" method="post">

        <div class="kc-form-group">
            <label for="username" class="kc-label kc-label-required">
                <#if realm.loginWithEmailAllowed>${msg("emailOrUsername")}<#else>${msg("username")}</#if>
            </label>
            <input
                type="text"
                id="username"
                name="username"
                class="kc-input"
                autofocus
                aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
            />
            <#if messagesPerField.existsError('username')>
            <span class="kc-input-error-message">
                ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
            </span>
            </#if>
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

    <#if realm.registrationAllowed!false>
    <div id="kc-info">
        <div id="kc-info-wrapper">
            <div id="kc-registration-container">
                <span class="kc-registration-text">
                    ${msg("noAccount")}
                    <a tabindex="6" href="${url.registrationUrl}" class="kc-link">${msg("doRegister")}</a>
                </span>
            </div>
        </div>
    </div>
    </#if>

</@layout.registrationLayout>
