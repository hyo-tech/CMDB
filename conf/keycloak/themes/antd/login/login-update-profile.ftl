<#--
  Update Profile Page for Keycloak 26
  Required action for users to update their profile information
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage="true" displayRequiredFields=true>
    <form id="kc-update-profile-form" class="kc-form" action="${url.loginAction}" method="post">

        <#if profile.attributes?has_content>
            <#list profile.attributes as attribute>
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
                    value="${(attribute.value!'')}"
                    aria-invalid="<#if messagesPerField.existsError(attribute.name)>true</#if>"
                    class="kc-input"
                    <#if attribute.readonly!false>readonly</#if>
                    <#if attribute.required!false>required</#if>
                    autocomplete="<#if attribute.name == "firstName">given-name<#elseif attribute.name == "lastName">family-name<#elseif attribute.name == "email">email<#else>on</#if>"
                />
                <#if messagesPerField.existsError(attribute.name)>
                <span class="kc-input-error-message">
                    ${kcSanitize(messagesPerField.getFirstError(attribute.name))?no_esc}
                </span>
                </#if>
            </div>
            </#list>
        </#if>

        <div class="kc-form-buttons">
            <button
                type="submit"
                class="kc-button kc-button-primary"
                name="submitAction"
                value="Save"
            >
                ${msg("doSave")}
            </button>
            <button
                type="submit"
                class="kc-button"
                name="cancelAction"
                value="Cancel"
            >
                ${msg("doCancel")}
            </button>
        </div>
    </form>

    <div id="kc-copyright">
        <span class="kc-copyright-text">© ${msg("copyright")}</span>
    </div>
</@layout.registrationLayout>
