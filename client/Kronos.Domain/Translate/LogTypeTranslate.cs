using Kronos.Domain.Constant;

namespace Kronos.Domain.Translate
{
    public static class LogTypeTranslate
    {
        public static string Translate(string input)
        {
            input = input.ToUpper();
            if (LogConstant.Info == input)
            {
                return "Informação";
            }
            else if (LogConstant.Success == input)
            {
                return "Sucesso";
            }
            else if (LogConstant.Error == input)
            {
                return "Erro";
            }
            return string.Empty;
        }
    }
}
