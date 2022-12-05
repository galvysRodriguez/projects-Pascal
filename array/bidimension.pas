Program bidimension;

Const 
    n = 3;
Var 
    matriz : array [0..n,0..n] of Integer;
    menu, follow : string;
    flag, final, condicion : boolean;
    i,j, sum, det, producto, opuesto: Integer;


Procedure ingresarMatriz;
    Begin
        i := 0;
        while i<n do 
            begin
                j:= 0;
              while j <n do
                begin
                    WriteLn('Enter a component [',i,',',j,']');
                    ReadLn(matriz[i,j]);
                    j := j +1;
                end;
                i := i +1;
            end;
        i := 0;
        WriteLn('La matriz ingresada es: ');
        Write('|    ');
        while i<n do 
            begin
                j:= 0;
              while j <n do
                begin
                    Write(matriz[i,j],'     ');
                    j := j +1;
                end;
                WriteLn('|');
                Write('|    ');
                i := i +1;
            end;
    End;

Procedure trazaMatriz;
    Begin
        WriteLn('La traza de la matriz es la suma de la diagonal principal');
        i := 0;
        sum := 0;
        while i<n do 
            begin
                j:= 0;
              while j <n do
                begin
                    if i = j then
                        begin 
                            WriteLn('elemento [',i,',',j,'] = ',matriz[i,j]);
                            sum := matriz[i,j] + sum;
                        end;
                    j := j +1;
                end;
                i := i +1;
            end;
        WriteLn('La traza es ',sum);
    End;

Procedure determinanteMatriz;
    Begin
        sum := matriz[0,0] * matriz[1,1] * matriz[2,2];
        WriteLn(matriz[0,0] * matriz[1,1] * matriz[2,2]);
        sum := sum + matriz[0,1] * matriz[1,2] * matriz[2,0];
        WriteLn(matriz[0,1] * matriz[1,2] * matriz[2,0]);
        sum := sum + matriz[0,2] * matriz[1,0] * matriz[2,1];
        WriteLn(matriz[0,2] * matriz[1,0] * matriz[2,1]);
        opuesto := matriz[0,2] * matriz[1,1] * matriz[2,0];
        WriteLn(matriz[0,2] * matriz[1,1] * matriz[2,0]);
        opuesto := opuesto + matriz[0,0] * matriz[1,2] * matriz[2,1];
        WriteLn(matriz[0,0] * matriz[1,2] * matriz[2,1]);
        opuesto := opuesto + matriz[0,1] * matriz[1,0] * matriz[2,2];
        WriteLn(matriz[0,1] * matriz[1,0] * matriz[2,2]);
        WriteLn(sum, '-',opuesto);
        det := sum - opuesto;
        WriteLn('El determinante es ',det);
    End;

Begin 
    WriteLn('**********Welcome*********');
    Repeat
        final := true;
        Repeat 
            WriteLn('Menu');
            WriteLn('1: Ingresa la matriz');
            WriteLn('2: Calcular la traza');
            WriteLn('3: Determinante');
            WriteLn('4: Salir');
            flag := true;
            ReadLn(menu);
            case menu of
                '1' : ingresarMatriz;
                '2' : trazaMatriz;
                '3' : determinanteMatriz;
                '4' : WriteLn('Saliendo');
                else 
                    WriteLn('Operacion Invalida');
                    flag := false;
            End;
        Until flag;
        repeat
            condicion := true;
            WriteLn('Desea continuar s/n');
            ReadLn(follow);
            if follow = 's' then final := False
            else if follow = 'n' then WriteLn('Bye')
            else condicion := false;
        until condicion;
    Until final;
End.