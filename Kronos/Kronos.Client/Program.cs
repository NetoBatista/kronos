using Kronos.Provider;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

builder.Services.AddSingleton<DialogProvider>();

await builder.Build().RunAsync();
