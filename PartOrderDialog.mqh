//+------------------------------------------------------------------+
//|                                              PartOrderDialog.mqh |
//|                                      Copyright 2016, 05 November |
//|                                                Teemofey@inbox.ru |
//+------------------------------------------------------------------+
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Edit.mqh>
#include <Controls\ListView.mqh>
#include <Controls\ComboBox.mqh>
#include <Controls\SpinEdit.mqh>
#include <Controls\RadioGroup.mqh>
#include <Controls\CheckGroup.mqh>
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (10)      // gap by X coordinate
#define CONTROLS_GAP_Y                      (8)      // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
#define LIST_WIGDHT                         (7)      // size by X coordinate
#define BOX_WIDTH                           (70)      // size by X coordinate
//+------------------------------------------------------------------+
//| Class PartOrderDialog                                               |
//| Usage: main dialog of the SimplePanel application                |
//+------------------------------------------------------------------+
class PartOrderDialog : public CAppDialog
  {
private:
   CEdit             m_edit;                          // the display field object
   CEdit             m_static_edit[6];                          // the display field object
   CButton           m_button[4];                       // the button object
   CListView         m_list_view;                     // the list object
   CComboBox         m_combo_box;                     // the dropdown list object
   CComboBox         m_combo_box2;                     // the dropdown list object
   CRadioGroup       m_radio_group;                   // the radio buttons group object
   CCheckGroup       m_check_group;                   // the check box group object

public:
                     PartOrderDialog(void);
                    ~PartOrderDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateEdit(void);
   bool              CreateButtons(void);
   bool              CreateComboBox(void);
   bool              CreateRadioGroup(void);
   bool              CreateCheckGroup(void);
   bool              CreateListView(void);
   //--- internal event handlers
   virtual bool      OnResize(void);
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
   void              OnClickButton2(void);
   void              OnClickButton3(void);
   void              OnClickButton4(void);
   void              OnChangeComboBox(void);
   void              OnChangeRadioGroup(void);
   void              OnChangeCheckGroup(void);
   void              OnChangeListView(void);
   bool              OnDefault(const int id,const long &lparam,const double &dparam,const string &sparam);
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(PartOrderDialog)
ON_EVENT(ON_CLICK,m_button[0],OnClickButton1)
ON_EVENT(ON_CLICK,m_button[1],OnClickButton2)
ON_EVENT(ON_CLICK,m_button[2],OnClickButton3)
ON_EVENT(ON_CLICK,m_button[3],OnClickButton4)
ON_EVENT(ON_CHANGE,m_radio_group,OnChangeRadioGroup)
ON_EVENT(ON_CHANGE,m_check_group,OnChangeCheckGroup)
ON_EVENT(ON_CHANGE,m_combo_box,OnChangeComboBox)
ON_EVENT(ON_CHANGE,m_list_view,OnChangeListView)
ON_OTHER_EVENTS(OnDefault)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
PartOrderDialog::PartOrderDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
PartOrderDialog::~PartOrderDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool PartOrderDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
   if(!CreateEdit())
      return(false);
   if(!CreateButtons())
      return(false);
   if(!CreateRadioGroup())
      return(false);
   if(!CreateCheckGroup())
      return(false);
   if(!CreateComboBox())
      return(false);
   if(!CreateListView())
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the display field                                         |
//+------------------------------------------------------------------+
bool PartOrderDialog::CreateEdit(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(BUTTON_HEIGHT+CONTROLS_GAP_Y)*3;
   int x2=ClientAreaWidth()-(INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X);
   int y2=y1+EDIT_HEIGHT;
//--- create
   Print("m_name+Edit=",m_name+"Edit");
   if(!m_edit.Create(m_chart_id,m_name+"Edit",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit.ReadOnly(false))
      return(false);
   if(!Add(m_edit))
      return(false);
   m_edit.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
//--- succeed
//m_static_edit.Create(m_chart_id,m_name+"Edit",m_subwin,x1,y1,x2,y2);

   
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool PartOrderDialog::CreateButtons(void)
   {
   string button_text[]={"Settings","Delete","Add","List view"};
      for(int i=0; i<=3; i++)
      {
         int x1=ClientAreaWidth()-(INDENT_RIGHT+BUTTON_WIDTH);
         int y1=INDENT_TOP+(BUTTON_HEIGHT+CONTROLS_GAP_Y)*i;
         int x2=x1+BUTTON_WIDTH;
         int y2=y1+BUTTON_HEIGHT;
         m_button[i].Create(m_chart_id,m_name+"Button"+i,m_subwin,x1,y1,x2,y2);
         m_button[i].Text(button_text[i]);
         Add(m_button[i]);
         m_button[i].Alignment(WND_ALIGN_RIGHT,0,0,INDENT_RIGHT,0);
      }
   m_button[3].Visible(false);
   return(true);
  }
  bool PartOrderDialog::CreateRadioGroup(void)
  {
  /*
   int sx=(ClientAreaWidth()-(INDENT_LEFT+INDENT_RIGHT+BUTTON_WIDTH))/3-CONTROLS_GAP_X;
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+EDIT_HEIGHT+CONTROLS_GAP_Y;
   int x2=x1+sx;
   int y2=ClientAreaHeight()-INDENT_BOTTOM;
//--- create
   if(!m_radio_group.Create(m_chart_id,m_name+"RadioGroup",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_radio_group))
      return(false);
   m_radio_group.Alignment(WND_ALIGN_HEIGHT,0,y1,0,INDENT_BOTTOM);
//--- fill out with strings
   for(int i=0;i<4;i++)
      if(!m_radio_group.AddItem("Item "+IntegerToString(i),1<<i))
         return(false);
//--- succeed
*/
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "CheckGroup" element                                  |
//+------------------------------------------------------------------+
bool PartOrderDialog::CreateCheckGroup(void)
  {
  /*
   int sx=(ClientAreaWidth()-(INDENT_LEFT+INDENT_RIGHT+BUTTON_WIDTH))/3-CONTROLS_GAP_X;
//--- coordinates
   int x1=INDENT_LEFT+sx+CONTROLS_GAP_X;
   int y1=INDENT_TOP+EDIT_HEIGHT+CONTROLS_GAP_Y;
   int x2=x1+sx;
   int y2=ClientAreaHeight()-INDENT_BOTTOM;
//--- create
   if(!m_check_group.Create(m_chart_id,m_name+"CheckGroup",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_check_group))
      return(false);
   m_check_group.Alignment(WND_ALIGN_HEIGHT,0,y1,0,INDENT_BOTTOM);
//--- fill out with strings
   for(int i=0;i<4;i++)
      if(!m_check_group.AddItem("Item "+IntegerToString(i),1<<i))
         return(false);
//--- succeed
*/
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "ListView" element                                    |
//+------------------------------------------------------------------+
bool PartOrderDialog::CreateListView(void)
  {
  string Type_Order;
   int sx=(ClientAreaWidth()-(INDENT_LEFT+INDENT_RIGHT+BUTTON_WIDTH))/3-CONTROLS_GAP_X;
//--- coordinates
   int x1=INDENT_LEFT;
//   int y1=INDENT_TOP+EDIT_HEIGHT+CONTROLS_GAP_Y;
   int y1=INDENT_TOP;
   int x2=ClientAreaWidth()-(sx+INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X)+sx;
   int y2=ClientAreaHeight()-(BUTTON_HEIGHT+INDENT_BOTTOM+CONTROLS_GAP_Y);
//--- create
   if(!m_list_view.Create(m_chart_id,m_name+"ListView",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_list_view))
      return(false);
   m_list_view.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
//--- fill out with strings
   for(int i=0; i<=OrdersTotal()-1; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
//         if(!m_list_view.ItemAdd("______________"+(string)OrderTicket()+" "+OrderSymbol()+" Item "+IntegerToString(i)+"No :"))
   if (OrderType()==1)
      Type_Order="SELL";
   else  Type_Order="BUY ";
         if(!m_list_view.ItemAdd(OrderSymbol()+" Item"+IntegerToString(i)+":20  :50  :No :No :"+Type_Order+":1.5    "))
              return(false);
     }

//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool PartOrderDialog::CreateComboBox(void)
  {

//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP;//+(EDIT_HEIGHT+CONTROLS_GAP_Y);
          //+(BUTTON_HEIGHT+CONTROLS_GAP_Y);
          //+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BOX_WIDTH;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_combo_box.Create(m_chart_id,m_name+"ComboBox",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_combo_box))
      return(false);
//--- fill out with strings
 /*  for(int i=0;i<=OrdersTotal()-1;i++)
      if(!m_combo_box.ItemAdd(m_list_view.Select(i)))
         return(false);
         */
         m_combo_box.ItemAdd("Yes");

         m_combo_box.ItemAdd("No ");


m_combo_box.SelectByText("Yes");
   return(true);
  }
//+------------------------------------------------------------------+
//| Handler of resizing                                              |
//+------------------------------------------------------------------+
bool PartOrderDialog::OnResize(void)
  {

//--- call method of parent class
   if(!CAppDialog::OnResize()) return(false);
//--- coordinates
/*
   int x=ClientAreaLeft()+INDENT_LEFT;
   int y=m_list_view.Top();
   int sx=(ClientAreaWidth()-(INDENT_LEFT+INDENT_RIGHT+BUTTON_WIDTH))-CONTROLS_GAP_X;
//--- move and resize the "RadioGroup" element
//  m_radio_group.Move(x,y);
// m_radio_group.Width(sx);
//--- move and resize the "CheckGroup" element
   x=ClientAreaLeft()+INDENT_LEFT+sx+CONTROLS_GAP_X;
//  m_check_group.Move(x,y);
// m_check_group.Width(sx);
//--- move and resize the "ListView" element
//  x=ClientAreaLeft()+ClientAreaWidth()-(sx+INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X);
   x=ClientAreaLeft()+INDENT_LEFT;
   m_list_view.Move(x,y);
   if(m_list_view.Width()!=LIST_WIGDHT && m_list_view.Width()!=sx)
      m_list_view.Width(sx);
//--- succeed
*/
   return(true);

  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void PartOrderDialog::OnClickButton1(void)
  {
      if(m_list_view.Select()=="")
         m_edit.Text("Please select something");
      else
      {      
m_combo_box.SelectByText(StringSubstr(m_list_view.Select(),23,3));
//m_combo_box.SelectByText("No ");
         m_button[0].Visible(false);
         m_button[1].Visible(false);
         m_button[2].Visible(false);
         m_button[3].Visible(true);
         m_list_view.Visible(false);
      }
//         m_edit.Text(PartOrderDialog.Top());

//   m_edit.Text(__FUNCTION__);
//while (m_list_view.Width()<800)
/*    for (int i=0; i<=m_list_view.Width(); i++) 
      {
     Print(m_list_view.Width());
       m_list_view.Width(m_list_view.Width()-1);
      }*/
//         m_list_view.Width(NULL); 

//   Print(m_list_view.Width()-1);

//m_list_view.Width(m_list_view.Width()/2);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void PartOrderDialog::OnClickButton2(void)
   {
   if(m_list_view.Select()=="")
      m_edit.Text("Please select something");
   else
      {
      m_list_view.ItemDelete(m_list_view.Current());








    //  bool select1=false;
   //      color  text_color=(select1) ? CONTROLS_LISTITEM_COLOR_TEXT_SEL : CONTROLS_LISTITEM_COLOR_TEXT;
  // color  back_color=(select1) ? CONTROLS_LISTITEM_COLOR_BG_SEL : CONTROLS_LISTITEM_COLOR_BG;
  //             m_list_view.ItemsClear();
  //             m_list_view.Select()
    //              EventChartCustom(-1,4,m_id,0.0,m_name);
               
    //     m_list_view.Visible(false);
     //    m_list_view.Visible(true);
//      m_list_view.Select(3);
      }     
//  m_edit.Text(__FUNCTION__);
//   int sx=(ClientAreaWidth()-(INDENT_LEFT+INDENT_RIGHT+BUTTON_WIDTH))-CONTROLS_GAP_X;
//   int i=0;
/*while (m_list_view.Width()<800)
 //     for (int i=0; i<=sx; i++) 
      {
         Print(i);
         Sleep(1000);       
         m_list_view.Width();   
         i++;     
      }
      if(m_list_view.Width()>0)
      { m_list_view.Width(m_list_view.Width()-1);}
      */
//        m_list_view.Width(sx);
//        m_list_view.Height(LIST_WIGDHT); 
//   m_list_view.Visible(true);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void PartOrderDialog::OnClickButton3(void)
  {
 // m_list_view.Select();
     m_edit.Text(StringSubstr(m_list_view.Select(),23,3));
 /*  if(m_button3.Pressed())
      m_edit.Text(__FUNCTION__+"On");
   else
      m_edit.Text(__FUNCTION__+"Off");*/
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void PartOrderDialog::OnClickButton4(void)
  {
   m_edit.Text(StringSubstr(m_edit.Text(),0,4));
//Print(CharToStr(m_edit.Text()[0]));
// m_edit.Text(__FUNCTION__);
//m_combo_box.Width(m_combo_box.Width()*2);
         m_button[0].Visible(true);
         m_button[1].Visible(true);
         m_button[2].Visible(true);
         m_button[3].Visible(false);
     m_list_view.Visible(true);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void PartOrderDialog::OnChangeListView(void)
  {
   m_edit.Text("Flag"+__FUNCTION__+" \""+m_list_view.Select()+"\"");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void PartOrderDialog::OnChangeComboBox(void)
  {
//  m_edit.Text(__FUNCTION__+" \""+m_combo_box.Select()+"\"");
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Rest events handler                                              |
//+------------------------------------------------------------------+
void PartOrderDialog::OnChangeRadioGroup(void)
  {
   m_edit.Text(__FUNCTION__+" : Value="+IntegerToString(m_radio_group.Value()));
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void PartOrderDialog::OnChangeCheckGroup(void)
  {
   m_edit.Text(__FUNCTION__+" : Value="+IntegerToString(m_check_group.Value()));
  }
bool PartOrderDialog::OnDefault(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- restore buttons' states after mouse move'n'click
// if(id==CHARTEVENT_CLICK)
//  m_radio_group.RedrawButtonStates();
//--- let's handle event by parent
   return(false);
  }
//+------------------------------------------------------------------+
