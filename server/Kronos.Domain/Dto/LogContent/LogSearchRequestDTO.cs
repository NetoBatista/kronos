using Kronos.Domain.Constant;
using System.ComponentModel.DataAnnotations;

namespace Kronos.Domain.Dto.LogContent
{
    public class LogSearchRequestDTO
    {
        public Guid? ApplicationId { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string? Content { get; set; }
        [RegularExpression($"{LogConstant.Info}|{LogConstant.Error}|{LogConstant.Success}")]
        public string? Type { get; set; }
    }
}
