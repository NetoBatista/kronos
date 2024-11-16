namespace Kronos.Domain.Dto.Statistic;

public class StatisticTotalLogItemResponseDto
{
    public Guid ApplicationId { get; set; }
    public string ApplicationName { get; set; } = string.Empty;
    public decimal Total { get; set; }
}