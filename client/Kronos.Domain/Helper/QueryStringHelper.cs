using System.Reflection;
using System.Text;

namespace Kronos.Domain.Helper
{
    public static class QueryStringHelper
    {
        public static string ToQueryString<T>(T obj)
        {
            if (obj == null)
            {
                return string.Empty;
            }

            var queryString = new StringBuilder("?");
            var properties = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            var queryParameters = new List<string>();

            foreach (var property in properties)
            {
                var value = property.GetValue(obj);
                if (value?.ToString() == null)
                {
                    continue;
                }
                var encodedValue = string.Empty;
                if (property.PropertyType == typeof(DateTime) ||
                    property.PropertyType == typeof(DateTime?))
                {
                    DateTime dateTimeValue = (DateTime)(value ?? default(DateTime));
                    var isoDateString = dateTimeValue.ToString("o");
                    encodedValue = Uri.EscapeDataString(isoDateString);
                    queryParameters.Add($"{Uri.EscapeDataString(property.Name)}={encodedValue}");
                    continue;
                }
                encodedValue = Uri.EscapeDataString(value.ToString()!);
                queryParameters.Add($"{Uri.EscapeDataString(property.Name)}={encodedValue}");
            }

            queryString.Append(string.Join("&", queryParameters));

            return queryString.ToString();
        }
    }
}
