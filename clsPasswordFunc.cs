using BenutzerGenerator_MetinDereli.Properties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BenutzerGenerator_MetinDereli.Funktionen
{
    public class clsPasswordFunc : FrmBenutzerGenerator
    {
        public void _scrollBarPsw()
        {
            lblTrackBarScroll.Text = Convert.ToString(tbPasswortZeichen.Value);
        }

        //Passwort wird Generiert
        public void _passwortGenerieren()
        {
            //Passwort werte 
            String grossbuchstaben = "QWERTZUIOPASDFGHJKLYXCVBNM";
            String kleinbuchstaben = "qwertzuiopasdfghjklyxcvbnm";
            String nummern = "12345678900";
            String sonderzeichen = "@€!$%&?*+#";
            //--

            //Variablen Zusammen 
            string alles = grossbuchstaben + kleinbuchstaben + nummern + sonderzeichen;
            //--

            //Hier wird Das Passwort erstellt durch ein 
            Char[] stringChars = new Char[tbPasswortZeichen.Value];
            Random random = new Random();
            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = alles[random.Next(alles.Length)];
                string finalystring = new string(stringChars);
                parInPassWort = finalystring;
            }
            rtbBenutzerDaten.Text = "Benutzername         " + parInBenutzerName + "\n" + "Passwort                    " + parInPassWort;
            txtBenutzername.Text = parInBenutzerName;
            //--

            //Initialisierung der Email Adresse und der Telefonnummer von der Textbox in den 
            parInEmail = txtEmail.Text;
            parInTelefon = txtTelefon.Text;
            //--
        }
        //--
        // Passwort DropDown Menu für SonderWünsche 
        
        public void _time2PasswortChange()
        {
            if (hidenSlidePswrtDropDown)
            {
                btnPasswortAEndern.Image = Resources.icons8_collapse_arrow_26px;
                pnlHeightDropDownPasswort = 144;
                pnlPasswordDropdown.Height = pnlPasswordDropdown.Height + 50;
                if (pnlPasswordDropdown.Height >= pnlHeightDropDownPasswort)
                {
                    time2ChangePassword.Stop();
                    hidenSlidePswrtDropDown = false;
                }
            }
            else
            {
                btnPasswortAEndern.Image = Resources.icons8_expand_arrow_26px;
                pnlPasswordDropdown.Height = pnlPasswordDropdown.Height - 50;
                if (pnlPasswordDropdown.Height <= 47)
                {
                    time2ChangePassword.Stop();
                    hidenSlidePswrtDropDown = true;
                }
            }
        }
    }
}
