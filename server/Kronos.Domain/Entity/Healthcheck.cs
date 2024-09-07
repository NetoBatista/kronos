namespace Kronos.Domain.Entity
{
    public partial class HealthCheck
    {
        public Guid Id { get; set; }

        public Guid ApplicationId { get; set; }

        public bool Success { get; set; }

        public DateTime CreatedAt { get; set; }

        public virtual Application ApplicationNavigation { get; set; } = null!;
    }
}
