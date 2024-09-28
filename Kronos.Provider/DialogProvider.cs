using Microsoft.AspNetCore.Components;

namespace Kronos.Provider
{
    public class DialogProvider
    {
        public event Action<string, RenderFragment>? Open;
        public event Action? Close;
        public void OpenDialog(string title, RenderFragment content)
        {
            Open?.Invoke(title, content);
        }
        public void CloseDialog()
        {
            Close?.Invoke();
        }
    }
}
