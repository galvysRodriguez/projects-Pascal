Program unifyProjectG;

Uses 
    crt;
(*Const: string values to be used to concatenate outputs*)
Const
    int = 'integer';
    float = 'real';
    fiboText = 'Fibonacci';
    colorText = 'Number color';
    maxAndMinText = 'Highest and lowest value';
    powerText = 'Power number';
(*Global variables: about menu and data verification *)
Var 
    menu, inputUser : String;
    flag : Boolean;
    valid : Integer;
    receive : Real;

Function find (text : string):Boolean;
    (*it help us to know if the user's string has a period*)
    Const 
        point = '.';
    Var
        i : Integer;
    Begin
        i:=length(text);
        find := true;
        while (i>=1) and (find) do
            Begin
                if text[i] = point then find := False;
                i := i -1;
            End; 
    End;

Function inputFloat(name :string):Real;
    (*request and validates the real type data*)
     Begin
        WriteLn('Welcome to ', name);
        repeat
            WriteLn('Please, enter a number ',float,' to ', name,':');
            ReadLn(inputUser);
            (*the string inputUser passes it's characters to real receive *)
            (*the valid passes verifies that it has been successful*)
            Val(inputUser, receive, valid);
        until valid = 0;
        inputFloat := receive;
    End;

Function inputInt(name : String): Integer;
    (*request and validates the integer type data*)
    Begin
        WriteLn('Welcome to ', name);
        repeat
            WriteLn('Please, enter a number ',int,' to ', name,':');
            ReadLn(inputUser);
            (*the string inputUser passes it's characters to real receive *)
            (*the valid verifies that it has been successful*)
            Val(inputUser, receive, valid)
            (*check that is not greater number it is not a decimal*)
        until (valid = 0) and (Abs(receive) <= 32767) and (find(inputUser));
        (*convert real receive value to integer*)
        inputInt := trunc(receive);
    End;

Procedure fibonacci;
    Var 
        numberUser, first, second, value : Integer;
    Begin
        (*receives an integer entered by the user*)
        numberUser := inputInt(fiboText);
        (*first that will be the fisrt the value of the fibonacci series*)
        first := 0;
        (*second that will be the second the value of the fibonacci series*)
        second := 1;
        (*value is the sum of the previous two values of the fibonacci series*)
        value := 0;
    while value <= numberUser do
        Begin
            WriteLn(fiboText, ': ',value);
            value := first + second;
            second := first;
            first := value;
        End;
    if second = numberUser then
        WriteLn('the ',numberUser, ' if it belong to the series ',fiboText)
    else 
        WriteLn('the ',numberUser,  ' does not belong to the series ',fiboText)
    End;

Procedure color;
    Var 
        numberColor : Integer;
    Begin
        (*receives an integer entered by the user*)
        numberColor := inputInt(colorText);
        (*validates si numberColor is is divisible by the indicated number to assign a color*)
        if numberColor Mod 13 = 0 then TextColor(Brown)
        else if numberColor Mod 7 = 0 then TextColor(Green)
        else if numberColor Mod 5 = 0 then TextColor(Red)
        else if numberColor Mod 3 = 0 then TextColor(Blue)
        else if numberColor Mod 2 = 0 then TextColor(Yellow) 
        else TextColor(White);
        WriteLn(numberColor);
    End;

Procedure output(max, min : Real);
    Begin
        WriteLn('The hightest value is ',max:8:2);
        WriteLn('The lowest value is ',min:8:2);
    End;
Procedure maxAndMin;
Var 
    one, two, three, four : Real; 
Begin
    (*receives real numbers entered by the user*)
    one := inputFloat(maxAndMinText);
    two := inputFloat(maxAndMinText);
    three := inputFloat(maxAndMinText);
    four := inputFloat(maxAndMinText);
    (*verification of maximums and minimums*)
    if one > two then
        if one > three then
            if one > four then
                if three > four then
                    if four > two then output(one, two)
                    else output(one, four)
                else if three > two then output(one, two)
                else output(one, three)
            else if three > two then output(four, two)
            else output(four, three)
        else if three > four then
            if two > four then output(three, four)
            else output(three, two)
        else output(four, two)
    else if two > three then
        if two > four then
            if three > one then
                if one > four then output(two, four)
                else output(two, one)
            else if three > four then output(two, four)
            else output(two, three)
        else if one > three then output(four, three)
        else output(four, one)
    else if three > four then
        if one > four then output(three, four)
        else output(three, one)
    else output(four, one)
End;

Procedure testPower(multiple, numberPower : Integer);
    Var 
        count, i, sequence, numberUser: Integer;
    Begin

        count := 0;
        numberUser := numberPower;
        While numberPower Mod multiple = 0 do 
            Begin
                numberPower := numberPower Div multiple;
                count := count + 1;
            End;
        (*it is only a multiple of the indicated number*)
        if numberPower = 1 then
            Begin
                WriteLn('the ',numberUser, ' is power of ',multiple);
                sequence := multiple;
                (*shows the user the sequence of numbers that are powers*)
                for i:=0 to count-1 do
                    Begin
                        WriteLn(sequence);
                        sequence := sequence * multiple;
                    End;
            End
        else  
            WriteLn('the ',numberPower, ' is not a power of 2, 3 or 5')
    End;

Procedure power;
    Var
        numberPower:Integer;
    Begin
        (*receives an integer entered by the user*)
        numberPower := inputInt(powerText);
        (*value verification is possible*)
        if numberPower > 1 then
            Begin
                if numberPower Mod 2 = 0 then testPower(2,numberPower)
                else if numberPower Mod 3 = 0 then testPower(3,numberPower)
                else if numberPower Mod 5 = 0 then testPower(5,numberPower)
                else WriteLn('the ',numberPower, ' is not a power of 2, 3 or 5')
            End
        else 
            WriteLn('the ',numberPower, ' is not a power of 2, 3 or 5')
    End;

(*program body*)
Begin
    WriteLn('************** Welcome ********************');
    WriteLn('Select the operation you want');
    repeat
        (*menu*)
        WriteLn('1: ',fiboText);
        WriteLn('2: ',colorText);
        WriteLn('3: ',maxAndMinText);
        WriteLn('4: ',powerText);
        Readln(menu);
        flag := True;
        case menu of
            '1' : fibonacci;
            '2' : color;
            '3' : maxAndMin;
            '4' : power;
            else
                WriteLn('Invalid operation');
                WriteLn('Please, select a valid operation');
                flag := False;
        End;
    until flag;
End.