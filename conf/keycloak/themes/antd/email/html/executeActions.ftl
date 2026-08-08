<#outputformat "plainText">
<#assign requiredActionsText><#if requiredActions??><#list requiredActions><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}</#items></#list></#if></#assign>
<#-- Build locale-aware link so the activation page renders in the same locale as the email -->
<#if (locale.country)?has_content>
  <#assign localeCode = locale.language + '-' + locale.country>
<#else>
  <#assign localeCode = locale.language>
</#if>
<#assign localizedLink = link + (link?contains('?')?then('&', '?')) + 'ui_locales=' + localeCode>
</#outputformat>

<#assign productFont="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif">

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin:0; padding:0; background-color:#f5f5f5;">
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#f5f5f5; padding:32px 0;">
  <tr>
    <td align="center">
      <table width="600" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff; border-radius:8px; overflow:hidden; box-shadow:0 2px 8px rgba(0,0,0,0.08);">

        <!-- Header -->
        <tr>
          <td style="background-color:#1677ff; padding:32px 40px; text-align:center;">
            <h1 style="margin:0; color:#ffffff; font-family:${productFont}; font-size:22px; font-weight:600;">
              ${realmName}
            </h1>
          </td>
        </tr>

        <!-- Body -->
        <tr>
          <td style="padding:40px;">
            <p style="margin:0 0 8px; font-family:${productFont}; font-size:16px; color:#1f1f1f;">
              ${msg("executeActionsGreeting", user.firstName!user.username!"")}
            </p>
            <p style="margin:0 0 24px; font-family:${productFont}; font-size:14px; color:#666666; line-height:1.6;">
              ${msg("executeActionsBody", realmName)}
            </p>

            <#if requiredActions??>
            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:24px;">
              <tr>
                <td style="background-color:#f6f6f6; border-radius:6px; padding:16px 20px;">
                  <p style="margin:0 0 8px; font-family:${productFont}; font-size:13px; font-weight:600; color:#333333;">
                    ${msg("executeActionsRequiredLabel")}
                  </p>
                  <ul style="margin:0; padding-left:20px; font-family:${productFont}; font-size:13px; color:#666666; line-height:2;">
                    <#list requiredActions as reqActionItem>
                    <li>${msg("requiredAction.${reqActionItem}")}</li>
                    </#list>
                  </ul>
                </td>
              </tr>
            </table>
            </#if>

            <table width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td align="center">
                  <a href="${localizedLink}"
                     style="display:inline-block; background-color:#1677ff; color:#ffffff; font-family:${productFont};
                            font-size:16px; font-weight:500; text-decoration:none; padding:12px 32px;
                            border-radius:6px; border:1px solid #1677ff;">
                    ${msg("executeActionsLinkText")}
                  </a>
                </td>
              </tr>
              <tr>
                <td align="center" style="padding-top:16px;">
                  <p style="margin:0; font-family:${productFont}; font-size:12px; color:#999999;">
                    ${msg("emailLinkExpiryNote", linkExpiration!"")}
                  </p>
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- Fallback link -->
        <tr>
          <td style="padding:0 40px 32px;">
            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#fafafa; border-radius:6px; padding:16px;">
              <tr>
                <td style="font-family:${productFont}; font-size:12px; color:#999999; word-break:break-all; line-height:1.6;">
                  ${msg("emailLinkCopyInstruction")}<br/>
                  <a href="${localizedLink}" style="color:#1677ff; text-decoration:underline;">${localizedLink}</a>
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- Footer -->
        <tr>
          <td style="background-color:#fafafa; padding:20px 40px; border-top:1px solid #f0f0f0;">
            <p style="margin:0; font-family:${productFont}; font-size:12px; color:#999999; text-align:center;">
              &copy; ${msg("copyright")}
            </p>
          </td>
        </tr>

      </table>
    </td>
  </tr>
</table>
</body>
</html>
