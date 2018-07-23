var websocket;
var scriptArea = document.getElementById('script');
var resultArea = document.getElementById('results-area');

function connectToServer() {
    websocket = new WebSocket("ws://localhost:8080/listen-evaluation");

    websocket.onclose = function (event) {
        alert("closed .......");
    };
    websocket.onmessage=function(event) {
        var data = JSON.parse(event.data);

        if(data.hasOwnProperty('cookie')){
            resultArea.innerHTML += "Started " + data.cookie + "<br/>";
            document.cookie = data.cookie;
            scriptArea.focus();
        } else {
            if(data.hasOwnProperty('result')){
                resultArea.innerHTML += data.result + "<br/>";
                scriptArea.focus();

            }
        }
    };
}

function sendScriptToServer() {
    resultArea.innerHTML = "";
    websocket.send(scriptArea.value);
}
