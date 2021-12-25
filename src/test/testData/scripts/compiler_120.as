class irc_event
{
	irc_event()
	{
       // apparently the following code will make AngelScript segfault rather than throw an error
		command=params='NULL';
	}
	void set_command(string@[] i) property  {command=i;}
	void set_params(string@ i) property     {params=i;}
	string@[] get_command() property {return command;    }
	string@ get_params() property    {return params;     }
	string@[] command;
	string params;
}
