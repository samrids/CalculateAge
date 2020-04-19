unit AwSysUtils;

interface

uses
  SysUtils, DateUtils;

type
  TAge = record
    AYear, AMonth, ADay, AWeeks, AllDays: word;
    ATimeDiff: TDateTime; // TimeOnly
  end;

  PAge = ^TAge;

function CalculateAge(const DateOfBirth: TDateTime;
  const CheckDate: TDateTime): TAge;

implementation

function CalculateAge(const DateOfBirth: TDateTime;
  const CheckDate: TDateTime): TAge;
var
  NEWDOB, DOB, date2CalDay, date2CalMonth: TDate;
  CurrYear, CurrMonth, CurrDay: word;
  DOBYear, DOBMonth, DOBDay, MONTHDIFF: word;
  y, m, d: word;
  y2, m2, d2: word;
begin
  DOB := DateOfBirth;
  if DOB > CheckDate then
  begin
    Result.AYear := 0;
    Result.AMonth := 0;
    Result.ADay := 0;
    Result.AllDays := 0;
    Exit;
  end;
  Result.AYear := YearsBetween(DOB, CheckDate);
  Result.AllDays := DaysBetween(DateOfBirth, CheckDate);
  date2CalMonth := IncYear(DOB, Result.AYear);

  decodedate(CheckDate, CurrYear, CurrMonth, CurrDay);
  decodedate(DOB, DOBYear, DOBMonth, DOBDay);

  Result.AMonth := MonthsBetween(date2CalMonth, CheckDate);

  if ((DOBMonth = CurrMonth) and (DOBDay >= CurrDay)) then
  begin
    date2CalDay := encodedate(CurrYear, DOBMonth, DOBDay);
    if date2CalDay > CheckDate then
    begin
      NEWDOB := IncYear(DOB, Result.AYear);
      MONTHDIFF := MonthsBetween(NEWDOB, CheckDate);
      date2CalDay := IncMonth(NEWDOB, MONTHDIFF);
    end;
    Result.ADay := DaysBetween(date2CalDay, CheckDate);
  end
  else
  begin
    if ((CurrMonth < DOBMonth) and (Abs(DOBMonth - CurrMonth) = 1) and
      (CurrDay > DOBDay)) then
      date2CalDay := encodedate(CurrYear, DOBMonth, DOBDay)
    else
    begin
      NEWDOB := IncYear(DOB, Result.AYear);
      MONTHDIFF := MonthsBetween(NEWDOB, CheckDate);
      date2CalDay := IncMonth(NEWDOB, MONTHDIFF);
    end;
    if date2CalDay > CheckDate then
    begin
      date2CalDay := IncMonth(date2CalDay, -1);
      DecodeDate(date2CalDay, y, m, d);
      DecodeDate(CheckDate, y2, m2, d2);
      if (d - d2) = 1 then
        Dec(Result.AMonth);
    end;
    Result.ADay := DaysBetween(date2CalDay, CheckDate);
    if Result.ADay = 31 then
    begin
      Result.ADay := 0;
      Inc(Result.AMonth);
      if Result.AMonth = 12 then
      begin
        Result.AMonth := 0;
        Inc(Result.AYear);
      end;
    end;
  end;
end;

end.
