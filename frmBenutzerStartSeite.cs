using BenutzerGenerator_MetinDereli.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BenutzerGenerator_MetinDereli
{
    public partial class FrmBenutzerGenerator : Form
    {
        //aufrufen der Klassen
        public clsFehlerMeldungen clsFehler = new clsFehlerMeldungen();
        public Funktionen.ClsUserGenFunc ClsUserGenFunc = new Funktionen.ClsUserGenFunc();
        public Funktionen.ClsSlideDrawFunc ClsSlideDraw = new Funktionen.ClsSlideDrawFunc();
        public Funktionen.clsPasswordFunc clsfuncPassword = new Funktionen.clsPasswordFunc();
        public Funktionen.ClsBerechtigung ClsBerechtigung = new Funktionen.ClsBerechtigung();
        public DatenbaseBinding.ClsDatenbindung ClsDatenbindung = new DatenbaseBinding.ClsDatenbindung();
        

        //PrimaryKeys der verschiedenen Tabellen
        public decimal parInUSERId = 0;
        public decimal parInUGRPId = 0;
        public decimal parInANSFId = 0;
        //--

        // eingabe Parameter deklariert 
        public string parInVorname;
        public string parInNachname;
        public string parInTelefon;
        public string parInEmail;
        public string parInPassWort;
        public string parInBenutzerKennung;
        public string parInBenutzerName;
        //--

        // ausgabe Parameter deklarieren
        public string parOutInfo = "";
        public string parOutMeldung = "";
        public decimal? parOutResult = 0;
        //--

        // Drawer Bool Initialisiert
        public bool HidenSlideMenu = true;
        public bool HidenSlideDropDown = true;
        public bool hidenSlidePswrtDropDown = true;
        //--

        // Panel Drawer die breiten größe Deklariert
        public int pnlWidthDrawer;
        public int pnlHeightDropDown;
        public int pnlHeightDropDownPasswort;
        //--

        public FrmBenutzerGenerator()
        {
            InitializeComponent();
            // um die anwendung in der mitte des bildschirmes anzuzeigen
            this.StartPosition = FormStartPosition.CenterScreen;
            pnlSlideMenu.Width = pnlWidthDrawer;
            pnlDropdown.Height = pnlHeightDropDown;
            pnlPasswordDropdown.Height = pnlHeightDropDownPasswort;
            //--
        }

        private void btnBenutzerErstellen_Click(object sender, EventArgs e)
        {
            try
            {
                //Hinweis Meldungen
                if (string.IsNullOrEmpty(txtVorname.Text) || string.IsNullOrEmpty(txtNachname.Text))
                {
                    clsFehler._fehlerMelungBenutzerErstellen(this);
                }
                //--
                else
                {
                    //Methode für die Benutzer Generierung
                    Funktionen.ClsUserGenFunc clsUserGen = new Funktionen.ClsUserGenFunc();
                    //--

                    //Methode für die Passwort Generierung
                    clsfuncPassword._passwortGenerieren();
                    //--
                }
            }
            catch (Exception)
            {
                clsFehler._benutzerErstellenAbbruch(this);
            }
        }

        private void timeMenu_Tick(object sender, EventArgs e)
        {
            ClsSlideDraw._drawerSlideMenu();
        }

        private void BtnStartMenu_Click(object sender, EventArgs e)
        {
            // Starten des Drawer (SlideMenu)
            timeMenu.Start();
            //--
        }

        private void FrmBenutzerGenerator_Load(object sender, EventArgs e)
        {
            // Einbindung einer Tabelle in die DataGridView
            this._USERTableAdapter.Fill(this.ds_User._USER);
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            // Schließen der Anwendung
            Application.Exit();
            //--
        }

        private void btnHide_Click(object sender, EventArgs e)
        {
            // Anwendung Minimieren
            this.WindowState = FormWindowState.Minimized;
            //--
        }

        private void btnDropBerechtigungen_Click(object sender, EventArgs e)
        {
            // Starten des DropDown Menu 
            time2Dropdown.Start();
            //--
        }

        private void time2Dropdown_Tick(object sender, EventArgs e)
        {
            // Funktion der das DropDown Menu Öffnet und schließt
            ClsSlideDraw._dropDownMenu();
            //--
        }

        private void btnBenutzerInsert_Click(object sender, EventArgs e)
        {
            ClsDatenbindung.lastValueBinding();
           
            //Fehler Meldungen
            if (parInBenutzerName == "" | parInBenutzerName == null |
                parInBenutzerKennung == "" | parInBenutzerKennung == null |
                parInPassWort == "" | parInPassWort == null |
                parInEmail == "" | parInEmail == null |
                parInTelefon == "" | parInTelefon == null |
                parInUGRPId == 0)
            {
                clsFehler._BenutzerInsert();
            }
            //--
            else
            {
                //Benutzer Daten einbinden in die StoredProcedure
                ClsDatenbindung._dataSetBindung();
                
                // aktualisieren der DataGridView
                _USERTableAdapter.Fill(this.ds_User._USER);
            }
        }

        private void btnPasswortAEndern_Click(object sender, EventArgs e)
        {
            time2ChangePassword.Start();
        }

        private void time2ChangePassword_Tick(object sender, EventArgs e)
        {
            clsfuncPassword._time2PasswortChange();
        }

        public void tbPasswortZeichen_Scroll(object sender, EventArgs e)
        {
            clsfuncPassword._scrollBarPsw();
        }

        private void btnTabelleLaden_Click(object sender, EventArgs e)
        {
            // aktualisieren der DataGridView
            this._USERTableAdapter.Fill(this.ds_User._USER);
            //--
        }
    }
}
