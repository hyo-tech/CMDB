<#--
  OAuth Grant Page for Keycloak 26
  OAuth authorization consent page
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=true>
    <form id="kc-oauth-grant-form" class="kc-form" action="${url.oauthAction}" method="post">

        <div class="kc-oauth-description">
            <p>${msg("oauthGrantPrompt")?no_esc}</p>
        </div>

        <div class="kc-oauth-client-info">
            <#if client.logoUrl?has_content>
            <div class="kc-client-logo">
                <img src="${client.logoUrl}" alt="${client.name}" />
            </div>
            </#if>
            <div class="kc-client-name">
                <strong>${kcSanitize(client.name)?no_esc}</strong>
            </div>
        </div>

        <div class="kc-form-group">
            <label class="kc-label">
                ${msg("oauth2ConsentRequestedPermissions")}
            </label>
            <div class="kc-permissions-list">
                <#if (oauth.clientScopesRequested)?has_content>
                <ul class="kc-permissions">
                    <#list oauth.clientScopesRequested as scope>
                    <li>
                        <span>${kcSanitize(scope.consentScreenText)!scope}</span>
                    </li>
                    </#list>
                </ul>
                </#if>
            </div>
        </div>

        <input type="hidden" name="code" value="${code}">
        <input type="hidden" name="decision" value="">

        <div class="kc-form-buttons">
            <button
                type="submit"
                class="kc-button kc-button-primary"
                name="submitAction"
                value="Accept"
                onclick="document.forms[0].decision.value='allow';"
            >
                ${msg("doAllow")}
            </button>
            <button
                type="submit"
                class="kc-button"
                name="submitAction"
                value="Decline"
                onclick="document.forms[0].decision.value='deny';"
            >
                ${msg("doDeny")}
            </button>
        </div>
    </form>

    <div id="kc-copyright">
        <span class="kc-copyright-text">© ${msg("copyright")}</span>
    </div>
</@layout.registrationLayout>
