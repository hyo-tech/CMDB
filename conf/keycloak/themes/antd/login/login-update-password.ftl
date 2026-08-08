<#--
  Update Password Page for Keycloak 26
  Required action for users to change their password
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=true displayInfo=false>
    <#-- Preserve the current locale through the form submission so that the
         success/info page renders in the same language as this page.
         Keycloak's LocaleUtil.processLocaleParam() reads the "kc_locale"
         query parameter and stores it as the "locale_user_requested" auth
         session note — the highest-priority locale source. -->
    <#assign formAction = url.loginAction>
    <#if locale.currentLanguageTag?has_content>
      <#assign formAction = formAction + (formAction?contains('?')?then('&', '?')) + 'kc_locale=' + locale.currentLanguageTag?url('UTF-8')>
    </#if>
    <form id="kc-pass-update-form" class="kc-form" action="${formAction}" method="post">

        <div class="kc-form-group">
            <label for="password-new" class="kc-label kc-label-required">
                ${msg("passwordNew")}
            </label>
            <input
                type="password"
                id="password-new"
                name="password-new"
                class="kc-input"
                autocomplete="new-password"
                autofocus
                aria-invalid="<#if messagesPerField.existsError('password-new','password-confirm')>true</#if>"
            />
        </div>

        <div class="kc-form-group">
            <label for="password-confirm" class="kc-label kc-label-required">
                ${msg("passwordConfirm")}
            </label>
            <input
                type="password"
                id="password-confirm"
                name="password-confirm"
                class="kc-input"
                autocomplete="new-password"
            />
            <#if messagesPerField.existsError('password-new','password-confirm')>
            <span class="kc-input-error-message">
                ${kcSanitize(messagesPerField.getFirstError('password-new','password-confirm'))?no_esc}
            </span>
            </#if>
        </div>

        <div class="kc-form-buttons">
            <button
                type="submit"
                class="kc-button kc-button-primary"
                name="submitAction"
                value="Save"
            >
                ${msg("doSave")}
            </button>
            <button
                type="submit"
                class="kc-button"
                name="cancelAction"
                value="Cancel"
            >
                ${msg("doCancel")}
            </button>
        </div>
    </form>
</@layout.registrationLayout>
