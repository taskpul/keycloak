<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
<!-- template: login-reset-password.ftl (mattercall override) -->

    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <div class="mattercall-card-header">
            <div class="mattercall-card-title">Forgot password?</div>
            <div class="mattercall-card-subtitle">Enter your email below and we will send you a reset link.</div>
        </div>

        <form id="kc-reset-password-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <#assign label>
                <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
            </#assign>
            <@field.input name="username" label=label value=(auth.attemptedUsername!'') autofocus=true autocomplete="email" />

            <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} ${properties.mattercallPrimaryButtonClass!}" type="submit" value="${msg("doSubmit")}"/>
            </div>

            <div class="mattercall-form-footer">
                <span><a href="${url.loginUrl}">${msg("backToLogin")}</a></span>
            </div>
        </form>
    <#elseif section = "info" >
        <#if realm.duplicateEmailsAllowed>
            ${msg("emailInstructionUsername")}
        <#else>
            ${msg("emailInstruction")}
        </#if>
    </#if>
</@layout.registrationLayout>
