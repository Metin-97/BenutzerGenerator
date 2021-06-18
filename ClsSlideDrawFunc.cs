using BenutzerGenerator_MetinDereli.Properties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BenutzerGenerator_MetinDereli.Funktionen
{
   public class ClsSlideDrawFunc : FrmBenutzerGenerator
    {
        public void _drawerSlideMenu()
        {
            //Drawer Menu Öffnen
            //--
            if (HidenSlideMenu)
            {
                pnlWidthDrawer = 250;
                pnlSlideMenu.Width = pnlSlideMenu.Width + 10;
                if (pnlSlideMenu.Width >= pnlWidthDrawer)
                {
                    timeMenu.Stop();
                    HidenSlideMenu = false;
                }
            }
            //--

            //Drawer Menu 
            else
            {
                pnlSlideMenu.Width = pnlSlideMenu.Width - 10;
                if (pnlSlideMenu.Width <= 0)
                {
                    timeMenu.Stop();
                    HidenSlideMenu = true;
                }
            }
            //--
        }
        //--

        //DropDown Menu wird erstellt
        public void _dropDownMenu()
        {
            //DropDown Menu 
            if (HidenSlideDropDown)
            {
                btnDropBerechtigungen.Image = Resources.icons8_collapse_arrow_26px;
                pnlHeightDropDown = 211;
                pnlDropdown.Height = pnlDropdown.Height + 50;
                if (pnlDropdown.Height >= pnlHeightDropDown)
                {
                    time2Dropdown.Stop();
                    HidenSlideDropDown = false;
                }
            }
            else
            {
                btnDropBerechtigungen.Image = Resources.icons8_expand_arrow_26px;
                pnlDropdown.Height = pnlDropdown.Height - 50;
                if (pnlDropdown.Height <= 47)
                {
                    time2Dropdown.Stop();
                    HidenSlideDropDown = true;
                }
            }
            //--
        }
        //--
    }
}
