Program students;

Type
    materia = array [1..1000] of 
        record
            profesor : string;
            code : LongInt;
            nombre : string;
            modalidad : char;
            nota : Integer;
            seccion : String;
            horario : String;
            hora : String;
        end;

    people = array [1..1000] of              { Los datos }
        record
            nombre: string;
            email: string;
            anyoNacimiento: integer;
            cedula : LongInt;
            asignaturas : materia;
            carrera : String;
        end;

    factura = array[1..1000] of 
        record 
            codigo : Integer;
        end;


Var 
    count: integer;      
    amount : Integer; { count de datos existentes }
    opcion, value : integer;
    gente : people;    
    i : Integer;    
    carrera : String;  
    nroFactura : factura;  { Opción escogida }

Procedure inscripcion;
    Var 
        flag : Boolean;
        name : String;
    Begin
        if count < 1000 then
                begin
                    count := count + 1;
                    WriteLn('Introduciendo la persona ', count);

                    repeat 
                    flag := true;

                    Write('Introduzca el nombre: ');
                    ReadLn(name);
                    
                    if Length(name) >= 2 then gente[count].nombre := name

                    else
                        begin 
                            WriteLn('invalido');
                            flag := False;
                        end
                    until flag;

                    

                    Write('Introduzca el correo electrónico: ');
                    ReadLn(gente[count].email);

                    Write('Introduzca el año de nacimiento: ');
                    ReadLn(gente[count].anyoNacimiento);

                    Write('Introduzca su cedula : ');
                    ReadLn(gente[count].cedula);


                    repeat 
                    WriteLn('');
                    WriteLn('Que carrera desea estudiar ');
                    WriteLn('1- Ingenieria de sistemas');
                    WriteLn('2- Idiomas modernos');
                    WriteLn('3- Contaduria');
                    WriteLn('4- Diseño grafico');
                    WriteLn('5- Administracion ');
                    WriteLn('6- Derecho');
                    WriteLn('7 - Psicologia');
                    WriteLn('');
                    flag := true;
                    ReadLn(carrera);
                        case carrera of
                            '1' : gente[count].carrera := 'Ingenieria de sistemas';
                            '2' : gente[count].carrera := 'Idiomas modernos';
                            '3' : gente[count].carrera := 'Contaduria';
                            '4' : gente[count].carrera := 'Diseño grafico';
                            '5' : gente[count].carrera := 'Administracion';
                            '6' : gente[count].carrera := 'Derecho';
                            '7' : gente[count].carrera := 'Psicologia';
                            else 
                                Begin
                                    WriteLn('Seleccion invalida');
                                    flag := false;
                                End 
                        End;
                    until flag;
                    WriteLn;
                 end
                 else
                    WriteLn('Base de datos llena');
    End;


Procedure generarFactura;
    Var 
        received, j : LongInt;
        verify : Boolean;
        intro : String;

    Begin
        intro := '003';
        WriteLn('Ingresa su cedula ');
        ReadLn(received);
        j := 1;
        verify := True;
        while (j <= count) and (verify) do 
            Begin
                if (gente[j].cedula = received) then verify := false;
                j := j +1;
            End;
        if verify then 
            WriteLn('Tu cedula es incorrecta ')
        else 
            Begin
                value := value + 1;
                WriteLn('Bienvenido ', gente[j-1].nombre);
                WriteLn('Imprimiendo factura .....');
                WriteLn('Tu factura es ',intro,'-',value);
                nroFactura[j-1].codigo := value;
            End;
        WriteLn('   ');
    End; 

Procedure inscribirMaterias;
    Var 
        j, received : Integer;
        verify : Boolean;
    Begin
      WriteLn('Ingrese los valores de la factura despues del - ');
      ReadLn(received);
      j := 1;
      verify := True;
      while (j<= value ) and (verify) do 
        Begin
            if (nroFactura[j].codigo = received) then verify := false;
            j := j + 1;
        End;

        if verify then 
            WriteLn('Numero de factura incorrecto')
        else 
            Begin
                WriteLn('Bienvenido ',gente[j-1].nombre);
                WriteLn('Estudiante de ',gente[j-1].carrera);
            End
    End;

{Cuerpo del programa principal}
begin
    count := 0;
    amount := 0;
    value := 0;
    repeat
        WriteLn('Agenda');
        WriteLn;
        WriteLn('1- Ingresar una nueva persona');
        WriteLn('2- Ver nombres de todos');
        WriteLn('3- Generar una factura ');
        WriteLn('4- inscribir materias ');
        WriteLn('0- Salir');
        Write('Escoja una opcion: ');
        ReadLn(opcion);
        WriteLn;

        case opcion of
            1: inscripcion;
                

            2: { Ver nombres de todos }
                begin
                if count = 0 then
                    WriteLn('No hay datos')
                else
                    for i := 1 to count do
                        WriteLn(i, ' ', gente[i].nombre);
                WriteLn;
                end;

            0: { Salir de la aplicación }
                begin
                WriteLn;
                WriteLn('Saliendo...');
                WriteLn;
                end;

            3: generarFactura;
            4: inscribirMaterias;

             else
                begin
                WriteLn;
                WriteLn('Opción incorrecta!');
                WriteLn;
                end;
        end;  { Fin de "case" }

    until opcion = 0;
end.
    