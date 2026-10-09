import std.process : Config;
import std.process : execute;
import std.stdio;
import tinyfiledialogs;

void main()
{
		const TFD_Filter[] filters = [
		{ ["*.png"           ],   "PNG image" },
		{ ["*.jpg", "*.jpeg" ],  "JPEG image" },
		{ ["*.tif", "*.tiff" ],  "TIFF image" },
		{ ["*.tga"           ], "TarGA image" },
	];
	// it blocks until the dialog is closed
	const char* filename = tinyfd_saveFileDialog("Save as...", "Untitled.png", filters);
	if (filename)
	{
		// now we can save our file physically
		tinyfd_messageBox("The filename is", filename, "ok", "info", 1);
	}
	try {		
		auto dmd = execute(["dub", "init", "my_project", "-n"], null, Config.none, size_t.max, r"C:\vol0");
			if (dmd.status != 0) writeln("Compilation failed:\n", dmd.output);
	}
	catch (Exception e) {
        writeln(e.msg);
	}
	readln();
}
