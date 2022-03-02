//Übungsaufgabe 1 

using System;
using System.Collections.Generic;

public class Args01
{
    public static void Main(string[] args)
    {
        SortedList<string, int> list = new SortedList<string,int>();
        
        for(int i = 0; i < args.Length; i++)
        {
            list.Add(args[i], i+1);
        }

        foreach(var s in list)
        {
            Console.WriteLine(s);   
        }
    }
}