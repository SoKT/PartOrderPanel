#property copyright "Copyright 2016, 05 November"
#property link      "Teemofey@inbox.ru"
#property version   "1.2"
//#property indicator_chart_window
#property indicator_separate_window
#include "PartOrderDialog.mqh"
PartOrderDialog ExtDialog; 

int OnInit(void) 
  {
   if(!ExtDialog.Create(0,"RU",
                        0,50,50,390,200))
     return(INIT_FAILED);
   if(!ExtDialog.Run())
     return(INIT_FAILED);
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {ExtDialog.Destroy(reason);}
  
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const int begin,
                const double &price[])
  {return(rates_total);}

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {ExtDialog.ChartEvent(id,lparam,dparam,sparam);}