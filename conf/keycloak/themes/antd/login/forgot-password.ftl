<#--
  Forgot Password Page for Keycloak 26
  Password reset request form
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=true displayInfo=true>
    <form id="kc-reset-password-form" class="kc-form" action="${url.loginAction}" method="post">

        <div class="kc-form-group">
            <label for="username" class="kc-label kc-label-required">
                <#if realm.loginWithEmailAllowed>${msg("emailOrUsername")}<#else>${msg("username")}</#if>
                *
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

    <#if displayInfo>
    <div id="kc-info">
        <div id="kc-info-wrapper">
            <@layout.infoBlock>
                <#if realm.registrationAllowed!false>
                <div id="kc-registration-container">
                    <span class="kc-registration-text">
                        ${msg("noAccount")}
                        <a tabindex="6" href="${url.registrationUrl}" class="kc-link">${msg("doRegister")}</a>
                    </span>
                </div>
                </#if>
            </@layout.infoBlock>
        </div>
    </div>
    </#if>

    <div id="kc-copyright">
        <span class="kc-copyright-text">© ${msg("copyright")}</span>
    </div>
</@layout.registrationLayout>
