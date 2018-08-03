var websocket;
var scriptArea = document.getElementById('script');
var resultArea = document.getElementById('results-area');
var timerID = 0;

function connectToServer() {
    var getUrl = window.location;
    var baseUrl = getUrl.host + "/" + getUrl.pathname.split('/')[1]
    if (baseUrl.startsWith("localhost")) {
        websocket = new WebSocket("ws://"+baseUrl+"/listen-evaluation");
    } else {
        websocket = new WebSocket("wss://"+baseUrl+"/listen-evaluation");
    }

    websocket.onopen = function(event) {
        keepAlive()
    }

    websocket.onclose = function (event) {
        toggleCloseAlert();
        cancelKeepAlive()
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
            } else if (data.hasOwnProperty('error')){
                var error = data.error
                resultArea.innerHTML = error.reason + " at line " + error.lineNumber + ", on char: " + error.position + "<br/>";
                scriptArea.focus();
            }
        }
    };
}

function sendScriptToServer() {
    resultArea.innerHTML = "";
    var script = myCodeMirror.getValue();
    var data = JSON.stringify({ script: script });
    websocket.send(data);
}

function toggleCloseAlert() {
    $('#ws-closed').show();
}

function keepAlive() {
    var timeout = 20000;
    if (websocket.readyState == websocket.OPEN) {
        websocket.send('');
    }
    timerId = setTimeout(keepAlive, timeout);
}
function cancelKeepAlive() {
    if (timerId) {
        clearTimeout(timerId);
    }
}

