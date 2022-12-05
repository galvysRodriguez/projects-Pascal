Program fusion;

Type 
    p = array[1..6] of Integer;
    q = array[1..4] of Integer;
    pq = array[1..10] of Integer;

Const 
    max = 80;

Var 
    a : p;
    b : q;
    ab : pq;

Procedure generarNumeros;
    Var 
        i,j : Integer;
    Begin
        i := 1;
        WriteLn('Generando numeros...');
        while i <= Length(a) do 
            Begin
                j := 1;
                while j <= Length(b) do 
                    Begin
                        Randomize;
                        b[i] :=  random(max) + i + j+9;
                        j := j +1;
                    End;
                Randomize;
                a[i] := random(max-2) + i + 2;
                i := i + 1;
            End;
    End;

Procedure view;
    Var 
        i,j : Integer;
    Begin
        i := 1;
        WriteLn('Los numeros de a son ...');
        while i <= Length(a) do 
            Begin
                Write(a[i],'    ');
                ab[i] := a[i];
                i := i +1;
            End;
        WriteLn('');
        WriteLn('Los numeros son de b...');
        j := 1;
        while i <= (Length(b) + Length(a))do 
            Begin
                Write(b[j],'    ');
                ab[i] := b[j];
                i := i + 1;
                j := j + 1;
            End;
        WriteLn('');
        WriteLn('Los numeros fusionados son ');
        i := 1;
        while i <= (Length(b) + Length(a))do 
            Begin
                Write(ab[i],'    ');
                i := i + 1;
            End;
              
    End;
procedure orden;
    Var 
        i : Integer;
    Begin
        WriteLn('Los numeros ordenados son ');
         i := 1;
        while i <= (Length(b) + Length(a))do 
            Begin
                Write(ab[i],'    ');
                i := i + 1;
            End;
    End;
Procedure burble;
    Var 
        i, j, temp : Integer;
    Begin
        WriteLn('');
        i := 1;
        while i < Length(ab) do 
            Begin
                j := 1;
                while j < Length(ab)  do 
                    Begin
                        if ab[j] > ab[j+1] then 
                            Begin
                                temp := ab[j];
                                ab[j] := ab[j+1];
                                ab[j+1] := temp;
                            End;
                        j := j +1;
                    End;
                i := i +1;
            End;

    End;
Begin
    Randomize;
    generarNumeros;
    view;
    burble;
    orden;

End.