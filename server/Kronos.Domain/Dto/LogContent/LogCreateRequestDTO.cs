using Kronos.Domain.Constant;
using System.ComponentModel.DataAnnotations;

namespace Kronos.Domain.Dto.LogContent
{
    public class LogCreateRequestDTO
    {
        [Required]
        public Guid ApplicationKey { get; set; }

        [Required]
        public string Content { get; set; } = null!;

        [RegularExpression($"{LogConstant.Info}|{LogConstant.Error}|{LogConstant.Success}")]
        public string Type { get; set; } = null!;
    }
}
