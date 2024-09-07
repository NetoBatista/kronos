using Kronos;
using Kronos.Extension;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");
builder.Configuration.AddJsonFile("./appsettings.json", optional: false, reloadOnChange: true);

ConfigurationExtension.ConfigureKronosAPI(builder.Configuration);

builder.Services.InjectDependency();

await builder.Build().RunAsync();
