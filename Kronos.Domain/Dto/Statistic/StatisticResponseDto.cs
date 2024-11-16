namespace Kronos.Domain.Dto.Statistic;

public class StatisticResponseDto
{
    public List<StatisticTotalLogItemResponseDto> Totals { get; set; } = [];
    public List<StatisticCountTypeLogItemResponseDto> CountTypes { get; set; } = [];
}