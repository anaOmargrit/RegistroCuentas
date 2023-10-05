using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RegistroCuentas
{
    public partial class Cuentas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                buscarCuentas();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (tb_descripcion.Text != "")
            {
                ds_cuentas.InsertParameters["descripcion"].DefaultValue = tb_descripcion.Text;
                int result = ds_cuentas.Insert();
                if (result != 0)
                {
                    mensaje.Text = "La cuenta se ha creado correctamente.";
                    tb_descripcion.Text = "";
                }
                else
                {
                    mensaje.Text = "Ups... algo salió mal.";
                }
            }
            else
            {
                mensaje.Text = "Debe ingresar una descripción.";
            }
            buscarCuentas();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //ds_cuentas.UpdateParameters["id"].DefaultValue = ddl_cuentas.SelectedValue;
            if (tb_descripcion.Text != "")
            {
                int result = ds_cuentas.Update();
                if (result != 0)
                {
                    mensaje.Text = "La cuenta se ha actualizado correctamente.";
                    tb_descripcion.Text = "";
                }
                else
                {
                    mensaje.Text = "Ups... algo salió mal.";
                }
            }
            else
            {
                mensaje.Text = "Debe ingresar una descripción.";
            }
            buscarCuentas();
        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            tb_descripcion.Text = "";
            int resulta = ds_cuentas.Delete();
            if (resulta != 0)
            {
                mensaje.Text = "La cuenta se ha eliminado correctamente.";                
            }
            else
            {
                mensaje.Text = "Ups... algo salió mal.";
            }
            buscarCuentas();
        }
        protected void ddl_cuentas_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)ds_cuenta_editar_eliminar.Select(DataSourceSelectArguments.Empty);
            tb_descripcion.Text = "";
            mensaje.Text = "";
            if (dv != null && dv.Count > 0)
            {
                DataRowView row = dv[0];
                tb_descripcion.Text = row["descripcion"].ToString();
            }
            buscarCuentas();
        }

        protected void buscarCuentas()
        {

            DataView dv = (DataView)ds_cuentas.Select(DataSourceSelectArguments.Empty);

            if (dv != null && dv.Count > 0)
            {
                TableRow headerRow = new TableRow();

                TableCell headerCell1 = new TableCell();
                headerCell1.Text = "Identificación";
                headerRow.Cells.Add(headerCell1);

                TableCell headerCell2 = new TableCell();
                headerCell2.Text = "Descripción";
                headerRow.Cells.Add(headerCell2);

                Table1.Rows.Add(headerRow);

                //Rellenar las filas
                foreach (DataRowView rowView in dv)
                {
                    DataRow row = rowView.Row;
                    TableRow tableRow = new TableRow();

                    TableCell cell1 = new TableCell();
                    cell1.Text = row["id"].ToString();
                    tableRow.Cells.Add(cell1);

                    TableCell cell2 = new TableCell();
                    cell2.Text = row["descripcion"].ToString();
                    tableRow.Cells.Add(cell2);

                    Table1.Rows.Add(tableRow);
                }
            }


        }

    }
}