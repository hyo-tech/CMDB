<#--
  Base template for Keycloak Ant Design login theme
  This file provides the layout macro used by all login pages

  Language switching uses Keycloak's built-in locale.supported object.
  Each locale entry has a pre-built .url that correctly preserves the
  auth session — no custom JavaScript needed for locale switching.
-->
<#macro registrationLayout bodyClass="" displayInfo="false" displayMessage="true" displayRequiredFields="false">
<#-- Capture the main content -->
<#assign mainContent><#nested></#assign>

<#-- Capture the info content if displayInfo is enabled -->
<#if displayInfo!?string != "false">
<#assign infoContent><#nested "info"></#assign>
</#if>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!} ${bodyClass}"<#if realm.internationalizationEnabled!false> lang="${locale.currentLanguageTag}" dir="${(locale.rtl)?then('rtl','ltr')}"</#if>>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <script src="${url.resourcesPath}/js/login.js" type="text/javascript"></script>
</head>

<body class="${properties.kcBodyClass!}">
<div id="kc-container">
    <!-- Left Side: Branding -->
    <div class="kc-left-panel">
        <div class="kc-left-top">
            <div class="kc-logo">
                <img src="${url.resourcesPath}/img/logo.png" alt="${msg("productName")}" />
            </div>
            <div class="kc-product-name">${msg("productName")}</div>
        </div>
        <div class="kc-left-bottom">
            <img src="${url.resourcesPath}/img/bg.png" alt="Illustration" />
        </div>
    </div>

    <!-- Right Side: Login Form -->
    <div class="kc-right-panel">
        <#if realm.internationalizationEnabled!false && locale.supported?size gt 1>
        <div class="kc-language-selector-container">
            <#-- Uses Keycloak's built-in locale.supported — each entry has a
                 pre-built .url that preserves the auth session correctly.
                 The select simply navigates to that URL. Duplicated labels
                 (e.g. "中文 (简体) (中文 (简体))") are cleaned up by login.js. -->
            <select id="kc-locale-select" class="kc-language-select" onchange="window.location.href=this.value">
                <#list locale.supported as l>
                <option value="${l.url}"<#if l.label == locale.current> selected</#if>>${l.label}</option>
                </#list>
            </select>
        </div>
        </#if>

        <div id="kc-content">
            <div id="kc-content-wrapper">

              <#if displayMessage!?string != "false" && message?has_content && (message.type != 'warning')>
                  <div class="alert alert-${message.type}">
                      <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                  </div>
              </#if>

              ${mainContent}

              <#if displayInfo!?string != "false">
                  <div id="kc-info">
                      <div id="kc-info-wrapper">
                          ${infoContent!}
                      </div>
                  </div>
              </#if>
            </div>
        </div>

        <div id="kc-copyright">
            <span class="kc-copyright-text">© ${msg("copyright")}</span>
        </div>
    </div>
</div>
</body>
</html>
</#macro>
