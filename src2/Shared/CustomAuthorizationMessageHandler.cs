using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.WebAssembly.Authentication;

namespace VMStarter.Shared
{
    public class CustomAuthorizationMessageHandler : AuthorizationMessageHandler
    {
        public CustomAuthorizationMessageHandler(IAccessTokenProvider provider,
        NavigationManager navigationManager)
        : base(provider, navigationManager)
        {
            ConfigureHandler(
                authorizedUrls: new[] { "https://testdeploy19henrik.azurewebsites.net" },
                scopes: new[] { "openid", "api://7b8cd794-86b4-47f9-8a44-56833c056d73/read" });
        }
    }
}
