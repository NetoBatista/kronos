namespace Kronos.Domain.Entity
{
    public partial class Application
    {
        public Guid Id { get; set; }

        public Guid Key { get; set; }

        public string Name { get; set; } = null!;

        public string? HealthCheck { get; set; }

        public DateTime CreatedAt { get; set; }

        public virtual ICollection<HealthCheck> HealthCheckNavigation { get; set; } = [];

        public virtual ICollection<Log> LogNavigation { get; set; } = [];
    }
}
