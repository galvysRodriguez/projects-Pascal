Program indirect;
const
    cien = 100;
Var 
    apreciacion, media, prom, phi, barra, error, porc : Real;
    arr: array[1..10] of Real;
    delta: array[1..10] of Real;
    i, cant : Integer;

Begin 
    WriteLn('apreciacion del instrumento');
    ReadLn(apreciacion);
    WriteLn('ingrese la cantidad de medidas');
    ReadLn(cant);
    i := 1;
    while i <= cant do
        Begin
            WriteLn('Ingrese el valor de la medida');
            ReadLn(arr[i]);
            i := i + 1;
        End;
    media := 0;
    for i:=10 downto 1 do
        Begin
            media := media + arr[i];
        End;
    media := media / cant;
    WriteLn('la media es',media:8:2,' lol');
    for i:= 1 to 10 do 
        Begin 
        delta[i] := arr[i] - media;
        WriteLn('desviacion aparente', delta[i]:8:2);
        End;
    prom := 0;
    for i:= 1 to 10 do 
        Begin 
        prom := prom + (Abs(delta[i])/cant);
        End;
    WriteLn('la desviacion media es', prom:8:2);
    i := 1;
    phi := 0;
    for i:=10 downto 1 do
        begin
            phi := phi + Sqr(abs(delta[i]));
        end; 
    barra := phi;
    phi := Sqrt(phi/(cant-i));
    WriteLn('la desviacion estandar es', phi:8:2);
    barra := Sqrt(barra/(cant * (cant - i)));
    WriteLn('error estandar es', barra:8:2);
    error := barra + apreciacion;
    WriteLn('error absoluto es',error:8:2);
    porc := (error / media) * cien;
    WriteLn('el error relativo porcentual es', porc:8:2);
End.