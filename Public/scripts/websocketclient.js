var websocket;

function connectToServer() {
    websocket = new WebSocket("ws://localhost:8080/listen-evaluation");
    var div = document.getElementById('results-area');

    websocket.onclose = function (event) {
        alert("closed .......");
    };
    websocket.onmessage=function(event) {
        var data = JSON.parse(event.data);

        if(data.hasOwnProperty('cookie')){
            div.innerHTML += "Started " + data.cookie + "<br/>";
            document.cookie = data.cookie;

        } else {
            if(data.hasOwnProperty('result')){
                div.innerHTML += data.result + "<br/>";
            }
        }
    };
    return websocket
}

function sendScriptToServer() {
    var div = document.getElementById('results-area');
    div.innerHTML = "";
    var scriptArea = document.getElementById('script');
    websocket.send(scriptArea.value);
}
