// Working with Text file

using System;
using System.Collections.Generic;

public class txt02
{
    public static void Main()
    {
        string[] lines = System.IO.File.ReadAllLines(@"../../../artikel.txt");
        SortedDictionary<int, string> foo = new SortedDictionary<int, string>();

        for (int i = 0; i < lines.Length; i++)
        {
            string[] boo = lines[i].Split(' ');
            foo.Add(int.Parse(boo[0]), boo[1]);
        }

        foreach (var i in foo)
        {
            Console.WriteLine(i);
        }
    }
}