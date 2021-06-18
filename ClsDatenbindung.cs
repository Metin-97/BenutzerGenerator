using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BenutzerGenerator_MetinDereli.DatenbaseBinding
{
    public class ClsDatenbindung : FrmBenutzerGenerator
    {

        public void lastValueBinding()
        {
            //eine Info für die Letzte erstellung eines 
            lblLtztBenutzerName.Text = "BenutzerName:\n" + parInBenutzerKennung;
            lblPswrtLetzteErstellung.Text = "Passwort:\n" + parInPassWort;
            lblLtztEmail.Text = "E-mail Adresse:\n" + parInEmail;
            lblLtztTelefon.Text = "Telefon:\n" + parInTelefon;
            parInBenutzerName = txtBenutzername.Text;
            //--

            //Methode Für die einbindungen der Berechtigungen an den RadioButton
            ClsBerechtigung._uGRPBerechtigungee();
            //--

            // BenutzerName in die Parameter Einbinden
            parInBenutzerKennung = txtVorname.Text.Trim() + " " + txtNachname.Text.Trim();
            //--
        }
        public void _dataSetBindung()
        {
            DataSets.ds_UserTableAdapters._USERTableAdapter ta_User = new DataSets.ds_UserTableAdapters._USERTableAdapter();
            //--
            // Table Adapter mit Parameter Binden
            ta_User.Metin_BenutzerGenerator(parInUSERId, parInBenutzerKennung, parInPassWort,
                                            parInBenutzerName, parInEmail, parInTelefon,
                                            parInANSFId, parInUGRPId, ref parOutInfo,
                                            ref parOutMeldung, ref parOutResult);
            // switch case anweisung case 10 = ist gruen
            switch (parOutResult)
            {
                case 10:
                default:
                    break;
            }
            if (parOutResult != 10)
            {
                MessageBox.Show(parOutMeldung.Trim());
            }
            //tableadapter schließen
            ta_User.Dispose();
            
        }
    }
}
