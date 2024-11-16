using Kronos.Domain.Interface.Provider;
using Microsoft.AspNetCore.Components;

namespace Kronos.Provider
{
    public class DialogProvider :IDialogProvider
    {
        private event Action<string, RenderFragment>? Open;
        private event Action? Close;
        
        public void OpenDialog(string title, RenderFragment content)
        {
            Open?.Invoke(title, content);
        }
        public void CloseDialog()
        {
            Close?.Invoke();
        }

        public void Initialize(Action<string, RenderFragment>? open, Action? close)
        {
            Open += open;
            Close += close;
        }
    }
}
