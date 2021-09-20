using Microsoft.AspNetCore.Components.WebAssembly.Authentication;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using VMStarter.Shared;

namespace VMStarter
{
    public class Program
    {
        public static async Task Main(string[] args)
        {
            var builder = WebAssemblyHostBuilder.CreateDefault(args);

            builder.RootComponents.Add<App>("#app");

            builder.Services.AddMsalAuthentication(options =>
            {
                builder.Configuration.Bind("AzureAd", options.ProviderOptions.Authentication);
                options.ProviderOptions.DefaultAccessTokenScopes.Add("https://graph.microsoft.com/User.Read");
                options.ProviderOptions.LoginMode = "redirect";
            });

            builder.Services.AddOptions();
            builder.Services.AddAuthorizationCore();


            builder.Services.AddScoped<CustomAuthorizationMessageHandler>();

           

            builder.Services.AddHttpClient("WebAPI",
                client => client.BaseAddress = new Uri("https://testdeploy19henrik.azurewebsites.net"))
            .AddHttpMessageHandler<CustomAuthorizationMessageHandler>();

            builder.Services.AddScoped(sp => new HttpClient(
            sp.GetRequiredService<AuthorizationMessageHandler>()
            .ConfigureHandler(
                authorizedUrls: new[] { "https://testdeploy19henrik.azurewebsites.net" },
                scopes: new[] { "api://7b8cd794-86b4-47f9-8a44-56833c056d73/user_impersonation", "api://7b8cd794-86b4-47f9-8a44-56833c056d73/read" }))
                    {
                        BaseAddress = new Uri("https://testdeploy19henrik.azurewebsites.net")
                    });


            await builder.Build().RunAsync();
        }
    }
}
