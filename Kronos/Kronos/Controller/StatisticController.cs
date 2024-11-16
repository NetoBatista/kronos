using Kronos.Domain.Dto.LogContent;
using Kronos.Domain.Dto.Statistic;
using Kronos.Domain.Interface.Service;
using Kronos.Extension;
using Microsoft.AspNetCore.Mvc;

namespace Kronos.Controller
{
    public class StatisticController : ControllerBaseExtension
    {
        private readonly IStatisticService _statisticService;
        public StatisticController(IStatisticService statisticService)
        {
            _statisticService = statisticService;
        }
        
        [HttpGet]
        public async Task<ActionResult<StatisticResponseDto>> Get([FromQuery] StatisticRequestDto request)
        {
            var response = await _statisticService.Get(request);
            return Ok(response);
        }
    }
}
