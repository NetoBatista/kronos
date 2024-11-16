namespace Kronos.Domain.Interface.Provider;

public interface IJavascriptProvider
{
    ValueTask<T> ExecuteAsync<T>(string identifier, params object?[]? args);
    ValueTask InvokeVoidAsync(string identifier, params object?[]? args);
}