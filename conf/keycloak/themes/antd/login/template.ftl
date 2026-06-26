<#--
  Base template for Keycloak Ant Design login theme
  This file provides the layout macro used by all login pages

  Supported locales for language selector (must match realm configuration)
-->
<#assign supportedLocales = [
  {"code": "zh-CN", "labelEn": "Chinese (Simplified) (中文 (简体))", "labelLocal": "中文 (简体) (Chinese (Simplified))"},
  {"code": "en", "labelEn": "English (英文)", "labelLocal": "English (英文)"}
]>

<#macro registrationLayout bodyClass="" displayInfo="false" displayMessage="true" displayRequiredFields="false">
<#-- Capture the main content -->
<#assign mainContent><#nested></#assign>

<#-- Capture the info content if displayInfo is enabled -->
<#if displayInfo!?string != "false">
<#assign infoContent><#nested "info"></#assign>
</#if>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!} ${bodyClass}" lang="${lang}"<#if realm.internationalizationEnabled!false> dir="${(locale.rtl)?then('rtl','ltr')}"</#if>>
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
    <script type="text/javascript">
      // Read locale from localStorage, default to zh-CN
      function getStorageLocale() {
        var stored = localStorage.getItem('hy_sop_language');
        if (stored === 'zh' || stored === 'zh-CN') return 'zh-CN';
        if (stored === 'en') return 'en';
        return 'zh-CN';
      }

      // Save locale to localStorage keys when user changes language
      function onLocaleChange(url) {
        var match = url.match(/kc_locale=([^&]*)/);
        if (match) {
          var locale = match[1];
          var value = locale === 'zh-CN' ? 'zh' : locale;
          localStorage.setItem('hy_sop_language', value);
          localStorage.setItem('hy_sop_i18nextLng', value);
          localStorage.setItem('i18nextLng', value);
        }
        window.location.href = url;
      }

      // Set default locale from localStorage if not already specified
      (function() {
        var url = window.location.href;
        var hasLocaleParam = url.indexOf('kc_locale=') !== -1 || url.indexOf('ui_locales=') !== -1;
        var hasLocaleCookie = document.cookie.indexOf('KEYCLOAK_LOCALE=') !== -1;

        if (!hasLocaleParam && !hasLocaleCookie) {
          var locale = getStorageLocale();
          document.cookie = 'KEYCLOAK_LOCALE=' + locale + '; path=/; max-age=31536000';
          var separator = url.indexOf('?') !== -1 ? '&' : '?';
          window.location.href = url + separator + 'kc_locale=' + locale;
        }
      })();
    </script>
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
        <#if realm.internationalizationEnabled!false>
        <div class="kc-language-selector-container">
            <select id="kc-locale-select" class="kc-language-select" onchange="onLocaleChange(this.value)">
                <#list supportedLocales as locale>                    
                    <#assign isSelected = (lang == locale.code)>
                    <#assign label = (locale.code == "zh-CN" && lang == "zh-CN") || (locale.code != "zh-CN" && lang?starts_with(locale.code?split(" ")[0])) || lang == locale.code>
                    <option value="${url.loginUrl}&kc_locale=${locale.code}"<#if label> selected</#if>>
                        ${locale.labelEn}
                    </option>
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
