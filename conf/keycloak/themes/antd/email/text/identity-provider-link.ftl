<#outputformat "plainText">
${msg("identityProviderLinkGreeting", user.firstName!user.username!"")}

${msg("identityProviderLinkBody", identityProviderAlias!"", realmName)}

${msg("identityProviderLinkLinkText")}:
${link}

${msg("emailLinkExpiryNote", linkExpiration!"")}

---
&copy; ${msg("copyright")}
</#outputformat>
