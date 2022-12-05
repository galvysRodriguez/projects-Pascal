Program bankG;

{Diciendo que libreria se va a utilizar}
Uses 
    Strings;

{creando los tipos con los datos de usuario y con los datos de las transacciones}
Type 
    users = array [1..10000] of
        record
            id : String[8];
            name : String[20];
            lastName : String[20];
            balance : String[20];
            user : String[10];
            password : String[10];
            security : String[10];
        End;
    transactions = array[1..1000000] of 
        record
            operation : String;
            amount : String;
            from : String;
            received : String;
        End;

{variables globales para enlazar informacion}
Var
    clients : users;
    option: String;
    transaction : transactions;
    register : text;
    historial : text;
    i, h : Integer;
    flag : Boolean;


Procedure operacionesDia;
    {llena el archivo Transacciones.txt con los datos de todas las transacciones hechas durante el dia}
    Var 
        c: Integer;
    Begin
        flag := True;
        c := 1;
        Assign(historial,'Transacciones.TXT');
        Rewrite(historial);
        Write(historial,'De               ');
        Write(historial,'Para             ');
        Write(historial,'Tipo de operacion      ');
        WriteLn(historial,'Monto');
        while c <= h do
            Begin
                Write(historial, transaction[c].from, '        ');
                Write(historial, transaction[c].received,'             ');
                Write(historial, transaction[c].operation,'        ');
                WriteLn(historial, transaction[c].amount);
                c := c + 1;
            End;
        close(historial);
        WriteLn('Dentro de la carpeta esta el archivo Transacciones.txt')
    End;

Procedure saldo(j : Integer); 
    Begin
        {Te muestra el saldo}
        WriteLn('Tu saldo es ',clients[j].balance);
    End;

Procedure transferencia(j : Integer);
    {permite transferir saldo de un usuario a otro usuario}
    Var 
        k, valid: Integer;
        verify : Boolean;
        value, id : String;
        n, s, p, x : Real;
    Begin
        Val(clients[j].balance, s);
         repeat 
            WriteLn('Ingrese el monto a transferir');
            ReadLn(value);
            Val(value, n, valid);
        until (n >= 0) and (valid = 0) and (s >= n);
        k := 1;
        WriteLn('Ingrese la cedula a quien va a transferir');
        ReadLn(id);
        verify := true;
        while (k <= i) and (verify) do 
            Begin
                if clients[k].id = id then verify := false;
                k := k + 1;
            End;
        if verify then 
            Begin
                WriteLn('Cedula incorrecta');
            End
        else 
            Begin
                Val(clients[k-1].balance, p);
                p := n + p;
                Str(p:8:2,clients[k-1].balance);
                Val(clients[j].balance, x);
                x := x - n;
                Str(x:8:2,clients[j].balance);
                transaction[h].from := clients[j].id;
                transaction[h].received := clients[k-1].id;
                transaction[h].operation := 'transferencia';
                Str(n:8:2,transaction[h].amount);
                h := h + 1;
            End;
    End;
Procedure depositarOtro(j : Integer);
    {Deposita dinero a otra persona}
    Var 
        k, valid: Integer;
        verify : Boolean;
        value, id : String;
        n, s : Real;
    Begin
        repeat 
            WriteLn('Ingrese el monto a depositar');
            ReadLn(value);
            Val(value, n, valid);
        until (n >= 0) and (valid = 0);
        k := 1;
        WriteLn('Ingrese la cedula a quien va a depositar');
        ReadLn(id);
        verify := true;
        while (k <= i) and (verify) do 
            Begin
                if clients[k].id = id then verify := false;
                k := k + 1;
            End;
        if verify then 
            Begin
                WriteLn('Cedula incorrecta');
            End
        else 
            Begin
                WriteLn('Ingrese el dinero');
                WriteLn('Operacion realizada correctamente');
                Val(clients[k-1].balance, s);
                s := n + s;
                Str(s:8:2,clients[k-1].balance);
                transaction[h].from := clients[j].id;
                transaction[h].received := clients[k-1].id;
                transaction[h].operation := 'deposito';
                Str(n:8:2,transaction[h].amount);
                h := h + 1;
            End;
    End;
Procedure depositar(j: Integer);
    {deposita dinero a si mismo}
    Var 
        value: String;
        n, s: real;
        valid : Integer;

    Begin
        repeat 
            WriteLn('Ingrese el monto a depositar');
            ReadLn(value);
            Val(value, n, valid);
        until (n >= 0) and (valid = 0);
        WriteLn('Ingrese el dinero');
        WriteLn('Operacion realizada correctamente');
        WriteLn(clients[j].balance);
        Val(clients[j].balance, s);
         s := n + s;
         Str(s:8:2,clients[j].balance);
         transaction[h].from := clients[j].id;
        transaction[h].received := clients[j].id;
        transaction[h].operation := 'deposito';
        Str(n:8:2,transaction[h].amount);
        h := h + 1;
    End;

Procedure retiro(n : Real; j : Integer);
    {realiza el retiro de fondos}
    Var 
        x : Real;
    Begin
        Val(clients[j].balance,x);
        if x >= n then
            Begin 
                x := x - n;
                Str(x:8:2,clients[j].balance);
                WriteLn('En proceso...');
                WriteLn('Operacion exitosa recoja los billetes');
                transaction[h].from := clients[j].id;
                transaction[h].received := clients[j].id;
                transaction[h].operation := 'retiro';
                Str(n:8:2,transaction[h].amount);
                h := h + 1;
            End 
        else 
            WriteLn('Fondos insuficientes'); 
       
    End;

Procedure retirar(j : Integer); 
    {muestra las tarifas que puede retirar}
    Var 
        option : String;
        verify : Boolean;
    Begin
            repeat
                WriteLn('**********************   Banco Mercantil   ****************************');
                WriteLn('Cajero Automatico');
                WriteLn('Seleccione la cantidad que desee retirar');
                WriteLn('a: 1 Bs.');
                WriteLn('b: 2 Bs. ');
                WriteLn('c: 5 Bs.');
                WriteLn('d: 20 Bs.');
                WriteLn('e: 50 Bs.');
                WriteLn('f: Salir');
                verify := false;
                ReadLn(option);
                    Case option of 
                        'a' : retiro(1,j);
                        'b' : retiro(2,j);
                        'c' : retiro(5,j);
                        'd' : retiro(20,j);
                        'e' : retiro(50,j);
                        'f' : verify := true;
                    else 
                        WriteLn('Operacion invalida');
                    End;
        until verify;
    End;

Procedure historialOperaciones(j : Integer);
    {muestra al usuario su historial de transacciones}
    Var 
        c : Integer;
    Begin
        Write('De               ');
        Write('Para             ');
        Write('Tipo de operacion      ');
        WriteLn('Monto');
        c := 1;
        while c <= h do 
            Begin
                if transaction[c].from = clients[j].id then 
                    Begin
                        Write(transaction[c].from, '        ');
                        Write(transaction[c].received,'             ');
                        Write(transaction[c].operation,'        ');
                        WriteLn(transaction[c].amount);
                    End;
                c := c + 1;
            End;
    End;
Procedure cajeroAutomatico(j : Integer);
    {muestra y seleccion de las opciones del cajero}
    Var 
        verify :  Boolean;
        option : String;
        c, a : Integer;
    Begin
        c := 1;
        a := 1;
        while (c <= h) and (a=1) do 
            Begin
                if transaction[c].from = clients[j].id then 
                    Begin
                        a := a + 1;
                    End;
                c := c + 1;
            End;
        if a=1 then 
            clients[j].balance := '20.00';
        repeat
            WriteLn('**********************   Banco Mercantil   ****************************');
            WriteLn('Cajero Automatico');
            WriteLn('Selecciona una de las opciones');
            WriteLn('1: Consultar saldo');
            WriteLn('2: Depositar ');
            WriteLn('3: Depositar a otros');
            WriteLn('4: Transferencia');
            WriteLn('5: Retirar');
            WriteLn('6: Historial de operaciones');
            WriteLn('7: Salir');
            verify := false;
            ReadLn(option);
                Case option of 
                    '1' : saldo(j);
                    '2' : depositar(j);
                    '3' : depositarOtro(j);
                    '4' : transferencia(j);
                    '5' : retirar(j);
                    '6' : historialOperaciones(j);
                    '7' : verify := true;
                else 
                    WriteLn('Operacion invalida');
                End;
        until verify;
    End;

Procedure login;
    {permite iniciar sesion}
    Var 
        user, password : String;
        j : Integer;
        verify : Boolean;
    Begin
        WriteLn('Usuario: ');
        ReadLn(user);
        WriteLn('Password: ');
        ReadLn(password);
        j := 1;
        verify := True;
        while (j <= i) and (verify) and (user<>'') do 
            Begin
                if (clients[j].user = user) and (clients[j].password = password)  then
                    verify := false;
                j := j + 1;
            End;
        if verify then
            WriteLn('Datos invalidos')
        else
            Begin 
                cajeroAutomatico(j-1);
            End;

    End;


Procedure signup;
    {permite entrar al cajero auromatico con cedula}
    Var 
        user, password, id, mascota : String;
        j : Integer;
        verify, confirm, w : boolean;

    Begin 
        WriteLn('Ingrese su numero de cedula');
        ReadLn(id);
        j := 1;
        verify := True;
        while (j <= i) and (verify) do 
            Begin
                if clients[j].id = id then verify := false; 
                j := j + 1;
            End;
        if verify then 
            WriteLn('Cedula incorrecta')
        else 
            Begin
                repeat
                    WriteLn('Pregunta de seguridad');
                    WriteLn('Cual es tu mascota favorita');
                    confirm := False;
                    ReadLn(mascota);
                    if clients[j-1].security = mascota then 
                        Begin
                            confirm := True;
                            WriteLn('Bienvenido ',clients[j-1].name, ' ',clients[j-1].lastName);
                            WriteLn('Ingresaste correctamente');
                            repeat
                               WriteLn('El usuario debe ser entre 6 y 10 caracteres');
                               WriteLn('Ingrese su usuario');
                               ReadLn(user);
                               WriteLn('La contrasena debe ser entre 8 y 10 caracteres');
                               WriteLn('Ingrese su contrasena');
                               ReadLn(password);
                               w := (Length(user) >= 6) and (Length(user) <= 10) and (Length(password) >= 8) and (Length(password) <= 10);
                            until  (w);
                            if w then 
                                Begin 
                                    clients[j-1].user := user;
                                    clients[j-1].password := password;
                                    WriteLn('Se ha creado el usuario exitosamente');
                                    cajeroAutomatico(j-1);
                                End
                        End
                    else
                        Begin 
                            WriteLn('Mascota incorrecta');
                        End;
                until (w);
            End;
    End;

{cuerpo del programa}
Begin
    WriteLn('Instrucciones');
    WriteLn('En el archivo register.txt estan los usuarios registrados');
    WriteLn('con su cedula y pregunta de seguridad cree su usuario y contrasena');
    Assign(register, 'register.txt');
    reset(register);
    i := 1;
    h := 1;
    while not eof(register) do
        begin
            Read(register, clients[i].name);
            Read(register, clients[i].lastName);
            Read(register, clients[i].id);
            Read(register, clients[i].balance);
            ReadLn(register, clients[i].security);
            i := i + 1;
        end;
    repeat
        WriteLn('**********************   Banco Mercantil   ****************************');
        WriteLn('Cajero Automatico');
        WriteLn('Selecciona una de las opciones');
        WriteLn('1: Inciar sesion con usuario');
        WriteLn('2: Olvidaste contrasena o eres nuevo');
        WriteLn('3: Cerrar cajero');
        flag := false;
        ReadLn(option);
            Case option of 
                '1' : login;
                '2' : signup;
                '3' : operacionesDia;
            else 
                WriteLn('Operacion invalida');
            End;
    until flag;
   close(register);
End.