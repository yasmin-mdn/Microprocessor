#include <stdio.h> 
#include <dos.h>
int MiladiIsLeap(int miladiYear)
{
if(((miladiYear % 100)!= 0 && (miladiYear % 4) == 0) || ((miladiYear % 100)== 0 && (miladiYear % 400) == 0))
  return 1;
else
  return 0;
}
main(){
unsigned int year;
unsigned char month;
unsigned char day; 
unsigned int Solaryear;
unsigned char Solarmonth;
unsigned char Solarday;
int  dayCount,farvardinDayDiff,deyDayDiff ;
int  sumDayMiladiMonth[] = {0,31,59,90,120,151,181,212,243,273,304,334};
int  sumDayMiladiMonthLeap[]= {0,31,60,91,121,152,182,213,244,274,305,335};
union REGS regin,regout; 
regin.h.ah=0x2A;
int86(0x21,&regin,&regout);
day=regout.h.dl;
month=regout.h.dh;
year=regout.x.cx;

day=regout.h.dl; month=regout.h.dh;
year=regout.x.cx;
farvardinDayDiff=79;
if (MiladiIsLeap(year))
 {
    dayCount = sumDayMiladiMonthLeap[month-1] + day;
 }
else
 {
    dayCount = sumDayMiladiMonth[month-1] + day;
 }
if((MiladiIsLeap(year - 1)))
 {
    deyDayDiff = 11;
 }
else
 {
    deyDayDiff = 10;
 }
if (dayCount > farvardinDayDiff)
{
    dayCount = dayCount - farvardinDayDiff;
    if (dayCount <= 186)
     {
      switch (dayCount%31)
       {
    case 0:
     Solarmonth = dayCount / 31;
     Solarday = 31;
    break;
    default:
     Solarmonth = (dayCount / 31) + 1;
     Solarday = (dayCount%31);
    break;
      }
      Solaryear = year - 621;
     }
   else
     {
    dayCount = dayCount - 186;
    switch (dayCount%30)
    {
       case 0:
    Solarmonth = (dayCount / 30) + 6;
    Solarday = 30;
       break;
     default:
       Solarmonth = (dayCount / 30) + 7;
       Solarday = (dayCount%30);
       break;
     }
      Solaryear = year - 621;
    }
  }
else
  {
    dayCount = dayCount + deyDayDiff;

    switch (dayCount%30)
    {
    case 0 :
      Solarmonth = (dayCount / 30) + 9;
      Solarday = 30;
     break;
    default:
      Solarmonth = (dayCount / 30) + 10;
      Solarday = (dayCount%30);
     break;
    }
    Solaryear = year - 622;

  }
printf("Today's date is %d-%d-%d\n", Solaryear ,Solarmonth ,Solarday);
return 0;

}