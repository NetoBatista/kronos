using Microsoft.AspNetCore.Components;

namespace Kronos.Domain.Interface.Provider;

public interface IDialogProvider
{
    void OpenDialog(string title, RenderFragment content);
    void CloseDialog();
    void Initialize(Action<string, RenderFragment>? open, Action? close);
}