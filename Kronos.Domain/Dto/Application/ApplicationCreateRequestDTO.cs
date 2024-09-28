using System.ComponentModel.DataAnnotations;

namespace Kronos.Domain.Dto.Application
{
    public class ApplicationCreateRequestDTO
    {
        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = null!;

        [MaxLength(1000)]
        public string? HealthCheck { get; set; }
    }
}
