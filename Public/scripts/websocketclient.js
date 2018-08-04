var websocket;
var errorLineHandler;
var errorChar;
var scriptArea = document.getElementById('script');
var resultArea = document.getElementById('results-area');
var timerID = 0;
var ERROR_LINE_BACKGROUND = "Hop-error-line";
var ERROR_CHAR_BACKGROUND = "Hop-error-char";

myCodeMirror.on("change", function(){
    clearError();
});

function clearError() {
    resultArea.classList.remove("border-danger");

    if (errorLineHandler) {
        myCodeMirror.removeLineClass(errorLineHandler,"background", ERROR_LINE_BACKGROUND);
    }
    if (errorChar) {
        errorChar.clear();
    }
}

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
                resultArea.classList.add("border-danger");
                errorLineHandler = myCodeMirror.addLineClass(error.lineNumber - 1, "background", ERROR_LINE_BACKGROUND);
                highlightChar(error.position);
                scriptArea.focus();
            }
        }
    };
}

function sendScriptToServer() {
    clearError();
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

function highlightChar(position){

    var script = myCodeMirror.getValue();
    var scriptPerLine = script.split("\n");
    var posToFind = position;
    for (var i = 0; i < scriptPerLine.length; i++) {
        var lineLength = scriptPerLine[i].length;
        if (posToFind >= lineLength) {
            posToFind -= lineLength +1;
        } else {
            if (posToFind < 0) {
                errorChar = myCodeMirror.markText({line: i, ch: 0}, {line: i, ch: 1}, {className: ERROR_CHAR_BACKGROUND});
            } else {
                errorChar = myCodeMirror.markText({line: i, ch: posToFind}, {line: i, ch: posToFind + 1}, {className: ERROR_CHAR_BACKGROUND});
            }
            break;
        }
    }
}
