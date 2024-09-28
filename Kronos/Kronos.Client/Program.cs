using Kronos.Client.Extension;
using Kronos.Provider;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

ConfigurationExtension.ConfigureKronosAPI(builder.Configuration);

builder.Services.AddSingleton<DialogProvider>();

await builder.Build().RunAsync();
