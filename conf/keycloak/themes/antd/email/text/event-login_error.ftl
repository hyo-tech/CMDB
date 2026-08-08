<#outputformat "plainText">
${msg("eventLoginErrorGreeting", user.firstName!user.username!"")}

${msg("eventLoginErrorBody", realmName)}

<#if event.ipAddress??>${msg("eventIpAddressLabel")}: ${event.ipAddress}</#if>
<#if event.time??>${msg("eventTimeLabel")}: ${event.time?datetime?string.medium}</#if>
<#if event.userAgent??>${msg("eventUserAgentLabel")}: ${event.userAgent}</#if>

${msg("eventLoginErrorLinkText")}:
${link}

---
&copy; ${msg("copyright")}
</#outputformat>
