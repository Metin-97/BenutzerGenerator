using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BenutzerGenerator_MetinDereli.Funktionen
{
   public class ClsUserGenFunc : FrmBenutzerGenerator
    {
        public void _benutzerGenerieren()
        {
            //Benutzernamen und Passwort Deklariert und Convertiert auf String
            string nachname = Convert.ToString(txtNachname.Text.Trim());
            string vorname = Convert.ToString(txtVorname.Text.Trim());
            parInVorname = txtVorname.Text;
            parInNachname = txtNachname.Text;
            //--

            //UMLAUTE
            //--Nachname
            nachname = nachname.Replace("ä", "ae");
            nachname = nachname.Replace("Ä", "AE");
            nachname = nachname.Replace("Ö", "OE");
            nachname = nachname.Replace("ö", "oe");
            nachname = nachname.Replace("Ü", "UE");
            nachname = nachname.Replace("ü", "ue");
            nachname = nachname.Replace("ß", "ss");
            nachname = nachname.Replace("é", "e");
            //--Vorname
            vorname = vorname.Replace("Ä", "AE");
            vorname = vorname.Replace("Ö", "OE");
            vorname = vorname.Replace("ö", "oe");
            vorname = vorname.Replace("Ü", "UE");
            vorname = vorname.Replace("ü", "ue");
            vorname = vorname.Replace("ß", "ss");
            vorname = vorname.Replace("é", "e");
            //--

            //Umlaute wechseln in den 
            txtVorname.Text = vorname;
            txtNachname.Text = nachname;
            //--

            //Vor und nachname werden vereint
            string benutzername = nachname + vorname;
            //--

            //Benutzername wird hier erstellt durch den Vor und 
            if (benutzername.Length <= 8)
            {
                parInBenutzerName = benutzername;
            }
            else if (nachname.Length > 7)
            {
                parInBenutzerName = nachname.Substring(0, 7) + vorname.Substring(0, 1);
            }
            else if (nachname.Length <= 7)
            {
                parInBenutzerName = benutzername.ToString().Substring(0, 8);
            }
            //--
        }
        //--
    }
}
