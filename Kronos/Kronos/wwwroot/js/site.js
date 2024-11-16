﻿window.kronos = {
    loadChart: function (element, chartModel){
        const ctx = document.getElementById(element);
        if(ctx == null){
            return;
        }
        
        return new Chart(ctx, {
            type: chartModel.type,
            data: {
                labels: chartModel.data.labels,
                datasets: chartModel.data.datasets
            },
            options: chartModel.options
        });
    }
}