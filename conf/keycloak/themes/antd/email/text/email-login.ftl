<#outputformat "plainText">
${msg("emailLoginGreeting", user.firstName!user.username!"")}

${msg("emailLoginBody", realmName, linkExpiration!"")}

${msg("emailLoginLinkText")}:
${link}

${msg("emailLinkExpiryNote", linkExpiration!"")}

---
&copy; ${msg("copyright")}
</#outputformat>
