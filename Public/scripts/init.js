$(function () {
  $('[data-toggle="tooltip"]').tooltip()
  })


var xmlhttp = new XMLHttpRequest();
xmlhttp.open("GET", "/api/version", false);
xmlhttp.send();

if (xmlhttp.status==200) {
    var data = JSON.parse(xmlhttp.responseText);

    if(data.hasOwnProperty('version')){
        $("#version").text("Hop " + data.version);
    }
}





