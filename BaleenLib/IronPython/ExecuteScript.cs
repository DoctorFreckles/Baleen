using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IronPython;
using IronPython.Hosting;
using Microsoft.Scripting;
using Microsoft.Scripting.Hosting;

namespace Dendra.Logic.IronPython
{
    public class ExecuteScript
    {
        private ScriptEngine se = null;
        public ExecuteScript(string FilePath)
        {
            try
            {
                se = Python.CreateEngine();
                ScriptSource source;
                source = se.CreateScriptSourceFromFile(FilePath);
                ScriptScope scope = se.CreateScope();
                source.Execute(scope);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write(ex.Message);
            }
        }
    }
}
