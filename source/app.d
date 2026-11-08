import std.process : Config;
import std.process : execute;
import std.stdio;
import webview;
import tinyfiledialogs;


void main()
{
    // Инициализация webview (true означает режим отладки/дека)
    auto wv = WebView(true, null);
    
    wv.setTitle("CubeD Engine Editor");
    wv.setSize(1280, 720, WindowSizeHint.None);

    // Загрузка локального HTML-интерфейса или UI со встоенного сервера
    // Можно использовать HTML-строку или путь к файлу: "file://index.html"
    wv.navigate("data:text/html,<!DOCTYPE html><html><body>" ~
                "<h1>CubeD Editor</h1>" ~
                "<div id='viewport' style='width:640px;height:480px;background:#222;'>Viewport Canvas</div>" ~
                "<button onclick='external.invoke(\"click_action\")'>Press Me</button>" ~
                "</body></html>");
	//alias BindCallback = extern(C) void function (string seq, string req, void* arg);
	 // void bind(string name, BindCallback fn, void* arg)
    // Подключение обратного вызова для связи JavaScript -> D
    wv.bind("external", (string seq, string req, void* arg) {
        writeln("Получено из JS: ", req);
        // Здесь можно обрабатывать клики по кнопкам UI, изменение параметров и т.д.
        return "";
    }, null);

    wv.run();
    
    	const char* path = tinyfd_selectFolderDialog("Select Project Root","");
	if (path == "")
		return;
	else
		writeln(path);
	try {		
		auto compile = execute(["dub", "init", "my_project", "-n"], null, Config.none, size_t.max, r"C:\vol0");
			if (compile.status != 0) 
			{
				writeln("Compilation failed:\n", compile.output);
			}
			
	}
	catch (Exception e) {
        writeln(e.msg);
	}
}
