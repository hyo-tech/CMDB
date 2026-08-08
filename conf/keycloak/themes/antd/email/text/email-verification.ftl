<#outputformat "plainText">
${msg("emailVerificationGreeting", user.firstName!user.username!"")}

${msg("emailVerificationBody", realmName, linkExpiration!"")}

${msg("emailVerificationLinkText")}:
${link}

${msg("emailLinkExpiryNote", linkExpiration!"")}

---
&copy; ${msg("copyright")}
</#outputformat>
