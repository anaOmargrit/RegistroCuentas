<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cuentas.aspx.cs" Inherits="RegistroCuentas.Cuentas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Registros.aspx">Ir a Registros Contables</asp:HyperLink>
            <br />
            <br />

            Nueva cuenta:<br />
            Descripción:&nbsp;
            <asp:TextBox ID="tb_descripcion" runat="server"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Agregar" OnClick="Button1_Click" />

        &nbsp;<br />
            <br />
            <asp:Label ID="mensaje" runat="server" Text=""></asp:Label>

            <br />
            <br />
            <asp:DropDownList ID="ddl_cuentas" runat="server" AutoPostBack="True" DataSourceID="ds_cuentas" DataTextField="descripcion" DataValueField="id" OnSelectedIndexChanged="ddl_cuentas_SelectedIndexChanged">
            </asp:DropDownList>

        &nbsp;<asp:Button ID="Button3" runat="server" Text="Borrar" OnClick="Button3_Click" />

            &nbsp;<asp:Button ID="Button2" runat="server" Text="Modificar" OnClick="Button2_Click" />

            <br />
            <br />
            Cuentas Existentes:<br />
            <asp:Table ID="Table1" runat="server" Width="325px">
            </asp:Table>
            <asp:SqlDataSource ID="ds_cuentas" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" DeleteCommand="DELETE FROM [Cuentas] WHERE [id] = @id" InsertCommand="INSERT INTO [Cuentas] ([descripcion]) VALUES (@descripcion)" SelectCommand="SELECT [id], [descripcion] FROM [Cuentas]" UpdateCommand="UPDATE [Cuentas] SET [descripcion] = @descripcion WHERE [id] = @id">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="ddl_cuentas" Name="id" PropertyName="SelectedValue" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="descripcion" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="tb_descripcion" Name="descripcion" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="ddl_cuentas" Name="id" PropertyName="SelectedValue" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="ds_cuenta_editar_eliminar" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" SelectCommand="SELECT [id], [descripcion] FROM [Cuentas] WHERE [id] = @id">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddl_cuentas" Name="id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />

        </div>
    </form>
</body>
</html>
