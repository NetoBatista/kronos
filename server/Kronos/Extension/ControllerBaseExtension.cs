using Microsoft.AspNetCore.Mvc;

namespace Kronos.Extension
{
    [ApiController]
    [Route("api/v1/[controller]", Name = "[controller]")]
    public abstract class ControllerBaseExtension : ControllerBase
    {
    }
}
