/**
   * Table Darstellung laut https://datatables.net/extensions/fixedheader/examples/integration/responsive-bootstrap.html
   */
 $(document).ready(function () {
    var table = $('#BlogbeitraegeTable').DataTable({
      responsive: true
    });
    // todo: understand why this isn't needed
    //new $.fn.dataTable.FixedHeader( table );
  });

  // BlogbeitraegeTable, blogbeitraege
  $("#meinSwitch").on("change", function () {

    if (this.checked == true) {
      $("#Blog").show()
      $("#blogbeitraege").hide()
    }
    else {
      $("#Blog").hide()
      $("#blogbeitraege").show()
    }
  })