﻿using Kronos.Domain.Constant;
using Kronos.Domain.Dto.Statistic;
using Kronos.Domain.Interface.Service;
using Kronos.Domain.Interfaces.Repository;

namespace Kronos.Service;

public class StatisticService : IStatisticService
{
    private readonly ILogRepository _logRepository;

    public StatisticService(ILogRepository logRepository)
    {
        _logRepository = logRepository;
    }

    public async Task<StatisticResponseDto?> Get(StatisticRequestDto request)
    {
        var logs = await _logRepository.Get(request);
        if (logs.Count == 0)
        {
            return null;
        }

        var response = new StatisticResponseDto();

        response.Totals = logs.GroupBy(x => new
        {
            applicationId = x.ApplicationId,
            applicationName = x.ApplicationNavigation.Name,
        }).Select(x => new StatisticTotalLogItemResponseDto
        {
            ApplicationId = x.Key.applicationId,
            ApplicationName = x.Key.applicationName,
            Total = x.Count(),
        }).OrderBy(x => x.ApplicationName)
          .ToList();

        response.CountTypes = logs.GroupBy(x => new
        {
            applicationId = x.ApplicationId,
            applicationName = x.ApplicationNavigation.Name
        }).Select(x => new StatisticCountTypeLogItemResponseDto
        {
            ApplicationId = x.Key.applicationId,
            ApplicationName = x.Key.applicationName,
            CountSuccess = x.Count(log => log.Type == LogConstant.Success),
            CountInfo = x.Count(log => log.Type == LogConstant.Info),
            CountError = x.Count(log => log.Type == LogConstant.Error),
        }).OrderBy(x => x.ApplicationName)
          .ToList();

        return response;
    }
}