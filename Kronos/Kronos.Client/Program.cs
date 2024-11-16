using Kronos.Domain.Interface.Provider;
using Kronos.Provider;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

builder.Services.AddSingleton<IDialogProvider, DialogProvider>();
builder.Services.AddScoped<IJavascriptProvider, JavascriptProvider>();
builder.Services.AddScoped<IChartProvider, ChartProvider>();

await builder.Build().RunAsync();
