using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RegistroCuentas
{
    public partial class Registros : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                buscarRegistros();
            }
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void bt_crear_Click(object sender, EventArgs e)
        {
            if (monto.Text != "" && ddl_cuentas.SelectedIndex >= 0 && rb_tipo.SelectedIndex >= 0)
            {
                int result = ds_registros.Insert();
                if (result != 0)
                {
                    mensaje.Text = "El registro se ha creado correctamente.";                    
                    monto.Text = ""; 
                    rb_tipo.SelectedValue = null;
                    ddl_cuentas.SelectedValue = null;
                }
                else
                {
                    mensaje.Text = "Ups... algo salió mal.";
                }
            }
            else
            {
                mensaje.Text = "Debe completar todos los campos para insertar el registro.";
            }
            buscarRegistros();
        }

        protected void buscarRegistros()
        {

            DataView dv = (DataView)ds_registros.Select(DataSourceSelectArguments.Empty);

            if (dv != null && dv.Count > 0)
            {
                TableRow headerRow = new TableRow();

                TableCell headerCell1 = new TableCell();
                headerCell1.Text = "Nro Registro";
                headerRow.Cells.Add(headerCell1);

                TableCell headerCell2 = new TableCell();
                headerCell2.Text = "Cuenta";
                headerRow.Cells.Add(headerCell2);

                TableCell headerCell3 = new TableCell();
                headerCell3.Text = "Tipo";
                headerRow.Cells.Add(headerCell3);

                TableCell headerCell4 = new TableCell();
                headerCell4.Text = "Monto";
                headerRow.Cells.Add(headerCell4);

                t_registros.Rows.Add(headerRow);

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

                    TableCell cell3 = new TableCell();
                    cell3.Text = row["tipo"].ToString();
                    tableRow.Cells.Add(cell3);

                    TableCell cell4 = new TableCell();
                    cell4.Text = row["monto"].ToString();
                    tableRow.Cells.Add(cell4);
                    
                    t_registros.Rows.Add(tableRow);
                }
            }


        }

        protected void bt_editar_Click(object sender, EventArgs e)
        {
            if (monto.Text != "" && ddl_cuentas.SelectedIndex >= 0 && rb_tipo.SelectedIndex >= 0)
            {
                int result = ds_registros.Update();
                if (result != 0)
                {
                    mensaje.Text = "El registro se ha actualizado correctamente.";
                    monto.Text = "";
                    rb_tipo.SelectedValue = null;
                    ddl_cuentas.SelectedValue = null;
                }
                else
                {
                    mensaje.Text = "Ups... algo salió mal.";
                }
            }

            buscarRegistros();
        }

        protected void ddl_registros_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)ds_registros_editar_eliminar.Select(DataSourceSelectArguments.Empty);
            monto.Text = "";
            mensaje.Text = "";
            if (dv != null && dv.Count > 0)
            {
                DataRowView row = dv[0];
                monto.Text = row["monto"].ToString();
                rb_tipo.SelectedValue = row["tipo"].ToString();
                ddl_cuentas.SelectedValue = row["idCuenta"].ToString();
            }

            buscarRegistros();
        }

        protected void bt_eliminar_Click(object sender, EventArgs e)
        {
            int resulta = ds_registros.Delete();
            if (resulta != 0)
            {
                mensaje.Text = "El registro se ha eliminado correctamente.";
                monto.Text = "";
                rb_tipo.SelectedValue = null;
                ddl_cuentas.SelectedValue = null;
            }
            else
            {
                mensaje.Text = "Ups... algo salió mal.";
            }

            buscarRegistros();
        }

        protected void ddl_cuentas_SelectedIndexChanged(object sender, EventArgs e)
        {
            buscarRegistros();
            monto.Text = "";
            rb_tipo.SelectedValue = null;
        }
    }
}