<#--
  Registration Page for Keycloak 26
  New user registration form
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm') displayInfo=realm.registrationEmailAsPasswordAllowed>
    <form id="kc-register-form" class="kc-form" action="${url.registrationAction}" method="post">

        <#if profile.attributes?has_content>
            <#list profile.attributes as attribute>
                <#if !attribute.name?contains("password") && attribute.name != "password">
            <div class="kc-form-group">
                <label for="${attribute.name}" class="kc-label <#if attribute.required!false>kc-label-required</#if>">
                    <#if attribute.name == "firstName">
                        ${msg("firstName")}
                    <#elseif attribute.name == "lastName">
                        ${msg("lastName")}
                    <#elseif attribute.name == "email">
                        ${msg("email")}
                    <#else>
                        ${attribute.displayName!attribute.name}
                    </#if>
                    <#if attribute.required!false>*</#if>
                </label>
                <input
                    type="<#if attribute.name == "email">email<#else>text</#if>"
                    id="${attribute.name}"
                    name="${attribute.name}"
                    value="${(register.formData[attribute.name]!'')}"
                    aria-invalid="<#if messagesPerField.existsError(attribute.name)>true</#if>"
                    class="kc-input"
                    <#if attribute.required!false>required</#if>
                    <#if attribute.readonly!false>readonly</#if>
                    autocomplete="<#if attribute.name == "firstName">given-name<#elseif attribute.name == "lastName">family-name<#elseif attribute.name == "email">email<#else>on</#if>"
                />
                <#if messagesPerField.existsError(attribute.name)>
                <span class="kc-input-error-message">
                    ${kcSanitize(messagesPerField.getFirstError(attribute.name))?no_esc}
                </span>
                </#if>
            </div>
                </#if>
            </#list>
        </#if>

        <#if passwordRequired??>
        <div class="kc-form-group">
            <label for="password" class="kc-label kc-label-required">
                ${msg("password")}
                *
            </label>
            <input
                type="password"
                id="password"
                name="password"
                class="kc-input"
                autocomplete="new-password"
                aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
            />
            <#if messagesPerField.existsError('password','password-confirm')>
            <span class="kc-input-error-message">
                ${kcSanitize(messagesPerField.getFirstError('password','password-confirm'))?no_esc}
            </span>
            </#if>
        </div>

        <div class="kc-form-group">
            <label for="password-confirm" class="kc-label kc-label-required">
                ${msg("passwordConfirm")}
                *
            </label>
            <input
                type="password"
                id="password-confirm"
                name="password-confirm"
                class="kc-input"
                autocomplete="new-password"
            />
        </div>
        </#if>

        <#if recaptchaRequired??>
        <div class="kc-form-group">
            <div class="kc-recaptcha-container">
                <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
            </div>
        </div>
        </#if>

        <div class="kc-form-buttons">
            <button
                type="submit"
                class="kc-button kc-button-primary"
            >
                ${msg("doRegister")}
            </button>
        </div>
    </form>

    <div id="kc-copyright">
        <span class="kc-copyright-text">© ${msg("copyright")}</span>
    </div>
</@layout.registrationLayout>
