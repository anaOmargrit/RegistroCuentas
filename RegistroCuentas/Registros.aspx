<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registros.aspx.cs" Inherits="RegistroCuentas.Registros" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Cuentas.aspx">Ir a Cuentas</asp:HyperLink>
            <br />
            <br />

            Registros Contables<br />
            <br />
            --Cargar un registro--<br />
            Seleccione una cuenta:<br />
            <asp:DropDownList ID="ddl_cuentas" runat="server" AutoPostBack="True" DataSourceID="ds_cuentas" DataTextField="descripcion" DataValueField="id" Width="152px" OnSelectedIndexChanged="ddl_cuentas_SelectedIndexChanged">
            </asp:DropDownList>

            <br />
            <br />
            Ingrese el tipo de asiento:
            <asp:RadioButtonList ID="rb_tipo" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                <asp:ListItem Value="0">Debe</asp:ListItem>
                <asp:ListItem Value="1">Haber</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            Ingrese el monto:<br />
            <asp:TextBox ID="monto" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="bt_crear" runat="server" Text="Crear" OnClick="bt_crear_Click" />
            &nbsp;
            <br />
            <br />
            <asp:Label ID="mensaje" runat="server" Text=""></asp:Label>
            <br />
            <br />
            -- Modificar o Eliminar un registro --<br />
            Seleccione un registro:<br />
            <asp:DropDownList ID="ddl_registros" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddl_registros_SelectedIndexChanged" Width="145px" DataSourceID="ds_registros" DataTextField="registro" DataValueField="id">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="bt_editar" runat="server" Text="Editar" OnClick="bt_editar_Click" />
            &nbsp;<asp:Button ID="bt_eliminar" runat="server" Text="Eliminar" OnClick="bt_eliminar_Click" />
            <br />
            <br />
            <br />
            Registros asentados hasta el momento:<br />
            <asp:Table ID="t_registros" runat="server" Width="596px">
            </asp:Table>
            <br />
            <br />
            <asp:SqlDataSource ID="ds_cuentas" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" SelectCommand="SELECT [id], [descripcion] FROM [Cuentas]"></asp:SqlDataSource>
            <br />
            <br />
            <asp:SqlDataSource ID="ds_registros" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" SelectCommand="SELECT RegistrosContables.id, RegistrosContables.monto, CASE WHEN CAST(tipo AS varchar(1)) = 0 THEN 'Debe' ELSE 'Haber' END AS tipo, Cuentas.descripcion,
Cuentas.descripcion + ' ' +  case when cast(tipo as varchar(1)) = '0' then 'Debe' else 'Haber' end + ' ' +cast(monto as varchar(100)) registro
FROM RegistrosContables INNER JOIN Cuentas ON RegistrosContables.idCuenta = Cuentas.id" DeleteCommand="DELETE FROM [RegistrosContables] WHERE [id] = @id" InsertCommand="INSERT INTO RegistrosContables(monto, idCuenta, tipo) VALUES (@monto,@cuenta,@tipo)" UpdateCommand="UPDATE [RegistrosContables] 
SET [idCuenta] =  @idCuenta,
[monto] = @monto,
[tipo] = @tipo
WHERE [id] = @id">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="ddl_registros" Name="id" PropertyName="SelectedValue" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="monto" Name="monto" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rb_tipo" Name="tipo" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddl_cuentas" Name="cuenta" PropertyName="SelectedValue" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="ddl_registros" Name="id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddl_cuentas" Name="idCuenta" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="monto" Name="monto" PropertyName="Text" />
                    <asp:ControlParameter ControlID="rb_tipo" Name="tipo" PropertyName="SelectedValue" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="ds_montos" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" SelectCommand="SELECT [id], 
       [monto], 
	   [idCuenta], 
	   cast(tipo as varchar(1)) AS tipo,
	   (select descripcion from Cuentas where id = idCuenta ) + ' ' +  case when cast(tipo as varchar(1)) = '1' then 'Debe' else 'Haber' end + ' ' +cast(monto as varchar(100)) registro
	   
FROM [RegistrosContables]"></asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="ds_registros_editar_eliminar" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" SelectCommand="SELECT [id], [monto], [idCuenta], cast(tipo as varchar(1)) tipo FROM [RegistrosContables] WHERE [id] = @id">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddl_registros" Name="id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />

        </div>
    </form>
</body>
</html>
