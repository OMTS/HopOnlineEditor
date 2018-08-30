//Activiating document's tooltips
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
  })

//Getting Hop version number
var client = new XMLHttpRequest();
client.onload = reponseHandler;
client.open("GET", "/api/version");
client.send();

function reponseHandler() {
    if (this.status==200) {
        var data = JSON.parse(this.responseText);

        if(data.hasOwnProperty('version')){
            $("#version").text("Hop " + data.version);
        }
    }
}









