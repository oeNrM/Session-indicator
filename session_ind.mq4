//+------------------------------------------------------------------+
//|                                                  session_ind.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "NEO"
#property link      "Neo.Reverser@gmail.com"
#property version   "1.00"
#property description "Neo.Reverser@gmail.com"
#property indicator_chart_window

#define GiveTime(t,k) StringToTime(TimeToString(iTime(NULL,PERIOD_D1,k),TIME_DATE)+" "+t)

#include <forall.mqh>

extern int Days = 1;
extern string Empty8       = "=============================";//SHOW
extern bool   SHOW_ASIA    = 1;
extern bool   SHOW_EUR     = 1;
extern bool   SHOW_USA     = 1;
extern string Empty5       = "=============================";//ASIA
extern string AsiaBegin    = "00:00";
extern string AsiaEnd      = "10:00";
extern string Empty1       = "=============================";//EUROPE
extern string EurBegin     = "10:00";
extern string EurEnd       = "18:00";
extern string Empty2       = "=============================";//USA
extern string USABegin     = "15:00";
extern string USAEnd       = "23:59";
extern string Empty3       = "=============================";//COLORS
extern color  AsiaColor    = C'138,42,226';
extern color  EurColor     = clrGray;
extern color  USAColor     = clrPeru;
extern string Empty6       = "=============================";//Style
extern ENUM_LINE_STYLE  AsiaStyle    = 0;
extern ENUM_LINE_STYLE  EuroStyle     = STYLE_DASHDOTDOT;
extern ENUM_LINE_STYLE  USAStyle     = STYLE_DASHDOT;

string objname = "FiboTimes";
string objectname;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
   {
    DeleteObject(objname);
    if(Period() <=  60)
       {
        double ph, pl, pc, po;
        for(int i = 0; i < Days; i++)
           {
            ph = iHigh(NULL, PERIOD_D1, i);
            pl = iLow(NULL, PERIOD_D1, i);
            po = iOpen(NULL, PERIOD_D1, i);
            pc = iClose(NULL, PERIOD_D1, i);
            //pmid = ND(ph - pl);
            //Asia
            if(SHOW_ASIA)
               {
                objectname = objname + (string)MathRand() + (string)MathRand();
                FiboTimesCreate(0, objectname, 0, GiveTime(AsiaBegin, i), pl, GiveTime(AsiaEnd, i));
                FiboTimesLevelsSet("ASIA - OPEN", "ASIA - CLOSE", AsiaColor, objectname, AsiaStyle);
               }
            //Europe
            if(SHOW_EUR)
               {
                objectname = objname + (string)MathRand() + (string)MathRand();
                FiboTimesCreate(0, objectname, 0, GiveTime(EurBegin, i), pc >= po ? pc : po, GiveTime(EurEnd, i));
                FiboTimesLevelsSet("Europe - OPEN", "Europe - CLOSE", EurColor, objectname, EuroStyle);
               }
            //USA
            if(SHOW_USA)
               {
                objectname = objname + (string)MathRand() + (string)MathRand();
                FiboTimesCreate(0, objectname, 0, GiveTime(USABegin, i), pc >= po ? pc : po, GiveTime(USAEnd, i));
                FiboTimesLevelsSet("USA - OPEN", "USA - CLOSE", USAColor, objectname, USAStyle);
               }
           }
       }
    return(INIT_SUCCEEDED);
   }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime& time[],
                const double& open[],
                const double& high[],
                const double& low[],
                const double& close[],
                const long& tick_volume[],
                const long& volume[],
                const int& spread[])
   {
    return(rates_total);
   }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
   {
    DeleteObject(objname);
   }
//+------------------------------------------------------------------+
