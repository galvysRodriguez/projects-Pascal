Program testQuickSort;

Type  
    vector = array[0..9] of integer;

Var
    i, j, aux, x : Integer;
    lista : vector;

Function input():vector;
    Begin
        i := 0;
        While i<Length(vector) do
          Begin
            WriteLn('Ingresa un numero entero');
            ReadLn(input[i]);
            i:= i +1;
          End;
        i:= 0;
        WriteLn('Los numeros ingresados fueron :');
        Write('[');
        While i<Length(vector) do
          Begin
            Write(input[i],'    ');
            i:= i +1;
          End;
        WriteLn(']');
    End;

Procedure view();
  Begin
      i:= 0;
      WriteLn('Los numeros ordenados son :');
      Write('[');
      While i<Length(vector) do
          Begin
            Write(lista[i],'    ');
            i:= i +1;
          End;
        WriteLn(']');
  End;

Procedure swap(a,b : Integer);
    Begin
        aux := lista[a];
        lista[a] := lista[b];
        lista[b] := aux;
    End;

Procedure sort(l,r: integer);
    begin
        i:=l; 
        j:=r; 
        x:=lista[(l+r) DIV 2];
        repeat
            while lista[i]<x do i:=i+1;
            while x<lista[j] do j:=j-1;
            if i<=j then
            begin
                swap(i,j);
                i:=i+1; 
                j:=j-1;
            end;
        until i>j;
        if l<j then sort(l,j);
        if i<r then sort(i,r);
    end;

Begin 
    lista := input();
    sort(0,Length(lista)-1);
    view();
End.