namespace Kronos.Domain.Dto.LogContent
{
    public class LogResponseDTO
    {
        public Guid Id { get; set; }

        public Guid ApplicationId { get; set; }

        public string Content { get; set; } = null!;

        public string Type { get; set; } = null!;

        public DateTime CreatedAt { get; set; }
    }
}
