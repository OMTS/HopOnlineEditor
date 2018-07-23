//source: https://jsfiddle.net/2wAzx/13/

var scriptArea = document.getElementById('script');

function enableTab(id) {
    var el = document.getElementById(id);
    el.onkeydown = function(e) {
        if (e.keyCode === 9) { // tab was pressed

            // get caret position/selection
            var val = this.value,
            start = this.selectionStart,
            end = this.selectionEnd;

            // set textarea value to: text before caret + tab + text after caret
            this.value = val.substring(0, start) + '\t' + val.substring(end);

            // put caret at right position again
            this.selectionStart = this.selectionEnd = start + 1;

            // prevent the focus lose
            return false;

        }
    };
}

function importSys() {
    scriptArea.value = "import Sys\n" + scriptArea.value
    scriptArea.focus();

}

function importMath() {
    scriptArea.value = "import Math\n" + scriptArea.value
    scriptArea.focus();
}

// Enable the tab character onkeypress (onkeydown) inside textarea...
// ... for a textarea that has an `id="my-textarea"`
enableTab('script');
scriptArea.focus();
