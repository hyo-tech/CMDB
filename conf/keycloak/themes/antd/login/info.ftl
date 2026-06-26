<#--
  Info Page for Keycloak 26
  General information display page
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=true>
    <div id="kc-info-content">
        <#if message?has_content && (message.type != 'warning')>
        <div class="alert alert-${message.type}">
            <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
        </div>
        </#if>

        <div class="kc-info-message">
            <#if (message.summary)?has_content>
            <p>${kcSanitize(message.summary)?no_esc}</p>
            </#if>
        </div>

        <#if (pageLink)??>
        <div class="kc-form-buttons">
            <a href="${pageLink}" class="kc-button kc-button-primary">
                ${msg("doContinue")}
            </a>
        </div>
        </#if>
    </div>

    <div id="kc-copyright">
        <span class="kc-copyright-text">© ${msg("copyright")}</span>
    </div>
</@layout.registrationLayout>
