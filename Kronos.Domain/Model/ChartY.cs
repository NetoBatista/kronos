namespace Kronos.Domain.Model;

public class ChartY
{
    public bool BeginAtZero { get; set; } = true;
    public ChartGrid Grid { get; set; } = default!;
}