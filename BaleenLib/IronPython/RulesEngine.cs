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
    public class RulesEngine
    {
        public string SourceCode = "";
        private ScriptEngine _engine;
        private CompiledCode _code;
        private ScriptScope _scope;
        private string NameSpace = "";
        public RulesEngine(string DataConnection, string NmSpace, string ImportUsingHeader)
        {
            SqlConnection scn = null;
            try
            {
                scn = new SqlConnection(DataConnection);
                scn.Open();
                SqlCommand cmd = new SqlCommand(@"
SELECT     
	Workflow_BusinessRule.RuleName, 
	Workflow_BusinessRule.LogicID, 
	Workflow_BusinessRule.RuleContent, 
    Workflow_BusinessRule.CreatedByLoginName, 
	Workflow_BusinessRule.RecordDateStamp
FROM         Workflow_BusinessRule INNER JOIN
                      Workflow_UserAccessRole 
ON Workflow_BusinessRule.CreatedByLoginName = 
Workflow_UserAccessRole.LoginName
where Workflow_UserAccessRole.RoleID = 1 and
Workflow_BusinessRule.NameSpace = @NameSpace
", scn);
                cmd.Parameters.Add(new SqlParameter("@NameSpace", NmSpace));

                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                sda.Fill(dt);

                StringBuilder codeSet = new StringBuilder();

                codeSet.Append(ImportUsingHeader).Append('\r').Append('\n');

                foreach (DataRow dr in dt.Rows)
                {
                    string ruleName = dr[0].ToString();
                    long logID = long.Parse(dr[1].ToString());
                    string ruleContent = dr[2].ToString();
                    string createdBy = dr[3].ToString();
                    DateTime dateStamp = DateTime.Parse(dr[4].ToString());

                    codeSet.Append("# Rule Logic ID = " + logID.ToString()).Append('\r').Append('\n');
                    codeSet.Append("# Created By = " + createdBy).Append('\r').Append('\n');
                    codeSet.Append("# Date Created = " + dateStamp.ToShortDateString()).Append('\r').Append('\n');

                    codeSet.Append("if RuleName == '" + NmSpace.ToUpper().Trim()
                        + "." + ruleName.ToUpper().Trim() + "':");
                    codeSet.Append('\r').Append('\n');
                    string[] pylines = ruleContent.Split(new char[] { '\r', '\n' });

                    foreach (string pyl in pylines)
                    {
                        codeSet.Append('\t').Append(pyl).Append('\r').Append('\n');
                    }
                }
                this.NameSpace = NmSpace;
                this.SourceCode = codeSet.ToString();
                this._engine = Python.CreateEngine();
                this._scope = this._engine.CreateScope();
                this._scope.SetVariable("__name__", "__main__");
                ScriptSource script = this._engine.CreateScriptSourceFromString(this.SourceCode, SourceCodeKind.Statements);
                this._code = script.Compile();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write(ex.Message);
            }
            finally
            {
                if (scn != null)
                {
                    scn.Close();
                }
            }
        }
        private bool Execute()
        {
            try
            {
                this._code.Execute(this._scope);
                return true;
            }
            catch (Exception e)
            {
                ExceptionOperations eo = this._engine.GetService<ExceptionOperations>();
                System.Diagnostics.Debug.Write(eo.FormatException(e));
                return false;
            }
        }
        private void SetVariable(string name, object value)
        {
            this._engine.SetVariable(this._scope, name, value);
        }
        private bool TryGetVariable(string name, out object result)
        {
            return this._scope.TryGetVariable(name, out result);
        }
        public bool Functor(string RuleName, object Arg)
        {
            try
            {
                SetVariable("Arg", Arg);
                SetVariable("RuleName", this.NameSpace.ToUpper().Trim() + "." + RuleName.ToUpper().Trim());
                if (this.Execute())
                {
                    object ans;
                    if (TryGetVariable("Result", out ans))
                    {
                        return (bool)ans;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write(ex.Message);
                return false;
            }
        }
    }
}
