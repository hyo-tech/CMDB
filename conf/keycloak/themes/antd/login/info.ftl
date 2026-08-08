<#--
  Info Page for Keycloak 26
  Shows action confirmation and proceed button
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=false>
    <#if actionUri?has_content>
    <#-- Auto-redirect to actionUri for required actions (e.g., email activation). -->
    <script type="text/javascript">
        window.location.href = "${actionUri?js_string}";
    </script>
    <div class="alert alert-info">
        <span class="kc-feedback-text">
            ${msg("infoRedirecting")} <a href="${actionUri?js_string}">${msg("infoRedirectingLink")}</a>
        </span>
    </div>
    <#else>
    <div id="kc-info-content">
        <#if message?has_content && (message.type != 'warning')>
        <div class="alert alert-${message.type}">
            <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
        </div>
        </#if>

        <#if skipLink??>
        <#else>
        <div class="kc-form-buttons">
            <#if actionUri?has_content>
            <a href="${actionUri}" class="kc-button kc-button-primary">
                ${msg("proceedWithAction")}
            </a>
            <#elseif pageRedirectUri?has_content>
            <a href="${pageRedirectUri}" class="kc-button kc-button-primary">
                ${msg("backToApplication")}
            </a>
            <#elseif (pageLink)??>
            <a href="${pageLink}" class="kc-button kc-button-primary">
                ${msg("doContinue")}
            </a>
            <#elseif (client.baseUrl)?has_content>
            <a href="${client.baseUrl}" class="kc-button kc-button-primary">
                ${msg("backToApplication")}
            </a>
            </#if>
        </div>
        </#if>
    </div>
    </#if>

</@layout.registrationLayout>
