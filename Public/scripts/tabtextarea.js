//source: https://jsfiddle.net/2wAzx/13/

var scriptArea = document.getElementById('script');
var myCodeMirror = CodeMirror.fromTextArea(scriptArea, {
                                           lineNumbers: true,
                                           theme: "dracula",
                                           mode: "swift",
                                           matchBrackets: true,
                                           autoCloseBrackets: true
                                           });

function importSys() {
    myCodeMirror.getValue();
    myCodeMirror.setValue("import Sys\n" +  myCodeMirror.getValue());
}

function importMath() {
    myCodeMirror.getValue();
    myCodeMirror.setValue("import Math\n" +  myCodeMirror.getValue());
}

function copyToClipboard() {
    scriptArea.select();
    const selection = window.getSelection();
    document.execCommand("copy");
    selection.removeAllRanges();
}
