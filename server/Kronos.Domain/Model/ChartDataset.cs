namespace Kronos.Domain.Model;

public class ChartDataset
{
    public string Label { get; set; } = string.Empty;
    public List<decimal> Data { get; set; } = [];
    public int BorderWidth { get; set; } = 1;
    public List<string> BackgroundColor { get; set; } = [];
    public string Axis { get; set; } = string.Empty;
    public bool Fill { get; set; }
}