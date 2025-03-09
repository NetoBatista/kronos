namespace Kronos.Domain.Model;

public class ChartModel
{
    public string Type { get; set; } = string.Empty;
    public ChartData Data { get; set; } = default!;
    public ChartOptions Options { get; set; } = default!;
}