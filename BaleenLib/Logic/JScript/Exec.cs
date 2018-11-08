using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.JScript;

namespace BaleenLib.Logic.JScript
{
    public class Exec
    {
        public static Microsoft.JScript.Vsa.VsaEngine Engine = Microsoft.JScript.Vsa.VsaEngine.CreateEngine();
        public static object EvaluateScript(string script)
        {
            object Result = null;
            try
            {
                Result = Microsoft.JScript.Eval.JScriptEvaluate(script, Engine);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            return Result;
        }
    }
}
