<#outputformat "plainText">
${msg("executeActionsGreeting", user.firstName!user.username!"")}

${msg("executeActionsBody", realmName)}

${msg("executeActionsRequiredLabel")}:
<#if requiredActions??>
<#list requiredActions as reqActionItem>
- ${msg("requiredAction.${reqActionItem}")}
</#list>
</#if>

${msg("executeActionsLinkText")}:
${link}

${msg("emailLinkExpiryNote", linkExpiration!"")}

---
&copy; ${msg("copyright")}
</#outputformat>
