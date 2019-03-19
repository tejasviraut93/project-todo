// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(this.drawChart);
  }

  drawChart() {
    // Create the data table.
    const projects = $(".project");
    projects.each(function () {
      const new_count = $(this).data('newtodos');
      const inprog_count = $(this).data('inprog');
      const done_count = $(this).data('done');
      const name = $(this).data('name');

      let data = new google.visualization.DataTable();
      data.addColumn('string', 'Status');
      data.addColumn('number', 'Todos');
      data.addRows([
        ['New', parseInt(new_count)],
        ['In Progress', parseInt(inprog_count)],
        ['Done', parseInt(done_count)],
      ]);
      
      // Set chart options
      let options = {'title': name,
                      'width':400,
                      'height':300};
      // Instantiate and draw our chart, passing in some options.
      let chart = new google.visualization.PieChart(document.getElementById(name));
      chart.draw(data, options);
    });
  }
}
