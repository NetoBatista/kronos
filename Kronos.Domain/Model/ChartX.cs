namespace Kronos.Domain.Model;

public class ChartX
{
    public bool BeginAtZero { get; set; } = true;
    public ChartGrid Grid { get; set; } = default!;
}