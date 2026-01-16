<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>
<#import "social-providers.ftl" as identityProviders>
<#import "passkeys.ftl" as passkeys>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
<!-- template: login.ftl -->

    <#if section = "header">
        <div class="kc-brand-row">
            <span class="kc-brand-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" role="img" aria-hidden="true">
                    <path fill="#95BF47" d="M20.6 6.4c-.1-.1-2.3-.1-2.3-.1s-1.7-1.6-1.9-1.8c-.2-.2-.5-.2-.7-.1l-1.4.4c-.1-.4-.3-.9-.6-1.3-.9-1.4-2.3-2-3.7-1.6-1.7.5-2.6 2.7-2.8 4.1l-2 .6c-.6.2-.6.2-.7.8-.1.4-1.5 11.9-1.5 11.9L17.8 21l3.3-.8S20.7 6.5 20.6 6.4zM13 5l-2.2.7c.2-.7.5-1.4 1-1.7.4-.3.8-.4 1.1-.3.2.4.3.8.3 1.3zm-3.6 1.1L7.9 6.6c.2-1.1.7-2.2 1.4-2.5.3-.1.6-.1.8 0-.5.6-.7 1.5-.7 2zm7.5.5l-3 .9V5.7c0-.5-.1-1-.2-1.4.8.1 1.3.7 1.7 1.3.2.3.3.6.4.8z"/>
                    <path fill="#5E8E3E" d="M20.6 6.4c-.1-.1-2.3-.1-2.3-.1s-1.7-1.6-1.9-1.8c-.1-.1-.2-.1-.3-.1v16.6l4.9-1.1s-.4-13.4-.4-13.5z"/>
                </svg>
            </span>
            <span class="kc-brand-name">shopify</span>
        </div>
        <h1 class="kc-title">Log in</h1>
        <p class="kc-subtitle">Continue to MatterCall</p>
    <#elseif section = "form">
        <div id="kc-form">
          <div id="kc-form-wrapper">
            <#if realm.password>
                <form id="kc-form-login" class="${properties.kcFormClass!}" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" novalidate="novalidate">
                    <#if !usernameHidden??>
                        <@field.input name="username" label=msg("email") error=messagesPerField.getFirstError('username','password')
                            autofocus=true autocomplete="${(enableWebAuthnConditionalUI?has_content)?then('username webauthn', 'username')}" value=login.username!'' />
                        <@field.password name="password" label=msg("password") error="" forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password">
                            <#if realm.rememberMe && !usernameHidden??>
                                <@field.checkbox name="rememberMe" label=msg("rememberMe") value=login.rememberMe?? />
                            </#if>
                        </@field.password>
                    <#else>
                        <@field.password name="password" label=msg("password") forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password">
                            <#if realm.rememberMe && !usernameHidden??>
                                <@field.checkbox name="rememberMe" label=msg("rememberMe") value=login.rememberMe?? />
                            </#if>
                        </@field.password>
                    </#if>

                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                        <button id="kc-login" name="login" type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} kc-primary-button">
                            Continue with email
                        </button>
                    </div>
                </form>
            </#if>
            </div>
        </div>
        <@passkeys.conditionalUIData />
    <#elseif section = "socialProviders" >
        <div class="kc-divider"><span>or</span></div>
        <button type="button" class="kc-secondary-button kc-passkey-button">
            <span class="kc-passkey-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" role="img" aria-hidden="true">
                    <path d="M7.5 10a4.5 4.5 0 1 1 4.3 3.4H11v2h3v2h2v2h2v-2.2c0-1-.8-1.8-1.8-1.8H13v-2h.8A6.5 6.5 0 1 0 7.5 10zm0-2.5a2.5 2.5 0 1 0 2.5 2.5 2.5 2.5 0 0 0-2.5-2.5z"/>
                </svg>
            </span>
            <span>Sign in with passkey</span>
        </button>
        <#if realm.password && social.providers?? && social.providers?has_content>
            <@identityProviders.show social=social/>
        </#if>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div class="kc-footer-links">
                <div class="kc-footer-line">
                    <span>New to MatterCall? <a href="${url.registrationUrl}">Get started →</a></span>
                </div>
                <div class="kc-footer-secondary">
                    <a href="#">Help</a>
                    <a href="#">Privacy</a>
                    <a href="#">Terms</a>
                </div>
            </div>
        </#if>
    <#elseif section = "footer">
    </#if>

</@layout.registrationLayout>
