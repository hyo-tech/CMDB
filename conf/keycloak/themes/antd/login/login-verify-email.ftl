<#--
  Verify Email Page for Keycloak 26
  Email verification page
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=true displayInfo=true>
    <div id="kc-verify-email-content">
        <#if message?has_content && (message.type != 'warning')>
        <div class="alert alert-${message.type}">
            <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
        </div>
        <#else>
        <div class="kc-info-message">
            <p>${msg("emailVerifyInstruction1")!""}</p>
            <p>${msg("emailVerifyInstruction2")!""}</p>
        </div>
        </#if>

        <div class="kc-form-buttons">
            <a href="${url.loginUrl}" class="kc-button kc-button-primary">
                ${msg("doBackToLogin")}
            </a>
            <#if (resendEmail)??>
            <a href="${resendEmail}" class="kc-button">
                ${msg("doResendEmail")}
            </a>
            </#if>
        </div>
    </div>

    <div id="kc-copyright">
        <span class="kc-copyright-text">© ${msg("copyright")}</span>
    </div>
</@layout.registrationLayout>
