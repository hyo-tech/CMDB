<#--
  Logout Confirmation Page for Ant Design Keycloak Theme
  Auto-submits to skip the confirmation UI while keeping proper Keycloak logout flow.
-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage="true">
    <form class="kc-form" id="kc-logout-form" action="${url.logoutConfirmAction}" method="POST">
        <#if logoutConfirm?? && logoutConfirm.code??>
        <input type="hidden" name="session_code" value="${logoutConfirm.code}"/>
        </#if>
        <div class="kc-form-group">
            <label class="kc-label kc-label-login-title">
                ${msg("logoutConfirmTitle")}
            </label>
            <p class="kc-logout-message">${msg("logoutConfirmHeader")}</p>
        </div>
        <div class="kc-form-buttons">
            <button class="kc-button kc-button-primary" name="confirmLogout" id="kc-confirm" type="submit">
                ${msg("doLogout")}
            </button>
        </div>
    </form>
    <script type="text/javascript">
        document.getElementById('kc-logout-form').submit();
    </script>
</@layout.registrationLayout>
