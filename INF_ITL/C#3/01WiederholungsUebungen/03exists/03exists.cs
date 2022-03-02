// existing?

using System;

public class existing03
{
    public static void Main()
    {
        string fileName = @"../../../artikellist.txt";
        if (!File.Exists(fileName))
        {
            writingFile();
        }
        else
        {
            Console.WriteLine("File allready exists wanna override it? J/N");
            string i = Console.ReadLine();
            if (i == "J" || i == "j")
            {
                Console.WriteLine("Die Datei artikelliste.txt wurde neu erstellt.");
                writingFile();
            }
            if (i == "N" || i == "n")
            {
                Console.WriteLine("Das Programm wird ohne Änderung beendet!");
            }
        }

        void writingFile()
        {
            string[] lines = System.IO.File.ReadAllLines(@"../../../artikel.txt");
            using (StreamWriter sw = File.CreateText(fileName))
            {
                for (int i = 0; i < lines.Length; i++)
                {
                    sw.WriteLine(lines[i]);
                }
            }
            Console.WriteLine("Die Datei artikelliste.txt wurde erfolgreich geschrieben");
        }
    }
}