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

function snippetFactorial() {
    myCodeMirror.getValue();
    const factorialString = "import Sys\nfunc factorial(#n: Int) -> Int {\n\tif n == 0 {\n\t\treturn 1\n\t}\n\treturn n * factorial(n-1)\n}\nconst result = factorial(5)\nSys.print(Sys.string(result))\n"
    myCodeMirror.setValue(myCodeMirror.getValue() + factorialString);
}

function snippetForLoop(){
    myCodeMirror.getValue();
    const forScript = "for i in 0 to 5 {\n\t// loop five times with i € [0, 1, 2, 3, 4]\n}\n\n for i in 0 to 10 step 2 {\n\t// loop five times with i € [0, 2, 4, 6, 8]\n}\n\nfor i in 10 to 0 step -2{\n\t// loop five times with i € [10, 8, 6, 4, 2]\n}\n"
    myCodeMirror.setValue(myCodeMirror.getValue() + forScript);
}

function snippetWhileLoop() {
    myCodeMirror.getValue();
    const whileScript = "var count = 0\nwhile count < 5 {\n\tcount = count - 1\n// Loop five times\n}\n"
    myCodeMirror.setValue(myCodeMirror.getValue() + whileScript);
}
function snippetClasses(){
    myCodeMirror.getValue();
    const classesScript = `import Sys
/*
Superclass
*/
class Entity {
    static var counterId = 0
    var uniqueId: Int
    func init() {
        counterId = counterId + 1
        self.uniqueId = counterId
    }
}

/*
Subclass
*/
class Player: Entity {

    var name: String

    func init(name: String) {
        super.init()
        self.name = name
    }

    func getDescription() -> String {
        return "[" + Sys.string(self.uniqueId) + "] - " + self.name
    }
}

const me = Player(name: "Jon")
Sys.print(me.getDescription())

const her = Player(name: "Daenerys")
Sys.print(her.getDescription())
`
    myCodeMirror.setValue(myCodeMirror.getValue() + classesScript);
}

function copyToClipboard() {
    new ClipboardJS('.btn-clipboard',
                    { text: function(trigger) {
                                $("#cpy-to-clip").tooltip('show');
                                    setTimeout(function() {
                                            $("#cpy-to-clip").tooltip('hide');
                                            }, 2000);
                                return myCodeMirror.getValue();
                        }
                    });

    //const selection = window.getSelection();
    //document.execCommand("copy");
    //selection.removeAllRanges();
}
