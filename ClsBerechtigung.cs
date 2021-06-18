using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BenutzerGenerator_MetinDereli.Funktionen
{
   public class ClsBerechtigung : FrmBenutzerGenerator
    {
        public void _uGRPBerechtigungee()
        {
            //Berechtigungen von den RadioButton auf die Parameter Initialisieren
            if (rbBerechtigung1.Checked == true)
            {
                parInUGRPId = 7;
            }
            //--
            if (rbBerechtigung2.Checked == true)
            {
                parInUGRPId = 12;
            }
            //--
            if (rbBerechtigung3.Checked == true)
            {
                parInUGRPId = 15;
            }
            //--
            if (rbBerechtigung4.Checked == true)
            {
                parInUGRPId = 17;
            }
            //--
            if (rbBerechtigung5.Checked == true)
            {
                parInUGRPId = 18;
            }
            //--
        }
    }
}
