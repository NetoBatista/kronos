using Kronos.Extension;
using Kronos.Service;

var builder = WebApplication.CreateBuilder(args);

builder.Logging.AddFilter("Microsoft.EntityFrameworkCore", LogLevel.None);
builder.Logging.AddFilter("System.Net.Http.HttpClient", LogLevel.None);

builder.Configuration.ConfigurationKronos();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.InjectDependency();
builder.Services.ExecuteMigrations();

builder.Services.AddCors(options =>
{
    options.AddPolicy("*", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

var app = builder.Build();

_ = Task.Run(async () =>
{
    using var scope = app.Services.CreateScope();
    var hostedService = scope.ServiceProvider.GetRequiredService<HostedService>();
    await hostedService.StartAsync(CancellationToken.None);
});

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("*");

app.UseAuthorization();

app.MapControllers();

app.Run();
