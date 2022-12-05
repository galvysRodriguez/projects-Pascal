Program sudoku;

Uses 
    Crt,
    Strings;

Type
    complet = array[1..9,1..9] of String;
    vector = array[1..9] of String;

//These texts allow us to indicate what value to enter
//n allows us to clean up code with fewer characters
Const 
    row = 'rows';
    column = 'colums';
    number = 'number';
    n = Length(vector);

//game will be the resolved matrix
//match is the matrix that the user sees during his match
Var 
    game, match : complet;
    menu, value, rowsString, columnsString, option, dismiss : string;
    flag, confirm, follow, dark, review : Boolean;
    numbers, clue, tools,azar: Integer;
    serie : vector;

Procedure change(rows, k : Integer);
    //receives the row and column position
    Var 
        a, b : Integer;
        temp : String;
    Begin
        a := k -2;
        b := a;
        //swap 3 items with each other
        while a <= k do 
            Begin
                temp := game[rows,b];
                game[rows, b] := game[rows, a];
                game[rows, a] := temp;
                a := a + 1;
            End;
    End;

Procedure exchange(rows : Integer);
    //receives in which row the change will be made
    Var 
        a, b : Integer;
        temp : String;
    Begin
        a := 1;
        b := 1;
        //move the first element to the end of the vector
        while a <= n do 
            Begin
                temp := game[rows,b];
                game[rows, b] := game[rows, a];
                game[rows, a] := temp;
                a := a + 1;
            End;
    End;

Procedure exchangeRow(rows2, rows1 : Integer);
    //swap the elements of one row with another
    Var 
        a : Integer;
        temp : String;
    Begin
        a := 1;
        while a <= n do 
            Begin
                temp := game[rows1,a];
                game[rows1, a] := game[rows2, a];
                game[rows2, a] := temp;
                a := a + 1;
            End;
    End;

Procedure exchangeColum(col1, col2 : Integer);
        //swap the elements of one column with another
        Var 
        a : Integer;
        temp : String;
    Begin
        a := 1;
        while a <= n do 
            Begin
                temp := game[a,col1];
                game[a, col1] := game[a, col2];
                game[a, col2] := temp;
                a := a + 1;
            End;
    End;

Procedure swapRow(block: Integer);
    //randomly generating row swapping
    Var 
        varied: Integer;
    Begin
        Randomize;
        varied := Random(3) + 1;
        exchangeRow(block,varied);
    End; 

Procedure swapColum(block: Integer);
    //randomly generating row swapping
    Var 
        varied: Integer;
    Begin
        Randomize;
        varied := Random(3) + 1;
        exchangeColum(block,varied);
    End;

Procedure push(i : Integer);
    //according to the rows it makes changes in them
    Begin
         if (i+1) Mod 3 = 0 then
                Begin
                    exchange(i);
                    exchange(i);
                    exchange(i);
                    exchange(i);
                    exchange(i);
                    exchange(i);
                        
                End
            else if i Mod 3 = 0 then
                Begin
                    exchange(i);
                    exchange(i);
                    exchange(i);
                End;
    End;

Procedure combinatory(i : Integer);
    Var 
        j, x : Integer;
    Begin
        //randomly divide the sequence from 1 to 9
        if i = 1 then 
            Begin
           x := numbers;
        while x <= n do 
                Begin
                    game[i,x]:= serie[x];
                    x := x + 1;
                End;
            j := 1;
            while j < numbers do
                Begin
                    game[i,j]:= serie[numbers-j];
                    j := j + 1;
                End;
            End 
            else
                //gives the value obtained in the first row to all the others
                Begin
                    j := 1;
                while j <= n do
                    Begin
                        game[i,j]:= game[i-1,j];
                        j := j + 1;
                    End;
                End;
            //separate the 3x3 blocks make a permutation between themselves
            if (i = 4) then
                Begin
                    change(i,3);
                    change(i,6);
                    change(i,9);
                End
            else if (i = 7) then 
                Begin
                    change(i,3);
                    change(i,6);
                    change(i,9);
                End;
    End;

Procedure color();
    //returns colors to default
    Begin
        if dark then 
            TextColor(White)
        else 
            TextColor(Black);
    End;

Function rowsValue(a,i,j :Integer) : Integer;
    //spin the sudoku and change the rows
    Begin
        //a := n + 1 - i;
        Case azar of
            0 : rowsValue := i;
            2 : rowsValue := a;
            else
                rowsValue := j;
            End;
    End;

Function columnValue(a,i,j : Integer) : Integer;
    ////spin the sudoku and change the columns
    Begin
        //a := n + 1 - i;
        Case azar of
            1 : columnValue := i;
            3 : columnValue := a;
            else
                columnValue := j;
            End;
    End;

Procedure startMatch(amount : Integer);
    //receives as parameters the number of clues to add
    Var 
        i, j, k, h, count : Integer;
    Begin
        //the values ​​of the resolved matrix are randomly given game to match
        Randomize;
        count := 0;
        repeat 
            i := 1;
            while i <= n do 
                Begin
                    h := Trunc(Random(9) + 1);
                    j := 1;
                    while j <= n do 
                        Begin
                            k := Trunc(Random(9) + 1);
                            if (count < amount) and ((k-h) = 1) and (match[i,j] = ' ') then
                                Begin
                                    match[i,j] := game[i,j];
                                    count := count + 1;
                                End;
                            j := j +1;
                        End;
                    i := i + 1;
                End;
        until count = amount;
    End;

Procedure generate(amount : Integer);
    Var 
        i : Integer;
    Begin
        i:= 1;
        //convert numeric values ​​to text for auxiliary vector
        while i < 10 do
            Begin
                Str(i,option);
                serie[i] := option;
                i := i +1;
            End;
        Randomize;
        numbers := Trunc(Random(9)+1);
        i:= 1;
        //match and push the elements all the sudoku
        while i <= n do
            Begin
                combinatory(i);
                i := i + 1;
            End;
        i:= 1;
        while i <= n do
            Begin
                push(i);
                i := i + 1;
            End;
        //swap rows and columns randomly
        Randomize;
        azar := Random(4);
        swapRow(1);
        swapRow(2);
        swapRow(3);
        swapColum(1);
        swapColum(2);
        swapColum(3);
        //start the game with the given number of clues
        startMatch(amount);
    End;


Procedure initial(amount : Integer);
    //fill arrays with spaces
    Var 
        i, j : Integer;
    Begin
         i := 1;
         clue := 3;
        while i <= Length(game) do
            Begin
                j := 1;
                while j<=Length(game) do 
                    Begin
                        game[i,j] := ' ';
                        match[i,j] := ' ';
                        j := j +1;
                    End;
                i := i +1;
            End;
          generate(amount);
    End; 

Procedure view(matrix : complet);
    //displays the matrix received as a parameter
    Var 
        i, j, count : Integer;
    Begin
        i := 1;
        count := 0;
        while i <= Length(matrix) do
            Begin
                if (i-1) Mod 3 = 0 then
                    Begin
                        //3x3 blocks
                        TextColor(Green);
                        WriteLn('________________________________________________________');
                    End;
                j := 1;
                    while j<=Length(matrix) do 
                        Begin
                            if (j-1) Mod 3 = 0 then 
                                Begin
                                    //3x3 blocks
                                    TextColor(Green);
                                    Write('|');
                                End;
                            TextColor(Blue);
                            Write('  ',matrix[i,j]);
                            color();
                            Write('  ');
                            if j Mod 3 <> 0 then 
                                Write('|');
                            j := j +1;
                            if matrix[i,j] <> ' ' then 
                                count := count + 1;
                        End;
                TextColor(Green);
                WriteLn('|');
                color();
                if i Mod 3 <> 0 then 
                    WriteLn('  ___   ___   ___   ___   ___   ___   ___   ___   ___ ');
                i := i +1;
            End;
        TextColor(Green);
        WriteLn('________________________________________________________');
        color();
        flag := count = 81;
    End;

Function input(name : String; x,y : Integer): String;
    //the name will indicate what data the user will enter
    Var 
        i : Integer;
    Begin
        repeat
            gotoxy(x,y);
            WriteLn('Enter a ',name,' of 1 to 9');
            i := 1;
            TextColor(Blue);
            repeat 
                Write(i,' ');
                i := i + 1;
            until i > n;
            color();
            WriteLn('           ');
            confirm := True;
            //take the valid values
            ReadLn(option);
                case option of 
                    '1' : input := option;
                    '2' : input := option;
                    '3' : input := option;
                    '4' : input := option;
                    '5' : input := option;
                    '6' : input := option;
                    '7' : input := option;
                    '8' : input := option;
                    '9' : input := option;
                    else
                        gotoxy(x,y);
                        WriteLn('Invalid operation           ');
                        WriteLn('Press a key to continue');
                        Readkey;
                        confirm:= False;
                End;
        until confirm;
    End;

Function toInt (text : String):Integer;
    Var 
        receive : Real;
    Begin
        Val(text, receive);
        (*convert real receive value to integer*)
        toInt := trunc(receive);
    End;

Procedure alert;
    //action message invalidates the user
    Begin
        WriteLn('Invalid operation');
        WriteLn('Please, select a valid operation');
        WriteLn('Press a key to continue');
        Readkey;
    End;

Procedure introduce();
    Var 
        i, j: Integer;
    Begin
        //asks for all the data for the user to enter values
        rowsString := input(row, 1, 28);
        columnsString := input(column,1,31);
        i := toInt(rowsString);
        j := toInt(columnsString);
        value := input(number,1,34);
        //check that the value is valid
        if (match[i,j] =  ' ') and (game[i,j] = value) then
            match[i,j] := value
        else
            alert;
    End;

Procedure mode();
    //to show light and dark theme
    Begin
        if dark then 
            Begin 
                TextBackground(White);
                TextColor(Black);
                dark := False;
            End 
        else 
            Begin
                TextBackground(Black);
                TextColor(White);
                dark := True;
            End 
    End;

Procedure wildcar();
    //enter a new clue to sudoku
    Begin
        if clue > 0 then
            Begin
                startMatch(1);
                clue := clue - 1;
            End
        else
            Begin 
                WriteLn('I am sorry, you have no more clues');
                WriteLn('Press a key to continue');
                Readkey;
            End;
        Clrscr;
    End;

Function difficulty(): Integer;
    Begin
        //difficulty selection menu
        repeat
            Clrscr;
            GotoXy(10, 10);
            WriteLn('************************** WELCOME ***************************');
            GotoXy(10,15);
            WriteLn('Sudoku');
            WriteLn('Choose the level of difficulty');
            WriteLn('1 : Easy');
            WriteLn('2 : Intermediate ');
            WriteLn('3 : Hard ');
            flag := True;
            ReadLn(menu);
            Case menu of 
                '1' : difficulty :=  30;
                '2' : difficulty := 22;
                '3' : difficulty := 17;
                else
                    flag := False;
                    alert;
            End;
        until flag;
    End;

Procedure show();
    //user item menu
    Begin
        repeat
            Clrscr;
            GotoXy(10, 2);
            WriteLn('************************** WELCOME ***************************');
            GotoXy(10,4);
            WriteLn('Sudoku');
            view(match);
            WriteLn('1 : Enter a number');
            WriteLn('2 : Wildcar ',clue,'/3');
            WriteLn('3 : Change mode dark/light');
            WriteLn('4 : Surrender ');
            flag := False;
            ReadLn(menu);
            Case menu of 
                '1' : introduce();
                '2' : wildcar();
                '3' : mode();
                '4' : flag := True;
                else
                    alert;
            End;
        until flag;
    End;

//program body
Begin
  repeat
    dark := True;
    tools := difficulty();
    initial(tools);
    show();
        repeat
            //sudokyu solution menu and allows you to play again
            Clrscr;
            GotoXy(15, 4);
            WriteLn('************************** WELCOME ***************************');
            GotoXy(20,6);
            WriteLn('Sudoku');
            WriteLn('Solution');
            view(game);
            WriteLn('1 : Play again');
            WriteLn('2 : Leave');
            review := True;
            follow := False;
            ReadLn(dismiss);
            Case dismiss of 
                '1' : WriteLn('BYE');
                '2' : follow := True;
                else
                    review := False;
                    alert;
            End;
        until review;
  until follow;
End.