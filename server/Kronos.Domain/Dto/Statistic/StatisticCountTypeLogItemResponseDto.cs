namespace Kronos.Domain.Dto.Statistic;

public class StatisticCountTypeLogItemResponseDto
{
    public Guid ApplicationId { get; set; }
    public string ApplicationName { get; set; } = string.Empty;
    public int CountInfo { get; set; }
    public int CountSuccess {get; set;}
    public int CountError { get; set; }
}