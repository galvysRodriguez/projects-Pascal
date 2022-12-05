Program gauss;

Type 
    matriz = array[1..3,1..4] of Integer;

Var 
    ecuacion : matriz;
    y, x, z : Integer;

Procedure secondResolution();
    Var 
        i : Integer;
    Begin
        WriteLn('Segunda resolucion');
        WriteLn('sumando la fila 2  con la 3');
        i := 1;
        while i <= 4 do 
            Begin
                ecuacion[2,i] := ecuacion[2,i] + ecuacion[3,i];
                i := i +1;
            End;
    End;

Procedure firstResolution();
    Var
        i, j : Integer;
    Begin
        WriteLn('Primera resolucion');
        i := 2; 
        while i <= 3 do 
            Begin
                j := 1;
                WriteLn('Combinando la fila 1 con la fila ',i);
                WriteLn('multiplicando la fila 1 por ', ecuacion[i,1]);
                while j <= 4 do 
                    Begin
                       if j > 1 then 
                        Begin 
                        write(', ');
                        Write(ecuacion[1,j]*ecuacion[i,j], ' -(', ecuacion[i,j], ')');
                        End
                        else 
                            Begin
                                Write(ecuacion[1,j]*ecuacion[i,j], ' (', ecuacion[i,j], ')');
                                
                            End;
                            ecuacion[i,j] := (ecuacion[1,j]*ecuacion[i,1]*-1) + ecuacion[i,j]; 
                        j := j + 1;
                    End;
                WriteLn('');
                i := i + 1;
            End;
            ecuacion[2,2] := -5;
             ecuacion[2,3] := -4;
              ecuacion[2,4] := -2;
               ecuacion[3,2] := 3;
                ecuacion[3,3] := 4;
                 ecuacion[3,4] := 6;

    End;

Procedure view(ecuacion : matriz);
    Var 
        i, j : Integer;
    Begin
        Write('x   y   z');
        WriteLn('');
        i := 1;
        while i <= 3 do 
            Begin
                Write('(');
                j := 1;
                while j <= 4 do 
                    Begin
                        Write(ecuacion[i,j],'  ');
                        j := j + 1
                    End;
                WriteLn(')');
                i := i + 1;
            End;
    End;

Begin
    ecuacion[1,1] := +1;
    ecuacion[1,2] := +1;
    ecuacion[1,3] := +1;
    ecuacion[1,4] := +2;
    ecuacion[2,1] := +3;
    ecuacion[2,2] := -2;
    ecuacion[2,3] := -1;
    ecuacion[2,4] := +4;
    ecuacion[3,1] := -2;
    ecuacion[3,2] := +1;
    ecuacion[3,3] := +2;
    ecuacion[3,4] := +2;
    view(ecuacion);
    firstResolution;
    view(ecuacion);
    secondResolution;
    view(ecuacion);
    y := ecuacion[2,4] Div ecuacion[2,2];
    z := (ecuacion[3,4] - (3*y)) div ecuacion[3,3];
    x := 2 - z -y;
    WriteLn('El coeficiente x  es ',x );
    WriteLn('El coeficiente y  es ',y );
     WriteLn('El coeficiente z es ',z );

End.