using Kronos.Domain.Model;

namespace Kronos.Domain.Interface.Provider;

public interface IChartProvider
{
    ValueTask RenderChart(string element, ChartModel chartModel);
}