using Kronos.Domain.Interface.Provider;
using Kronos.Domain.Model;

namespace Kronos.Provider;

public class ChartProvider : IChartProvider
{
    private readonly IJavascriptProvider _javascriptProvider;
    public ChartProvider(IJavascriptProvider javascriptProvider)
    {
        _javascriptProvider = javascriptProvider;
    }

    public ValueTask RenderChart(string element, ChartModel chartModel)
    {
        return _javascriptProvider.InvokeVoidAsync("window.kronos.loadChart", element, chartModel);
    }
}