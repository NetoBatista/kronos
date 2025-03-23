namespace Kronos.Domain.Dto.Statistic;

public class StatisticResponseDto
{
    public Guid ApplicationId { get; set; }
    public string ApplicationName { get; set; } = string.Empty;
    public int Total { get; set; }
    public int CountInfo { get; set; }
    public int CountSuccess { get; set; }
    public int CountError { get; set; }
}