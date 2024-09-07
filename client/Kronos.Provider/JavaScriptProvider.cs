using Microsoft.JSInterop;

namespace Kronos.Provider
{
    public class JavascriptProvider(IJSRuntime jsRuntime)
    {
        private readonly IJSRuntime _jsRuntime = jsRuntime;
        public void CopyToClipBoard(string text)
        {
            _ = _jsRuntime.InvokeVoidAsync("navigator.clipboard.writeText", text);
        }

    }
}
