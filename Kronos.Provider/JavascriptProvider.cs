using Kronos.Domain.Interface.Provider;
using Microsoft.JSInterop;

namespace Kronos.Provider;

public class JavascriptProvider : IJavascriptProvider
{
    private readonly IJSRuntime _jsRuntime;
    public JavascriptProvider(IJSRuntime jsRuntime)
    {
        _jsRuntime = jsRuntime;
    }
    
    public ValueTask<T> ExecuteAsync<T>(string identifier, params object?[]? args)
    {
        return _jsRuntime.InvokeAsync<T>(identifier, args);
    }
    
    public ValueTask InvokeVoidAsync(string identifier, params object?[]? args)
    {
        return _jsRuntime.InvokeVoidAsync(identifier, args);
    }
}