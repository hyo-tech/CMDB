<#--
  Update Password Page for Keycloak 26
  Required action for users to change their password
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=true displayInfo=false>
    <form id="kc-pass-update-form" class="kc-form" action="${url.loginAction}" method="post">

        <div class="kc-form-group">
            <label for="password-new" class="kc-label kc-label-required">
                ${msg("passwordNew")}
                *
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
                *
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

        <div class="kc-form-group">
            <label for="password-current" class="kc-label">
                ${msg("passwordCurrent")}
                <#if passwordRequired!false>*</#if>
            </label>
            <input
                type="password"
                id="password-current"
                name="password-current"
                class="kc-input"
                autocomplete="current-password"
                <#if passwordRequired!false>required</#if>
            />
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
