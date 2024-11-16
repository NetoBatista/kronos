namespace Kronos.Domain.Util;

public class DateUtil
{
    public static Dictionary<int, string> GetMonths()
    {
        return new Dictionary<int, string>
        {
            {1 , "Janeiro"},
            {2, "Fevereiro"},
            {3, "Março"},
            {4, "Abril"},
            {5, "Maio"},
            {6, "Junho"},
            {7, "Julho"},
            {8, "Agosto"},
            {9, "Setembro"},
            {10, "Outubro"},
            {11, "Novembro"},
            {12, "Dezembro"},
        };
    }

    public static string GetMonth(int month)
    {
        return GetMonths()[month];
    }
}