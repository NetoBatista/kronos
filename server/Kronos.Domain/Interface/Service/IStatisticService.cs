﻿using Kronos.Domain.Dto.Statistic;

namespace Kronos.Domain.Interface.Service;

public interface IStatisticService
{
    Task<List<StatisticResponseDto>> Get(StatisticRequestDto request);
}