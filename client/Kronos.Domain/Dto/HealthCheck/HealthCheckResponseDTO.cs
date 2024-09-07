namespace Kronos.Domain.Dto.HealthCheck
{
    public class HealthCheckResponseDTO
    {
        public Guid Id { get; set; }

        public Guid ApplicationId { get; set; }

        public bool Success { get; set; }

        public DateTime CreatedAt { get; set; }
    }
}
