unit fCalcAge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    DateTimePicker1: TDateTimePicker;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  AwSysUtils,
  DateUtils;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  age: tage;
  i: word;
  d: tdatetime;
begin
  d := DateTimePicker1.Date;
  for i := 0 to 365 do
  begin
    d := incday(d, 1);
    age := CalculateAge(d, Date);
    Memo1.Lines.Add(format('dob = %s  year=%d month=%d day=%d',
      [formatdatetime('dd/mm/yyyy', d), age.AYear, age.AMonth, age.ADay]));
  end;
end;

end.
