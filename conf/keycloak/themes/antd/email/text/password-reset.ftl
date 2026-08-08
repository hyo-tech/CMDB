<#-- Build locale-aware link so the reset page renders in the same locale as the email -->
<#if (locale.country)?has_content>
  <#assign localeCode = locale.language + '-' + locale.country>
<#else>
  <#assign localeCode = locale.language>
</#if>
<#assign localizedLink = link + (link?contains('?')?then('&', '?')) + 'ui_locales=' + localeCode>

<#outputformat "plainText">
${msg("passwordResetGreeting", user.firstName!user.username!"")}

${msg("passwordResetBody", realmName, linkExpiration!"")}

${msg("passwordResetLinkText")}:
${localizedLink}

${msg("emailLinkExpiryNote", linkExpiration!"")}

${msg("passwordResetSecurityNotice")}

---
&copy; ${msg("copyright")}
</#outputformat>
