namespace Kronos.Domain.Dto.HealthCheck
{
    public class HealthCheckCreateRequestDTO
    {

        public Guid ApplicationId { get; set; }

        public bool Success { get; set; }
    }
}
