// Helper functions

// generate random color for chartjs
function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

// this function pass date and failures number to chartjs linechart
function jenkins_datetime_and_failure_to_linechart_axis(job_name) {
var all_data = [];
for (var j = 0; j < results[job_name].length; j++)
 {
   var jdata = {};
   jdata['x'] = results[job_name][j][2];
   jdata['y'] = results[job_name][j][1];
   all_data.push(jdata);
 }
 return all_data;
}

// OPTIONS and data
// option used for the history failure chartjs
var option_jenkins_linechart = {
  tooltips: {
 titleFontSize: 35,
 bodyFontSize: 35
},
  legend: {
    position: 'bottom',
    labels: {
        fontColor: 'black',
        fontSize: 20
    }
},
    scales: {
        yAxes: [{
          ticks: {
          fontSize: 20,
        },
         scaleLabel: {
          display: true,
          labelString: 'tests failures',
          fontSize: 35
        }
    }],
        xAxes: [{
          type: 'time',
          time: {
      unit: 'day',
      unitStepSize: 1,
      displayFormats: {
         'day': 'MMM DD YYYY'
      }},
        scaleLabel: {
            display: true,
            labelString: 'datetime',
            fontSize: 40
          },
          ticks: {
            fontSize: 16
        }

        }]
    }
}
