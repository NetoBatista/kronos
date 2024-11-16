using System.Dynamic;

namespace Kronos.Domain.Model;

public class ChartOptions
{
    public ChartScale Scales { get; set; } = default!;
    public string IndexAxis { get; set; } = string.Empty;
    public bool Responsive { get; set; }
    public bool MaintainAspectRatio { get; set; }
}