using Kronos.Domain.Dto.Application;
using Kronos.Domain.Interface.Service;
using Kronos.Extension;
using Microsoft.AspNetCore.Mvc;

namespace Kronos.Controller
{
    public class ApplicationController : ControllerBaseExtension
    {
        private readonly IApplicationService _applicationService;
        public ApplicationController(IApplicationService applicationService)
        {
            _applicationService = applicationService;
        }

        [HttpPost]
        public async Task<ActionResult<ApplicationResponseDTO>> Create([FromBody] ApplicationCreateRequestDTO request)
        {
            var response = await _applicationService.Create(request);
            return Ok(response);
        }

        [HttpPatch]
        public async Task<ActionResult<ApplicationResponseDTO>> Update([FromBody] ApplicationUpdateRequestDTO request)
        {
            var response = await _applicationService.Update(request);
            return Ok(response);
        }

        [HttpGet]
        public async Task<ActionResult<List<ApplicationResponseDTO>>> Get()
        {
            var response = await _applicationService.Get();
            return Ok(response);
        }

        [HttpDelete("{applicationId}")]
        public async Task<ActionResult> Delete(Guid applicationId)
        {
            await _applicationService.Delete(applicationId);
            return Ok();
        }
    }
}
