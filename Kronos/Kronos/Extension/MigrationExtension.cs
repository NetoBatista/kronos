using Kronos.Domain.Entity;
using Microsoft.EntityFrameworkCore;

namespace Kronos.Extension
{
    public static class MigrationExtension
    {
        public static void ExecuteMigrations(this IServiceCollection services)
        {
            var provider = services.BuildServiceProvider();
            var migrationService = provider.GetService<KronosContext>();
            if (migrationService == null)
            {
                return;
            }
            var pendingMigrations = migrationService.Database.GetPendingMigrations();
            if (pendingMigrations.Any())
            {
                migrationService.Database.Migrate();
            }
        }
    }
}
