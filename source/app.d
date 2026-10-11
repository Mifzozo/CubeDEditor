import std.process : Config;
import std.process : execute;
import std.stdio;
import tinyfiledialogs;

void main()
{
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
	readln();
}
