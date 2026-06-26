<#--
  Ant Design Style Error Page for Keycloak 26
  Uses template.ftl for layout
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage="false">
    <div id="kc-error-message">
      <p class="instruction">${kcSanitize(message.summary)?no_esc}</p>
      <#if skipLink??>
      <#else>
          <#if client?? && client.baseUrl?has_content>
            <p><a id="backToApplication" href="${client.baseUrl}">${msg("backToApplication")}</a></p>
          </#if>
      </#if>
    </div>
</@layout.registrationLayout>
