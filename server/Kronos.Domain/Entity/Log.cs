namespace Kronos.Domain.Entity
{
    public partial class Log
    {
        public Guid Id { get; set; }

        public Guid ApplicationId { get; set; }

        public string Content { get; set; } = null!;

        public string Type { get; set; } = null!;

        public DateTime CreatedAt { get; set; }

        public virtual Application ApplicationNavigation { get; set; } = null!;
    }
}
