namespace Kronos.Domain.Dto.Application
{
    public class ApplicationResponseDTO
    {
        public Guid Id { get; set; }

        public Guid Key { get; set; }

        public string Name { get; set; } = null!;

        public string? HealthCheck { get; set; }

        public DateTime CreatedAt { get; set; }
    }
}
