<!--*@$%**********************************************************************
 * 
 * Copyright (c) 2001 Universal EC, Inc. All Rights Reserved. 
 * 
 * This SOURCE CODE FILE, which has been provided by UEC as part 
 * of a UEC product for use ONLY by licensed users of the product, 
 * includes CONFIDENTIAL and PROPRIETARY information of UEC. 
 * 
 * USE OF THIS SOFTWARE IS GOVERNED BY THE TERMS AND CONDITIONS 
 * OF THE LICENSE STATEMENT AND LIMITED WARRANTY FURNISHED WITH 
 * THE PRODUCT. 
 * 
 * IN PARTICULAR, YOU WILL INDEMNIFY AND HOLD UEC, ITS RELATED 
 * COMPANIES AND ITS SUPPLIERS, HARMLESS FROM AND AGAINST ANY CLAIMS 
 * OR LIABILITIES ARISING OUT OF THE USE, REPRODUCTION, OR DISTRIBUTION 
 * OF YOUR PROGRAMS, INCLUDING ANY CLAIMS OR LIABILITIES ARISING OUT OF 
 * OR RESULTING FROM THE USE, MODIFICATION, OR DISTRIBUTION OF PROGRAMS 
 * OR FILES CREATED FROM, BASED ON, AND/OR DERIVED FROM THIS SOURCE 
 * CODE FILE. 
 *
 *
 *     File name:       calendar.jsp
 *
 *     History:
 *     Date                        Comments
 *     -----------------------------------------------------------------------
 * @chg 15Nov2002      TICE- 000298-ADM-Upgrade JSP Code To JDK 1.4
 *     21Jun2002       Initial Release
 *       08Jul2002       BUG FIX TICE-000062
 *****************************************************************************
-->
<%@ page contentType = "text/html; charset=Big5"%>
<%

/*****************************************************************************
 * Title:        calendar<p>
 * Description:  行事曆設定<p>
 * Copyright:    Copyright (c) 2002 Universal EC Inc. All Rights Reserved<p>
 * Company:      Universal EC Inc.<p>
 * @author:      Wenny
 * @version:     tice1.0
*******************************************************************************/
   response.setHeader("Pragma","No-Cache"); 
   response.setDateHeader("Expires",-1); 
   response.setHeader("Cache-Control","no-Cache"); 
    session.putValue("ID","calendar");
    session.putValue("DESCRIPTIO","行事曆設定");
%>
<%@ include file="common.jsp" %>
<%@ include file="adm_auth.jsp" %>

<% 
Public pp = new Public();
//======================================================
//變數宣告
String THIS_PAGE = request.getParameter("THIS_PAGE");     //目前頁數
THIS_PAGE = (THIS_PAGE == null ? "1" : THIS_PAGE.trim());

int intCount    = 0;                //ResultSet 的資料全部筆數
int intCount2    = 0;                //ResultSet 的資料全部筆數

//=======================================================
//切換頁數相關的變數宣告
int PAGE_SIZE= 10;                //每頁的筆數
int intAbsolute = 0 ;            //ResultSet 資料的絕對位址
int TOT_COUNT  = 0;                //ResultSet 的資料全部筆數
int REC_COUNT  = 0;                //該頁要印出的筆數
int TOT_PAGES    = 0;                //全部的頁數
boolean ENABLE_NEXT = false;    //是否要出現 "下一頁"
boolean ENABLE_PREV = false;    //是否要出現 "上一頁"

//===============================================
//資料庫相關的宣告
Connection conn = db.getPooledConnection().getConnection();
java.sql.Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String strSQL;
ResultSet rs;
//===============================================
String YYYY="";
String MM="";
String today="";
String fdctoday="";
String start_mon="";
String SH="";
int intToday=0;
int intTodayp2=0;
int intTodayp1=0;
int intTodayl1=0;
int intTodayl2=0;
String strTodayp2="";
String strTodayp1="";
String strTodayl1="";
String strTodayl2="";
String COUNTDAY="";
String CHECK1="";
String CHECK2="";
int COUNTNO=0;
String CHECKAry[]= new String[32];
int i ;
//===============================================
////////////   "ACTION=Q"  ////////////
if ( bFlag && ACTION.equals("Q")){
    
        ////////////////查詢到客戶的資料////////////
    if (FLOW.equals("")|| FLOW.equals("THIS_PAGE") ||  FLOW.equals("PREV_PAGE") || FLOW.equals("NEXT_PAGE")){
    
    try{
%>        
        
        
        <script LANGUAGE="vbscript">
        <!--
        Sub Item_Delete(URL)
            bDel= window.confirm("你確定要刪除嗎?")
                If bDel = true then
                window.location.replace URL
             End If
        End Sub
        
        Sub Item_Click(URL)
            window.location.replace URL
        End Sub        
        
        Sub PageForm_onsubmit
            DesiredPage = window.PageForm.DesiredPage.value
            If DesiredPage = Empty Then Exit Sub
            If Not IsNumeric(DesiredPage) Then Exit Sub
            TotalPage = window.PageForm.TotalPage.value
            If CLng(DesiredPage) > CLng(TotalPage) Then
                DesiredPage = TotalPage
            ElseIf CLng(DesiredPage) < 1 Then
                DesiredPage = "1"
            End If
            window.PageForm.action = "calendar.jsp?ACTION=Q&OPTION=THIS_PAGE&THIS_PAGE="+DesiredPage
        End Sub
        
        -->
        </script>

        <table border=0 cellspacing=0 cellpadding="0" align="center" style="margin-top:25">
        <tr>
        <td><img src="../botton/query-on.gif" align="absMiddle">&nbsp;<B>行事曆設定</B></td>
        </tr>
        </table>

        <form ID=FORM1 NAME=FORM1 METHOD=GET ACTION="<%="calendar.jsp?"%><%="ACTION=Q"%>">
        
        <table width=75% cellspacing="2" cellpadding="2" align=center style="margin-top:-12">
        <tr>
        <td class="f1">設定年份</td>
        <td class="f1">設定月份</td>
        <td class="f1">操作</td>
        </tr>
 

        
<%

        ////////////   切換上下頁  ////////////
        if (FLOW.equals("PREV_PAGE") ){        //印上一頁
            THIS_PAGE = Integer.toString(Integer.parseInt(THIS_PAGE)-1);
              }else if (FLOW.equals("THIS_PAGE") ){     //印這一頁
                                THIS_PAGE = THIS_PAGE;
              }else if (FLOW.equals("NEXT_PAGE") ){     //印下一頁
                        THIS_PAGE = Integer.toString(Integer.parseInt(THIS_PAGE)+1);
            }else {                 //印第一頁
                        THIS_PAGE = "1";
        }
            strSQL = "";
        
            strSQL = "SELECT * FROM CALENDAR ORDER BY YYYY,MM";
                
        
        
        rs = st.executeQuery(strSQL);
        rs.next();
        
        if (rs!= null){
                  rs.last();
                  TOT_COUNT=rs.getRow();
                  intAbsolute = PAGE_SIZE * ( Integer.parseInt(THIS_PAGE) - 1 );
                  rs.absolute(intAbsolute+1);
                  
           }
        
      
        REC_COUNT = TOT_COUNT - intAbsolute  >= PAGE_SIZE ? PAGE_SIZE : TOT_COUNT - intAbsolute;
        TOT_PAGES = ((TOT_COUNT-1)/PAGE_SIZE)+1;
        if (Integer.parseInt(THIS_PAGE) > 1){
            ENABLE_PREV = true; //若大於第1頁就表示還有上一頁
        }

        if (TOT_COUNT > PAGE_SIZE * Integer.parseInt(THIS_PAGE)){
                     ENABLE_NEXT = true; //還有下一頁
        }
              //out.println(strSQL);
             for ( i = 0; i < REC_COUNT; i++){
                  YYYY= rs.getString("YYYY");
                  MM = rs.getString("MM");
                  
%>
            <tr>
            <td class="1"><input class="i3" size=20 value="<%=YYYY%>" readonly></td>
            <td class="1"><input class="i3" size=20 value="<%=MM%>" readonly></td>
            <td class="1">
<%
            if (strAuth.substring(1,2).equals("Y")){       //U //
%>
                <img Onclick="Item_Click('calendar.jsp?ACTION=U&OPTION=VIEW_RECORD&THIS_PAGE=<%=THIS_PAGE%>&YYYY=<%=URLEncoder.encode(YYYY)%>&MM=<%=URLEncoder.encode(MM)%>')"
                onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('update<%=i%>','','../botton/modify-over.gif',1)" 
                 TITLE="修改此筆資料" src="../botton/modify-on.gif" border="0" name="update<%=i%>">        
                         
<%
            }
            if (strAuth.substring(2,3).equals("Y")){         // D //
%>
                <img Onclick="Item_Delete('calendar.jsp?ACTION=D&OPTION=DELETE_RECORD&THIS_PAGE=<%=THIS_PAGE%>&YYYY=<%=URLEncoder.encode(YYYY)%>&MM=<%=URLEncoder.encode(MM)%>')"
                onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('del<%=i%>','','../botton/del-over.gif',1)" 
                TITLE="刪除此筆資料" src="../botton/del-on.gif" border="0" name="del<%=i%>">
<%
            }

            if (strAuth.substring(3,4).equals("Y")){         // Q //
%>
                <img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=VIEW_RECORD&THIS_PAGE=<%=THIS_PAGE%>&YYYY=<%=URLEncoder.encode(YYYY)%>&MM=<%=URLEncoder.encode(MM)%>')"
                 onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('view<%=i%>','','../botton/view-over.gif',1)"
                 TITLE="檢視此筆資料" src="../botton/view-on.gif" border="0" name="view<%=i%>">
<%
            }

%>
            </td>
            </tr>

<%
            rs.next();
        }
%>
        </table>
        </form>    
        

        <form name="PageForm" method="post">
        <table border="0" cellspacing="0" cellpadding="0" align=center style="margin-top:-10">

        <td>&nbsp;&nbsp;&nbsp;</td>    
        <%
          if (strAuth.substring(3,4).equals("Y")){    // "Q"

                 if (( ENABLE_PREV==true) & (ENABLE_NEXT==false) ){
                if ( Integer.parseInt(THIS_PAGE) != 1){
        %>
                <td><img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=THIS_PAGE&THIS_PAGE=1')"
                onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../botton/first-over.gif',1)"
                Title="第一頁" src="../botton/first-on.gif" border="0" name="Image1" alt="第一頁"></td>
        <%            
                }
        %>
                <td><img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=PREV_PAGE&THIS_PAGE=<%=THIS_PAGE%>')" 
                onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../botton/up-over.gif',1)"
                Title="上一頁" src="../botton/up-on.gif" border="0" name="Image2" alt="上一頁"></td>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../botton/down.gif',1)"><img src="../botton/down.gif" border="0" name="Image3" alt="下一頁"></a></td>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../botton/last.gif',1)"><img src="../botton/last.gif" border="0" name="Image4" alt="最後頁"></a></td>

                
<%
              }
            else if (( ENABLE_PREV==false) & (ENABLE_NEXT==true) ){
%>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../botton/first.gif',1)"><img src="../botton/first.gif" border="0" name="Image1" alt="第一頁"></a></td>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../botton/up.gif',1)"><img src="../botton/up.gif" border="0" name="Image2" alt="上一頁"></a></td>
                <td><img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=NEXT_PAGE&THIS_PAGE=<%=THIS_PAGE%>')" 
                 onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../botton/down-over.gif',1)"
                 Title="下一頁" src="../botton/down-on.gif" border="0" name="Image3" alt="下一頁"></td>
<%
                if ( Integer.parseInt(THIS_PAGE) != TOT_PAGES){
%>
                    <td><img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=THIS_PAGE&THIS_PAGE=<%=TOT_PAGES%>')" 
                    onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../botton/last-over.gif',1)"
                    Title="最末頁" src="../botton/last-on.gif" border="0" name="Image4" alt="最末頁"></td>
<%                
                 }
               }
          else if(( ENABLE_PREV==true) & (ENABLE_NEXT==true) ){
                if ( Integer.parseInt(THIS_PAGE) != 1){
        %>
                <td><img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=THIS_PAGE&THIS_PAGE=1')" 
                onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../botton/first-over.gif',1)"
                Title="第一頁" src="../botton/first-on.gif" border="0" name="Image1" alt="第一頁"></td>
        <%            
                }
        %>
                <td><img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=PREV_PAGE&THIS_PAGE=<%=THIS_PAGE%>')" 
                onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../botton/up-over.gif',1)"
                Title="上一頁" src="../botton/up-on.gif" border="0" name="Image2" alt="上一頁"></td>
                
                <td><img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=NEXT_PAGE&THIS_PAGE=<%=THIS_PAGE%>')" 
                 onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../botton/down-over.gif',1)"
                 Title="下一頁" src="../botton/down-on.gif" border="0" name="Image3" alt="下一頁"></td>
<%
                if ( Integer.parseInt(THIS_PAGE) != TOT_PAGES){
%>
                    <td><img Onclick="Item_Click('calendar.jsp?ACTION=Q&OPTION=THIS_PAGE&THIS_PAGE=<%=TOT_PAGES%>')" 
                    onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../botton/last-over.gif',1)"
                    Title="最末頁" src="../botton/last-on.gif" border="0" name="Image4" alt="最末頁"></td>
<%                
                 }
          }
          else if(( ENABLE_PREV==false) & (ENABLE_NEXT==false) ){
%>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../botton/first.gif',1)"><img src="../botton/first.gif" border="0" name="Image1" alt="第一頁"></a></td>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../botton/up.gif',1)"><img src="../botton/up.gif" border="0" name="Image2" alt="上一頁"></a></td>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../botton/down.gif',1)"><img src="../botton/down.gif" border="0" name="Image3" alt="下一頁"></a></td>
                <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../botton/last.gif',1)"><img src="../botton/last.gif" border="0" name="Image4" alt="最後頁"></a></td>
<%
          }
        }  
%>      <span id="fdcpages" style="position: absolute; top: 50px; left:91px">
        <input ID="TotalPage" NAME="TotalPage" TYPE=HIDDEN VALUE="<%=TOT_PAGES%>"> 
        頁數: <span TYPE="TEXT" ID="DesiredPage" NAME="DesiredPage" maxlength=5 SIZE=5 VALUE="" style="position: relative; top: 0px; left:0px"><%=THIS_PAGE%></span><span style="position: relative; top: 0px; left:5px">/</span><span ID="fdcTotalPages" NAME="fdcTotalPages" style="position: relative; top: 0px; left:5px"><%=TOT_PAGES%></span></span>

        
       
        

        <td>&nbsp;&nbsp;&nbsp;</td>
<%
        if (strAuth.substring(0,1).equals("Y")){    // "A"
%>
        
        <td><img Onclick="Item_Click('calendar.jsp?ACTION=A&OPTION=VIEW_FORM&THIS_PAGE=<%=THIS_PAGE%>')" 
                    onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','../botton/plus-over.gif',1)"
                    Title="新增" src="../botton/plus-on.gif" border="0" name="Image5" alt="新增"></td>
<%
          }
%>
        
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../botton/save.gif',1)"><img src="../botton/save.gif" border="0" name="Image6" alt="儲存"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../botton/cancel.gif',1)"><img src="../botton/cancel.gif" border="0" name="Image7" alt="執行"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','../botton/return.gif',1)"><img src="../botton/return.gif" border="0" name="Image8" alt="返回"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','../botton/newreach.gif',1)"><img src="../botton/newreach.gif" border="0" name="Image10" alt="重新搜尋"></a></td>
         <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','../botton/reach.gif',1)"><img src="../botton/reach.gif" border="0" name="Image9" alt="查詢明細"></a></td>
        
        <td><a href="calendar_h.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','../botton/help-over.gif',1)"><img src="../botton/help-on.gif" border="0" name="Image11" alt="說明"></a></td>

      </tr>
        
      </table>
        
      </form>
        
<%
       }catch(SQLException e){ 
           if (e.getErrorCode()==17002){
                db.retry();
                System.gc();
                log = "Error Occured,Message="+e.getMessage();
                //out.println(log);
            }
      }
   }        

        

    //=================================================================================
    //    檢視明細
    //=================================================================================
    if (FLOW.equals("VIEW_RECORD")){
        try{    
            YYYY  = request.getParameter("YYYY");
            //out.println("YYYY="+YYYY);
            MM  = request.getParameter("MM");
            //out.println("MM="+MM);
            
            strSQL = "SELECT * FROM CALENDAR WHERE YYYY='"+YYYY+"' AND MM='"+MM+"'";
            //out.println("strSQL="+strSQL);
            
            rs = st.executeQuery(strSQL);
            rs.next();

            if ( rs != null ){
                
                CHECKAry[1]=Util.rtnStr(rs.getString("DAY_01"));
                if (CHECKAry[1].equals("Y")){
                       CHECKAry[1]="checked";
                }else{
                    CHECKAry[1]="";
                }
                   //out.println("CHECKAry[1]="+CHECKAry[1]);
                CHECKAry[2]=Util.rtnStr(rs.getString("DAY_02"));
                if (CHECKAry[2].equals("Y")){
                       CHECKAry[2]="checked";
                }else{
                    CHECKAry[2]="";
                }
                //out.println("CHECKAry[2]="+CHECKAry[2]);
                CHECKAry[3]=Util.rtnStr(rs.getString("DAY_03"));
                if (CHECKAry[3].equals("Y")){
                       CHECKAry[3]="checked";
                }else{
                    CHECKAry[3]="";
                }
                //out.println("CHECKAry[3]="+CHECKAry[3]);
                CHECKAry[4]=Util.rtnStr(rs.getString("DAY_04"));
                if (CHECKAry[4].equals("Y")){
                       CHECKAry[4]="checked";
                }else{
                    CHECKAry[4]="";
                }
                //out.println("CHECKAry[4]="+CHECKAry[4]);
                CHECKAry[5]=Util.rtnStr(rs.getString("DAY_05"));
                if (CHECKAry[5].equals("Y")){
                       CHECKAry[5]="checked";
                }else{
                    CHECKAry[5]="";
                }
                //out.println("CHECKAry[5]="+CHECKAry[5]);
                CHECKAry[6]=Util.rtnStr(rs.getString("DAY_06"));
                if (CHECKAry[6].equals("Y")){
                       CHECKAry[6]="checked";
                }else{
                    CHECKAry[6]="";
                }
                //out.println("CHECKAry[6]="+CHECKAry[6]);
                CHECKAry[7]=Util.rtnStr(rs.getString("DAY_07"));
                if (CHECKAry[7].equals("Y")){
                       CHECKAry[7]="checked";
                }else{
                    CHECKAry[7]="";
                }
                //out.println("CHECKAry[7]="+CHECKAry[7]);
                CHECKAry[8]=Util.rtnStr(rs.getString("DAY_08"));
                if (CHECKAry[8].equals("Y")){
                       CHECKAry[8]="checked";
                }else{
                    CHECKAry[8]="";
                }
                //out.println("CHECKAry[8]="+CHECKAry[8]);
                CHECKAry[9]=Util.rtnStr(rs.getString("DAY_09"));
                if (CHECKAry[9].equals("Y")){
                       CHECKAry[9]="checked";
                }else{
                    CHECKAry[9]="";
                }
                //out.println("CHECKAry[9]="+CHECKAry[9]);
                CHECKAry[10]=Util.rtnStr(rs.getString("DAY_10"));
                if (CHECKAry[10].equals("Y")){
                       CHECKAry[10]="checked";
                }else{
                    CHECKAry[10]="";
                }
                //out.println("CHECKAry[10]="+CHECKAry[10]);
                CHECKAry[11]=Util.rtnStr(rs.getString("DAY_11"));
                if (CHECKAry[11].equals("Y")){
                       CHECKAry[11]="checked";
                }else{
                    CHECKAry[11]="";
                }
                //out.println("CHECKAry[11]="+CHECKAry[11]);
                CHECKAry[12]=Util.rtnStr(rs.getString("DAY_12"));
                if (CHECKAry[12].equals("Y")){
                       CHECKAry[12]="checked";
                }else{
                    CHECKAry[12]="";
                }
                //out.println("CHECKAry[12]="+CHECKAry[12]);
                CHECKAry[13]=Util.rtnStr(rs.getString("DAY_13"));
                if (CHECKAry[13].equals("Y")){
                       CHECKAry[13]="checked";
                }else{
                    CHECKAry[13]="";
                }
                //out.println("CHECKAry[13]="+CHECKAry[13]);
                CHECKAry[14]=Util.rtnStr(rs.getString("DAY_14"));
                if (CHECKAry[14].equals("Y")){
                       CHECKAry[14]="checked";
                }else{
                    CHECKAry[14]="";
                }
                //out.println("CHECKAry[14]="+CHECKAry[14]);
                CHECKAry[15]=Util.rtnStr(rs.getString("DAY_15"));
                if (CHECKAry[15].equals("Y")){
                       CHECKAry[15]="checked";
                }else{
                    CHECKAry[15]="";
                }
                //out.println("CHECKAry[15]="+CHECKAry[15]);
                CHECKAry[16]=Util.rtnStr(rs.getString("DAY_16"));
                if (CHECKAry[16].equals("Y")){
                       CHECKAry[16]="checked";
                }else{
                    CHECKAry[16]="";
                }
                //out.println("CHECKAry[16]="+CHECKAry[16]);
                CHECKAry[17]=Util.rtnStr(rs.getString("DAY_17"));
                if (CHECKAry[17].equals("Y")){
                       CHECKAry[17]="checked";
                }else{
                    CHECKAry[17]="";
                }
                //out.println("CHECKAry[17]="+CHECKAry[17]);
                CHECKAry[18]=Util.rtnStr(rs.getString("DAY_18"));
                if (CHECKAry[18].equals("Y")){
                       CHECKAry[18]="checked";
                }else{
                    CHECKAry[18]="";
                }
                //out.println("CHECKAry[18]="+CHECKAry[18]);
                CHECKAry[19]=Util.rtnStr(rs.getString("DAY_19"));
                if (CHECKAry[19].equals("Y")){
                       CHECKAry[19]="checked";
                }else{
                    CHECKAry[19]="";
                }
                //out.println("CHECKAry[19]="+CHECKAry[19]);
                CHECKAry[20]=Util.rtnStr(rs.getString("DAY_20"));
                if (CHECKAry[20].equals("Y")){
                       CHECKAry[20]="checked";
                }else{
                    CHECKAry[20]="";
                }
                //out.println("CHECKAry[20]="+CHECKAry[20]);
                CHECKAry[21]=Util.rtnStr(rs.getString("DAY_21"));
                if (CHECKAry[21].equals("Y")){
                       CHECKAry[21]="checked";
                }else{
                    CHECKAry[21]="";
                }
                //out.println("CHECKAry[21]="+CHECKAry[21]);
                CHECKAry[22]=Util.rtnStr(rs.getString("DAY_22"));
                if (CHECKAry[22].equals("Y")){
                       CHECKAry[22]="checked";
                }else{
                    CHECKAry[22]="";
                }
                //out.println("CHECKAry[22]="+CHECKAry[22]);
                CHECKAry[23]=Util.rtnStr(rs.getString("DAY_23"));
                if (CHECKAry[23].equals("Y")){
                       CHECKAry[23]="checked";
                }else{
                    CHECKAry[23]="";
                }
                //out.println("CHECKAry[23]="+CHECKAry[23]);
                CHECKAry[24]=Util.rtnStr(rs.getString("DAY_24"));
                if (CHECKAry[24].equals("Y")){
                       CHECKAry[24]="checked";
                }else{
                    CHECKAry[24]="";
                }
                //out.println("CHECKAry[24]="+CHECKAry[24]);
                CHECKAry[25]=Util.rtnStr(rs.getString("DAY_25"));
                if (CHECKAry[25].equals("Y")){
                       CHECKAry[25]="checked";
                }else{
                    CHECKAry[25]="";
                }
                //out.println("CHECKAry[25]="+CHECKAry[25]);
                CHECKAry[26]=Util.rtnStr(rs.getString("DAY_26"));
                if (CHECKAry[26].equals("Y")){
                       CHECKAry[26]="checked";
                }else{
                    CHECKAry[26]="";
                }
                //out.println("CHECKAry[26]="+CHECKAry[26]);
                CHECKAry[27]=Util.rtnStr(rs.getString("DAY_27"));
                if (CHECKAry[27].equals("Y")){
                       CHECKAry[27]="checked";
                }else{
                    CHECKAry[27]="";
                }
                //out.println("CHECKAry[27]="+CHECKAry[27]);
                CHECKAry[28]=Util.rtnStr(rs.getString("DAY_28"));
                if (CHECKAry[28].equals("Y")){
                       CHECKAry[28]="checked";
                }else{
                    CHECKAry[28]="";
                }
                //out.println("CHECKAry[28]="+CHECKAry[28]);
                CHECKAry[29]=Util.rtnStr(rs.getString("DAY_29"));
                if (CHECKAry[29].equals("Y")){
                       CHECKAry[29]="checked";
                }else{
                    CHECKAry[29]="";
                }
                //out.println("CHECKAry[29]="+CHECKAry[29]);
                CHECKAry[30]=Util.rtnStr(rs.getString("DAY_30"));
                if (CHECKAry[30].equals("Y")){
                       CHECKAry[30]="checked";
                }else{
                    CHECKAry[30]="";
                }
                //out.println("CHECKAry[30]="+CHECKAry[30]);
                CHECKAry[31]=Util.rtnStr(rs.getString("DAY_31"));
                if (CHECKAry[31].equals("Y")){
                       CHECKAry[31]="checked";
                }else{
                    CHECKAry[31]="";
                }
                //out.println("CHECKAry[31]="+CHECKAry[31]);

  


%>    
          
        
        
        
        
        <form ID="FORM1" NAME="FORM1" METHOD="POST" ACTION="<%="calendar.jsp?"%><%="ACTION=A"%><%="&THIS_PAGE="+THIS_PAGE%>">
        <table border=0 cellspacing=0 cellpadding="0" align="center" style="margin-top:25">
        <tr>
        <td><img src="../botton/view-on.gif" align="absMiddle">&nbsp;<B>行事曆設定</B></td>
        </tr>
        </table>

        <table border=0 class="1" width=57% cellspacing="0" cellpadding="0" align="center" style="margin-top:7">
        <tr> 
        <td class="f1" style="width:140">減價年月</td>
        <td class="f2" style="width:18"></td>
        <td class="f2" style="width:50"><input class="i3" size=10 NAME="YYYY" value="<%=rs.getString("YYYY")%>" readonly></td>
        <td class="f2" style="width:50">年</td>
        <td class="f2" style="width:50"><input class="i3" size=5  NAME="MM" value="<%=rs.getString("MM")%>" readonly></td>
        <td class="f2">月</td>
        </tr>
        </table>


        
        
        <table border=0 class="2" width=57% cellspacing="2" cellpadding="2" align="center" style="margin-top:-1">
        <tr>
        <td class="i1">日</td>
        <td class="i1">一</td>
        <td class="i1">二</td>
        <td class="i1">三</td>
        <td class="i1">四</td>
        <td class="i1">五</td>
        <td class="i1">六</td>
        </tr>
        <input type="hidden" name="c1" value=<%=CHECKAry[1]%>>
        <input type="hidden" name="c2" value=<%=CHECKAry[2]%>>
        <input type="hidden" name="c3" value=<%=CHECKAry[3]%>>
        <input type="hidden" name="c4" value=<%=CHECKAry[4]%>>
        <input type="hidden" name="c5" value=<%=CHECKAry[5]%>>
        <input type="hidden" name="c6" value=<%=CHECKAry[6]%>>
        <input type="hidden" name="c7" value=<%=CHECKAry[7]%>>
        <input type="hidden" name="c8" value=<%=CHECKAry[8]%>>
        <input type="hidden" name="c9" value=<%=CHECKAry[9]%>>
        <input type="hidden" name="c10" value=<%=CHECKAry[10]%>>
        <input type="hidden" name="c11" value=<%=CHECKAry[11]%>>
        <input type="hidden" name="c12" value=<%=CHECKAry[12]%>>
        <input type="hidden" name="c13" value=<%=CHECKAry[13]%>>
        <input type="hidden" name="c14" value=<%=CHECKAry[14]%>>
        <input type="hidden" name="c15" value=<%=CHECKAry[15]%>>
        <input type="hidden" name="c16" value=<%=CHECKAry[16]%>>
        <input type="hidden" name="c17" value=<%=CHECKAry[17]%>>
        <input type="hidden" name="c18" value=<%=CHECKAry[18]%>>
        <input type="hidden" name="c19" value=<%=CHECKAry[19]%>>
        <input type="hidden" name="c20" value=<%=CHECKAry[20]%>>
        <input type="hidden" name="c21" value=<%=CHECKAry[21]%>>
        <input type="hidden" name="c22" value=<%=CHECKAry[22]%>>
        <input type="hidden" name="c23" value=<%=CHECKAry[23]%>>
        <input type="hidden" name="c24" value=<%=CHECKAry[24]%>>
        <input type="hidden" name="c25" value=<%=CHECKAry[25]%>>
        <input type="hidden" name="c26" value=<%=CHECKAry[26]%>>
        <input type="hidden" name="c27" value=<%=CHECKAry[27]%>>
        <input type="hidden" name="c28" value=<%=CHECKAry[28]%>>
        <input type="hidden" name="c29" value=<%=CHECKAry[29]%>>
        <input type="hidden" name="c30" value=<%=CHECKAry[30]%>>
        <input type="hidden" name="c31" value=<%=CHECKAry[31]%>>


        <SCRIPT LANGUAGE="vbScript">
        <!--
    
        yyyy=document.FORM1.YYYY.value
        mm=document.FORM1.MM.value
        dim cc
        redim cc(31)
        
        cc(1)=document.FORM1.c1.value
        'alert(cc(1))
        cc(2)=document.FORM1.c2.value
        cc(3)=document.FORM1.c3.value
        cc(4)=document.FORM1.c4.value
        cc(5)=document.FORM1.c5.value
        cc(6)=document.FORM1.c6.value
        cc(7)=document.FORM1.c7.value
        cc(8)=document.FORM1.c8.value
        cc(9)=document.FORM1.c9.value
        cc(10)=document.FORM1.c10.value
        cc(11)=document.FORM1.c11.value
        cc(12)=document.FORM1.c12.value
        cc(13)=document.FORM1.c13.value
        cc(14)=document.FORM1.c14.value
        cc(15)=document.FORM1.c15.value
        cc(16)=document.FORM1.c16.value
        cc(17)=document.FORM1.c17.value
        cc(18)=document.FORM1.c18.value
        cc(19)=document.FORM1.c19.value
        cc(20)=document.FORM1.c20.value
        cc(21)=document.FORM1.c21.value
        cc(22)=document.FORM1.c22.value
        cc(23)=document.FORM1.c23.value
        cc(24)=document.FORM1.c24.value
        cc(25)=document.FORM1.c25.value
        cc(26)=document.FORM1.c26.value
        cc(27)=document.FORM1.c27.value
        cc(28)=document.FORM1.c28.value
        cc(29)=document.FORM1.c29.value
        cc(30)=document.FORM1.c30.value
        cc(31)=document.FORM1.c31.value
        
        
        aaa = yyyy+"/"+mm+"/1"
        dim mon
        dim w
        dim d
        dim pw 
        dim mon2
        dim    countday
        mon=Month(aaa)
        mon2=Month(aaa)
        i=1
        pw=DatePart("w",aaa)
        'alert(pw)
        do             
            if i=1 then
                    w=DatePart("w",aaa)
                    'alert(w)
                    document.write "<tr>"
                
                   for j=1 to w-1
                       document.write "<td class=""i1"">" 
                       document.write ""
                       document.write "</td>"
                   next
                d=DatePart("d",aaa)
                document.write "<td class=""i1"">"
                document.write "<input type=""checkbox"" name=""check"& i &""""&cc(1)&" disabled>"
                document.write d & "&nbsp;"
                document.write "</td>"
                if (pw=7) then
                   document.write "</tr>"
                   document.write "<tr>"
                end if
            else
            
                 mon2 = DateAdd("d",1,aaa)

                 if (Month(mon2)=mon) then
                     aaa = mon2
                        w=DatePart("w",aaa)
                     d=DatePart("d",aaa)
                    
                         document.write "<td class=""i1"">"
                         document.write "<input type=""checkbox""  name=""check"& i &""""& cc(i) &"  disabled>"
                         document.write d & "&nbsp;"
                         document.write "</td>"
                         if i=(8-pw) Or i=(15-pw) Or i=(22-pw) Or i=(29-pw) Or i=(36-pw) Or i=(43-pw) then
                            document.write "</tr>"
                            document.write "<tr>"
                         end if
                        
                         


                 else
                      exit do
                 end if
            end if
            i=i+1
        loop  
            
            document.write "<input type=""hidden"" name=""countday"" value="&i-1&" >"
        //-->
        </SCRIPT>
        </table>

        <table border="0" cellspacing="0" cellpadding="0" align=center style="margin-top:7">
        <tr> 
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('first','','../botton/first.gif',1)"><img src="../botton/first.gif" border="0" name="first" alt="第一頁"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('up','','../botton/up.gif',1)"><img src="../botton/up.gif" border="0" name="up" alt="上一頁"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('down','','../botton/down.gif',1)"><img src="../botton/down.gif" border="0" name="down" alt="下一頁"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('last','','../botton/last.gif',1)"><img src="../botton/last.gif" border="0" name="last" alt="最後頁"></a></td>

        <td>&nbsp;&nbsp;&nbsp;</td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('plus','','../botton/plus.gif',1)"><img src="../botton/plus.gif" border="0" name="plus" alt="新增"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('save','','../botton/save.gif',1)"><img src="../botton/save.gif" border="0" name="save" alt="儲存"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('cancel','','../botton/cancel.gif',1)"><img src="../botton/cancel.gif" border="0" name="cancel" alt="執行"></a></td>
        <td><a href="<%="calendar.jsp?"%><%="ACTION=Q"%><%="&OPTION=THIS_PAGE"%><%="&THIS_PAGE="+THIS_PAGE%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','../botton/return-over.gif',1)"><img src="../botton/return-on.gif" border="0" name="Image8" alt="返回"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('newreach','','../botton/newreach.gif',1)"><img src="../botton/newreach.gif" border="0" name="newreach" alt="重新搜尋"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('reach','','../botton/reach.gif',1)"><img src="../botton/reach.gif" border="0" name="reach" alt="查詢明細"></a></td>        
        </tr>
        </table>
        </form>
<%      
        }
        }catch(SQLException e){ 
           if (e.getErrorCode()==17002){
                db.retry();
                System.gc();
                log = "Error Occured,Message="+e.getMessage();
                //out.println(log);
            }
        }
        
        }
        
        

}

//=====================================================================================================
////////////   "ACTION=A"  ////////////
//=====================================================================================================
if ( bFlag && ACTION.equals("A")){
    
%>    
    <script LANGUAGE="vbscript">
    <!--
    
    sub dosubmit( formname )
                window.document.forms(formname).ACTION=window.document.forms(formname).ACTION+"&OPTION=SAVE_RECORD"
            
                window.document.forms(formname).submit
        
    
    end sub


    -->
    
    </script>    
<%    

 //====================================================================================================
    if ( FLOW.equals("SAVE_RECORD")){
        try{ 
        YYYY  = request.getParameter("YYYY");
        //out.println("YYYY="+YYYY);
        MM  = request.getParameter("MM");
        //out.println("MM="+MM);
        
        strSQL = "SELECT * FROM CALENDAR WHERE YYYY='"+YYYY+"' AND MM='"+MM+"'";             
        //out.println("strSQL="+strSQL);
        
        rs = st.executeQuery(strSQL);
        if ( rs!= null ){
            rs.last();
            intCount = rs.getRow();
            rs.first();
        }
            rs.close();
            if ( intCount > 0 ){
%>
                
            <p>　</p>
            <table width="25%" class="4" border=0 cellspacing=10 cellpadding="0" align="center">
                   <tr><td>　</td></tr>
                   <tr><td>此減價年月設定已重複</td></tr>                   
                   <tr><td>　</td></tr>
              </table>
              <table border=0 cellspacing=0 cellpadding="0" align="center" style="margin-top:10">
                 <tr><td>
                 <a HREF="<%="calendar.jsp?"%><%="ACTION=Q"%><%="&OPTION=THIS_PAGE"%><%="&THIS_PAGE="+THIS_PAGE%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('return','','../botton/return-over.gif',1)">
                 <img border="0" src="../botton/return-on.gif" name="return" alt="返回"></a>
                 </td></tr>
              </table>    
                        
<%            
            }else{
                strSQL="";
                
                COUNTDAY =request.getParameter("countday");
                //out.println("COUNTDAY="+COUNTDAY);
                COUNTNO=Integer.parseInt(COUNTDAY);
                YYYY  = request.getParameter("YYYY");
                //out.println("YYYY="+YYYY);
                MM  = request.getParameter("MM");
                //out.println("MM="+MM);
                String kk="";
                
                for (i=1;i<=COUNTNO; i++) 
                {
                   
                   kk=Integer.toString(i);
                   //out.println("kk="+kk);
                   //out.println("i="+i);
                   CHECKAry[i] = Util.rtnStr(request.getParameter("check"+kk)); 
                   //out.println("CHECKAry[" + i + "]="+CHECKAry[i]);
                   if (CHECKAry[i].equals("on")){
                       CHECKAry[i]="Y";
                   }else{
                       CHECKAry[i]="N";
                   }
                
                }
                if (COUNTNO==28)
                {
           
                    strSQL="INSERT INTO CALENDAR(YYYY,MM,DAY_01,DAY_02,DAY_03,DAY_04,DAY_05,DAY_06,DAY_07,DAY_08,DAY_09,DAY_10,DAY_11,DAY_12,DAY_13,DAY_14,DAY_15,DAY_16,DAY_17,DAY_18,DAY_19,DAY_20,DAY_21,DAY_22,DAY_23,DAY_24,DAY_25,DAY_26,DAY_27,DAY_28) VALUES('"+YYYY+"','"+MM+"','"+CHECKAry[1]+"','"+CHECKAry[2]+"','"+CHECKAry[3]+"','"+CHECKAry[4]+"','"+CHECKAry[5]+"','"+CHECKAry[6]+"','"+CHECKAry[7]+"','"+CHECKAry[8]+"','"+CHECKAry[9]+"','"+CHECKAry[10]+"','"+CHECKAry[11]+"','"+CHECKAry[12]+"','"+CHECKAry[13]+"','"+CHECKAry[14]+"','"+CHECKAry[15]+"','"+CHECKAry[16]+"','"+CHECKAry[17]+"','"+CHECKAry[18]+"','"+CHECKAry[19]+"','"+CHECKAry[20]+"','"+CHECKAry[21]+"','"+CHECKAry[22]+"','"+CHECKAry[23]+"','"+CHECKAry[24]+"','"+CHECKAry[25]+"','"+CHECKAry[26]+"','"+CHECKAry[27]+"','"+CHECKAry[28]+"')";
                }
                else if(COUNTNO==29)
                {
                    strSQL="INSERT INTO CALENDAR(YYYY,MM,DAY_01,DAY_02,DAY_03,DAY_04,DAY_05,DAY_06,DAY_07,DAY_08,DAY_09,DAY_10,DAY_11,DAY_12,DAY_13,DAY_14,DAY_15,DAY_16,DAY_17,DAY_18,DAY_19,DAY_20,DAY_21,DAY_22,DAY_23,DAY_24,DAY_25,DAY_26,DAY_27,DAY_28,DAY_29) VALUES('"+YYYY+"','"+MM+"','"+CHECKAry[1]+"','"+CHECKAry[2]+"','"+CHECKAry[3]+"','"+CHECKAry[4]+"','"+CHECKAry[5]+"','"+CHECKAry[6]+"','"+CHECKAry[7]+"','"+CHECKAry[8]+"','"+CHECKAry[9]+"','"+CHECKAry[10]+"','"+CHECKAry[11]+"','"+CHECKAry[12]+"','"+CHECKAry[13]+"','"+CHECKAry[14]+"','"+CHECKAry[15]+"','"+CHECKAry[16]+"','"+CHECKAry[17]+"','"+CHECKAry[18]+"','"+CHECKAry[19]+"','"+CHECKAry[20]+"','"+CHECKAry[21]+"','"+CHECKAry[22]+"','"+CHECKAry[23]+"','"+CHECKAry[24]+"','"+CHECKAry[25]+"','"+CHECKAry[26]+"','"+CHECKAry[27]+"','"+CHECKAry[28]+"','"+CHECKAry[29]+"')";
                }
                else if(COUNTNO==30)
                {
                    strSQL="INSERT INTO CALENDAR(YYYY,MM,DAY_01,DAY_02,DAY_03,DAY_04,DAY_05,DAY_06,DAY_07,DAY_08,DAY_09,DAY_10,DAY_11,DAY_12,DAY_13,DAY_14,DAY_15,DAY_16,DAY_17,DAY_18,DAY_19,DAY_20,DAY_21,DAY_22,DAY_23,DAY_24,DAY_25,DAY_26,DAY_27,DAY_28,DAY_29,DAY_30) VALUES('"+YYYY+"','"+MM+"','"+CHECKAry[1]+"','"+CHECKAry[2]+"','"+CHECKAry[3]+"','"+CHECKAry[4]+"','"+CHECKAry[5]+"','"+CHECKAry[6]+"','"+CHECKAry[7]+"','"+CHECKAry[8]+"','"+CHECKAry[9]+"','"+CHECKAry[10]+"','"+CHECKAry[11]+"','"+CHECKAry[12]+"','"+CHECKAry[13]+"','"+CHECKAry[14]+"','"+CHECKAry[15]+"','"+CHECKAry[16]+"','"+CHECKAry[17]+"','"+CHECKAry[18]+"','"+CHECKAry[19]+"','"+CHECKAry[20]+"','"+CHECKAry[21]+"','"+CHECKAry[22]+"','"+CHECKAry[23]+"','"+CHECKAry[24]+"','"+CHECKAry[25]+"','"+CHECKAry[26]+"','"+CHECKAry[27]+"','"+CHECKAry[28]+"','"+CHECKAry[29]+"','"+CHECKAry[30]+"')";
                }
                else
                { 
                    strSQL="INSERT INTO CALENDAR(YYYY,MM,DAY_01,DAY_02,DAY_03,DAY_04,DAY_05,DAY_06,DAY_07,DAY_08,DAY_09,DAY_10,DAY_11,DAY_12,DAY_13,DAY_14,DAY_15,DAY_16,DAY_17,DAY_18,DAY_19,DAY_20,DAY_21,DAY_22,DAY_23,DAY_24,DAY_25,DAY_26,DAY_27,DAY_28,DAY_29,DAY_30,DAY_31) VALUES('"+YYYY+"','"+MM+"','"+CHECKAry[1]+"','"+CHECKAry[2]+"','"+CHECKAry[3]+"','"+CHECKAry[4]+"','"+CHECKAry[5]+"','"+CHECKAry[6]+"','"+CHECKAry[7]+"','"+CHECKAry[8]+"','"+CHECKAry[9]+"','"+CHECKAry[10]+"','"+CHECKAry[11]+"','"+CHECKAry[12]+"','"+CHECKAry[13]+"','"+CHECKAry[14]+"','"+CHECKAry[15]+"','"+CHECKAry[16]+"','"+CHECKAry[17]+"','"+CHECKAry[18]+"','"+CHECKAry[19]+"','"+CHECKAry[20]+"','"+CHECKAry[21]+"','"+CHECKAry[22]+"','"+CHECKAry[23]+"','"+CHECKAry[24]+"','"+CHECKAry[25]+"','"+CHECKAry[26]+"','"+CHECKAry[27]+"','"+CHECKAry[28]+"','"+CHECKAry[29]+"','"+CHECKAry[30]+"','"+CHECKAry[31]+"')";
                }
                st.execute(strSQL);
                
%>           
            <p>　</p>
            <table width="25%" class="4" border=0 cellspacing=10 cellpadding="0" align="center">
                   <tr><td>　</td></tr>
                   <tr><td>新增成功</td></tr>                   
                   <tr><td>　</td></tr>
              </table>
              <table border=0 cellspacing=0 cellpadding="0" align="center" style="margin-top:10">
                 <tr><td>
                 <a HREF="<%="calendar.jsp?"%><%="ACTION=Q"%><%="&OPTION=THIS_PAGE"%><%="&THIS_PAGE="+THIS_PAGE%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('return','','../botton/return-over.gif',1)"><img border="0" src="../botton/return-on.gif" name="return" alt="返回"></a>
                 </td>
               
               </tr>
              </table>
<%       
            }
            }catch(SQLException e){ 
                   if (e.getErrorCode()==17002){
                        db.retry();
                        System.gc();
                        log = "Error Occured,Message="+e.getMessage();
                        //out.println(log);
                    }
              }
                  
        
    }
    
    //=================================================================================================
        //產生新增空白表單
    if (FLOW.equals("VIEW_FORM")){
             
                YYYY=request.getParameter("YYYY");
                MM=    request.getParameter("MM");



%>
        
        <form ID="FORM1" NAME="FORM1" METHOD="POST" ACTION="<%="calendar.jsp?"%><%="ACTION=A"%><%="&THIS_PAGE="+THIS_PAGE%>">

        <table border=0 cellspacing=0 cellpadding="0" align="center" style="margin-top:25">
        <tr>
        <td><img src="../botton/bplus-on.gif" align="absMiddle">&nbsp;<B>行事曆設定</B></td>
        </tr>
        </table>

        <%
              //getUID=pp.getUID();
        %>
        <table border=0 class="1" width=57% cellspacing="0" cellpadding="0" align="center" style="margin-top:7">
        <tr> 
        <td class="f1" style="width:140">減價年月</td>
        <td class="f2" style="width:18"></td>
        <td class="f2" onclick=""style="width:75"><select class="i2a" size=1 name="YYYY" VALUE="<%=YYYY%>" onchange="window.location.href='calendar_a1.jsp?YYYY=' + this.value+'&MM='+document.FORM1.MM.value;">
        <%
                today = Datetime.getToday();
                today=today.substring(0,4);
                intToday=Integer.parseInt(today);
                intTodayp2=intToday+2;
                intTodayp1=intToday+1;
                intTodayl1=intToday-1;
                intTodayl2=intToday-2;
                strTodayp2=Integer.toString(intTodayp2);
                strTodayp1=Integer.toString(intTodayp1);
                strTodayl1=Integer.toString(intTodayl1);
                strTodayl2=Integer.toString(intTodayl2);

                if (null==request.getParameter("YYYY")) {
                   fdctoday =today;
                }else {
                   fdctoday = request.getParameter("YYYY");
                }

        %>
                <option value="<%=intTodayl2%>" <%=Check.Set_Selected(fdctoday,strTodayl2)
                %>><%=intTodayl2%></option>
                <option value="<%=intTodayl1%>"<%=Check.Set_Selected(fdctoday,strTodayl1)
                %>><%=intTodayl1%></option>
                <option value="<%=intToday%>"<%=Check.Set_Selected(fdctoday,today)
                %>><%=intToday%></option>
                <option value="<%=intTodayp1%>"<%=Check.Set_Selected(fdctoday,strTodayp1)
                %>><%=intTodayp1%></option>
                <option value="<%=intTodayp2%>"<%=Check.Set_Selected(fdctoday,strTodayp2)
                %>><%=intTodayp2%></option>
        
        </select>年
        </td>
        <td class="f2" onclick=""><select class="i2a" size=1 name="MM" VALUE="<%=MM%>" onchange="window.location.href='calendar_a1.jsp?YYYY=' + document.FORM1.YYYY.value+'&MM='+this.value;">
        
            <%
                
                if (null==request.getParameter("MM")) {
                   start_mon ="01";
                }else {
                   start_mon = request.getParameter("MM");
                }
                for (i = 1; i <=12; i++){
                    SH="";
                    SH=Integer.toString(i);
                    SH=Util.addZero(SH);

             %>          
                <option <%=Check.Set_Selected(start_mon,SH)%> value="<%=SH%>"><%=SH%></option>          
             <%
                
                }
            
             %>    
        
        </select>月
        </td>
        </tr>
        </table>
        <table border=0 class="2" width=57% cellspacing="2" cellpadding="2" align="center" style="margin-top:-1">
        <tr>
        <td class="i1">日</td>
        <td class="i1">一</td>
        <td class="i1">二</td>
        <td class="i1">三</td>
        <td class="i1">四</td>
        <td class="i1">五</td>
        <td class="i1">六</td>
        </tr>
        
        <SCRIPT LANGUAGE="vbScript">
        <!--
    
        yyyy=document.FORM1.YYYY.value
        'alert(yyyy)
        mm=document.FORM1.MM.value
        'alert(mm)
        aaa = yyyy+"/"+mm+"/1"
        dim mon
        dim w
        dim d
        dim pw 
        dim mon2
        dim    countday
        mon=Month(aaa)
        mon2=Month(aaa)
        i=1
        pw=DatePart("w",aaa)
        'alert(pw)
        do             
            if i=1 then
                    w=DatePart("w",aaa)
                    'alert(w)
                    document.write "<tr>"
                
                   for j=1 to w-1
                       document.write "<td class=""i1"">" 
                       document.write ""
                       document.write "</td>"
                   next
                d=DatePart("d",aaa)
                document.write "<td class=""i1"">"
                document.write "<input type=""checkbox"" name=""check"& i &""">"
                document.write d & "&nbsp;"
                document.write "</td>"
                if (pw=7) then
                   document.write "</tr>"
                   document.write "<tr>"
                end if
            else
            
                 mon2 = DateAdd("d",1,aaa)

                 if (Month(mon2)=mon) then
                     aaa = mon2
                        w=DatePart("w",aaa)
                     d=DatePart("d",aaa)
                    
                         document.write "<td class=""i1"">"
                         document.write "<input type=""checkbox"" name=""check"& i &""">"
                         document.write d & "&nbsp;"
                         document.write "</td>"
                         if i=(8-pw) Or i=(15-pw) Or i=(22-pw) Or i=(29-pw) Or i=(36-pw) Or i=(43-pw) then
                            document.write "</tr>"
                            document.write "<tr>"
                         end if
                        
                         


                 else
                      exit do
                 end if
            end if
            i=i+1
        loop  
            
            document.write "<input type=""hidden"" name=""countday"" value="&i-1&" >"
        //-->
        </SCRIPT>
        
        </table>

        <table border="0" cellspacing="0" cellpadding="0" align=center style="margin-top:10">
        <tr> 
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../botton/first.gif',1)"><img src="../botton/first.gif" border="0" name="Image1" alt="第一頁"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../botton/up.gif',1)"><img src="../botton/up.gif" border="0" name="Image2" alt="上一頁"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../botton/down.gif',1)"><img src="../botton/down.gif" border="0" name="Image3" alt="下一頁"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../botton/last.gif',1)"><img src="../botton/last.gif" border="0" name="Image4" alt="最後頁"></a></td>

        <td>&nbsp;&nbsp;&nbsp;</td>

        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','../botton/plus.gif',1)"><img src="../botton/plus.gif" border="0" name="Image5" alt="新增"></a></td>

         
        <td><img onclick="dosubmit(&quot;form1&quot;)"
        onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../botton/save-over.gif',1)" 
        alt="儲存" src="../botton/save-on.gif" border="0" name="Image6"></td>

        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../botton/cancel.gif',1)"><img src="../botton/cancel.gif" border="0" name="Image7" alt="執行"></a></td>
        
        <td><a href="<%="calendar.jsp?"%><%="ACTION=Q"%><%="&OPTION=THIS_PAGE"%><%="&THIS_PAGE="+THIS_PAGE%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','../botton/return-over.gif',1)"><img src="../botton/return-on.gif" border="0" name="Image8" alt="返回"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','../botton/newreach.gif',1)"><img src="../botton/newreach.gif" border="0" name="Image10" alt="重新搜尋"></a></td>
        <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','../botton/reach.gif',1)"><img src="../botton/reach.gif" border="0" name="Image9" alt="查詢明細"></a></td>
        
   <!--     <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','../botton/help.gif',1)"><img src="../botton/help.gif" border="0" name="Image11" alt="說明"></a></td>  -->

        </tr>
        </table>
           </form>
        </body>
               
<%        
    }
}
//==================================================================================================
///////////////////刪除客戶資料///////////////////////////////////////////////////////////////////////
//===================================================================================================
////////////   "ACTION=D"  ////////////
if ( bFlag && ACTION.equals("D")){

    YYYY=request.getParameter("YYYY");
    MM=    request.getParameter("MM");


    
        
//=================================================================================
    if (FLOW .equals("DELETE_RECORD")){
        /////////////////  記錄使用者的操作記錄  //////////
        try{
        strSQL="";
        strSQL="DELETE FROM CALENDAR WHERE YYYY='" +YYYY+ "' AND MM='"+MM+"'";
        //out.println("strSQL="+strSQL);
        st.execute(strSQL);
        conn.createStatement().execute("commit");
                
        
        
        
%>
        
        <p>　</p>
        <table width="25%" class="4" border=0 cellspacing=10 cellpadding="0" 

        align="center">
          <tr><td>　</td></tr>
          <tr><td>刪除成功</td></tr>                   
          <tr><td>　</td></tr>
        </table>
        
        <table border=0 cellspacing=0 cellpadding="0" align="center" style="margin-top:10">
          <tr><td>
          <a HREF="<%="calendar.jsp?"%><%="ACTION=Q"%><%="&OPTION=THIS_PAGE"%><%="&THIS_PAGE="+THIS_PAGE%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','../botton/return-over.gif',1)"><img src="../botton/return-on.gif" border="0" name="Image8" alt="返回"></a>
        </td></tr></table>
<%     
    }catch(SQLException e){ 
           if (e.getErrorCode()==17002){
                db.retry();
                System.gc();
                log = "Error Occured,Message="+e.getMessage();
                //out.println(log);
            }
      }
   }
}

//=====================================================================================================
////////////   "ACTION=U"修改客戶資料  ////////////
//=====================================================================================================
    if ( bFlag && ACTION.equals("U")){
    
%>
    <script LANGUAGE="vbscript">
    <!--
    sub dosubmit2( formname )
            window.document.forms(formname).ACTION=window.document.forms(formname).ACTION+"&OPTION=SAVE_RECORD"
            
            window.document.forms(formname).submit
        
    
    end sub
        
    
    -->
    </script>        
<%        
//=====================================================================================================
    if (FLOW.equals("SAVE_RECORD")){
        try{    
        YYYY  = request.getParameter("YYYY");
        //out.println("YYYY="+YYYY);
        MM  = request.getParameter("MM");
        //out.println("MM="+MM);
        
        strSQL = "SELECT * FROM CALENDAR WHERE YYYY='"+YYYY+"' AND MM='"+MM+"'";             
        //out.println("strSQL="+strSQL);
        
        rs = st.executeQuery(strSQL);
        if ( rs!= null ){
            rs.last();
            intCount = rs.getRow();
            rs.first();
        }
            rs.close();
            if ( intCount > 0 ){
            

                
                
                
                strSQL="";
                
                COUNTDAY =request.getParameter("countday");
                //out.println("COUNTDAY="+COUNTDAY);
                COUNTNO=Integer.parseInt(COUNTDAY);
                YYYY  = request.getParameter("YYYY");
                //out.println("YYYY="+YYYY);
                MM  = request.getParameter("MM");
                //out.println("MM="+MM);
                String kk="";
                
                for (i=1;i<=COUNTNO; i++) 
                {
                   
                   kk=Integer.toString(i);
                   //out.println("kk="+kk);
                   //out.println("i="+i);
                   CHECKAry[i] = Util.rtnStr(request.getParameter("check"+kk)); 
                   //out.println("CHECKAry[" + i + "]="+CHECKAry[i]);
                   if (CHECKAry[i].equals("on")){
                       CHECKAry[i]="Y";
                   }else{
                       CHECKAry[i]="N";
                   }
                
                }

                
                if (COUNTNO==28)
                {
           
                    strSQL="UPDATE CALENDAR SET DAY_01='"+CHECKAry[1]+"',"+"DAY_02='"+CHECKAry[2]+"',"+"DAY_03='"+CHECKAry[3]+"',"+"DAY_04='"+CHECKAry[4]+"',"+"DAY_05='"+CHECKAry[5]+"',"+"DAY_06='"+CHECKAry[6]+"',"+"DAY_07='"+CHECKAry[7]+"',"+"DAY_08='"+CHECKAry[8]+"',"+"DAY_09='"+CHECKAry[9]+"',"+"DAY_10='"+CHECKAry[10]+"',"+"DAY_11='"+CHECKAry[11]+"',"+"DAY_12='"+CHECKAry[12]+"',"+"DAY_13='"+CHECKAry[13]+"',"+"DAY_14='"+CHECKAry[14]+"',"+"DAY_15='"+CHECKAry[15]+"',"+"DAY_16='"+CHECKAry[16]+"',"+"DAY_17='"+CHECKAry[17]+"',"+"DAY_18='"+CHECKAry[18]+"',"+"DAY_19='"+CHECKAry[19]+"',"+"DAY_20='"+CHECKAry[20]+"',"+"DAY_21='"+CHECKAry[21]+"',"+"DAY_22='"+CHECKAry[22]+"',"+"DAY_23='"+CHECKAry[23]+"',"+"DAY_24='"+CHECKAry[24]+"',"+"DAY_25='"+CHECKAry[25]+"',"+"DAY_26='"+CHECKAry[26]+"',"+"DAY_27='"+CHECKAry[27]+"',"+"DAY_28='"+CHECKAry[28]+"' WHERE YYYY='"+YYYY+"' AND MM='"+MM+"'";
                }
                else if(COUNTNO==29)
                {
                    strSQL="UPDATE CALENDAR SET DAY_01='"+CHECKAry[1]+"',"+"DAY_02='"+CHECKAry[2]+"',"+"DAY_03='"+CHECKAry[3]+"',"+"DAY_04='"+CHECKAry[4]+"',"+"DAY_05='"+CHECKAry[5]+"',"+"DAY_06='"+CHECKAry[6]+"',"+"DAY_07='"+CHECKAry[7]+"',"+"DAY_08='"+CHECKAry[8]+"',"+"DAY_09='"+CHECKAry[9]+"',"+"DAY_10='"+CHECKAry[10]+"',"+"DAY_11='"+CHECKAry[11]+"',"+"DAY_12='"+CHECKAry[12]+"',"+"DAY_13='"+CHECKAry[13]+"',"+"DAY_14='"+CHECKAry[14]+"',"+"DAY_15='"+CHECKAry[15]+"',"+"DAY_16='"+CHECKAry[16]+"',"+"DAY_17='"+CHECKAry[17]+"',"+"DAY_18='"+CHECKAry[18]+"',"+"DAY_19='"+CHECKAry[19]+"',"+"DAY_20='"+CHECKAry[20]+"',"+"DAY_21='"+CHECKAry[21]+"',"+"DAY_22='"+CHECKAry[22]+"',"+"DAY_23='"+CHECKAry[23]+"',"+"DAY_24='"+CHECKAry[24]+"',"+"DAY_25='"+CHECKAry[25]+"',"+"DAY_26='"+CHECKAry[26]+"',"+"DAY_27='"+CHECKAry[27]+"',"+"DAY_28='"+CHECKAry[28]+"',"+"DAY_29='"+CHECKAry[29]+"' WHERE YYYY='"+YYYY+"' AND MM='"+MM+"'";
                }
                else if(COUNTNO==30)
                {
                    strSQL="UPDATE CALENDAR SET DAY_01='"+CHECKAry[1]+"',"+"DAY_02='"+CHECKAry[2]+"',"+"DAY_03='"+CHECKAry[3]+"',"+"DAY_04='"+CHECKAry[4]+"',"+"DAY_05='"+CHECKAry[5]+"',"+"DAY_06='"+CHECKAry[6]+"',"+"DAY_07='"+CHECKAry[7]+"',"+"DAY_08='"+CHECKAry[8]+"',"+"DAY_09='"+CHECKAry[9]+"',"+"DAY_10='"+CHECKAry[10]+"',"+"DAY_11='"+CHECKAry[11]+"',"+"DAY_12='"+CHECKAry[12]+"',"+"DAY_13='"+CHECKAry[13]+"',"+"DAY_14='"+CHECKAry[14]+"',"+"DAY_15='"+CHECKAry[15]+"',"+"DAY_16='"+CHECKAry[16]+"',"+"DAY_17='"+CHECKAry[17]+"',"+"DAY_18='"+CHECKAry[18]+"',"+"DAY_19='"+CHECKAry[19]+"',"+"DAY_20='"+CHECKAry[20]+"',"+"DAY_21='"+CHECKAry[21]+"',"+"DAY_22='"+CHECKAry[22]+"',"+"DAY_23='"+CHECKAry[23]+"',"+"DAY_24='"+CHECKAry[24]+"',"+"DAY_25='"+CHECKAry[25]+"',"+"DAY_26='"+CHECKAry[26]+"',"+"DAY_27='"+CHECKAry[27]+"',"+"DAY_28='"+CHECKAry[28]+"',"+"DAY_29='"+CHECKAry[29]+"',"+"DAY_30='"+CHECKAry[30]+"' WHERE YYYY='"+YYYY+"' AND MM='"+MM+"'";
                }
                else
                { 
                    
                    
                    
                    strSQL="UPDATE CALENDAR SET DAY_01='"+CHECKAry[1]+"',"+"DAY_02='"+CHECKAry[2]+"',"+"DAY_03='"+CHECKAry[3]+"',"+"DAY_04='"+CHECKAry[4]+"',"+"DAY_05='"+CHECKAry[5]+"',"+"DAY_06='"+CHECKAry[6]+"',"+"DAY_07='"+CHECKAry[7]+"',"+"DAY_08='"+CHECKAry[8]+"',"+"DAY_09='"+CHECKAry[9]+"',"+"DAY_10='"+CHECKAry[10]+"',"+"DAY_11='"+CHECKAry[11]+"',"+"DAY_12='"+CHECKAry[12]+"',"+"DAY_13='"+CHECKAry[13]+"',"+"DAY_14='"+CHECKAry[14]+"',"+"DAY_15='"+CHECKAry[15]+"',"+"DAY_16='"+CHECKAry[16]+"',"+"DAY_17='"+CHECKAry[17]+"',"+"DAY_18='"+CHECKAry[18]+"',"+"DAY_19='"+CHECKAry[19]+"',"+"DAY_20='"+CHECKAry[20]+"',"+"DAY_21='"+CHECKAry[21]+"',"+"DAY_22='"+CHECKAry[22]+"',"+"DAY_23='"+CHECKAry[23]+"',"+"DAY_24='"+CHECKAry[24]+"',"+"DAY_25='"+CHECKAry[25]+"',"+"DAY_26='"+CHECKAry[26]+"',"+"DAY_27='"+CHECKAry[27]+"',"+"DAY_28='"+CHECKAry[28]+"',"+"DAY_29='"+CHECKAry[29]+"',"+"DAY_30='"+CHECKAry[30]+"',"+"DAY_31='"+CHECKAry[31]+"' WHERE YYYY='"+YYYY+"' AND MM='"+MM+"'";
                }
                
                st.execute(strSQL);
                
%>           
                   

             <p>　</p>
            <table width="25%" class="4" border=0 cellspacing=10 cellpadding="0" align="center">
                   <tr><td>　</td></tr>
                   <tr><td>修改成功</td></tr>                   
                   <tr><td>　</td></tr>
              </table>
              <table border=0 cellspacing=0 cellpadding="0" align="center" style="margin-top:10">
                 <tr><td>
                 <a HREF="<%="calendar.jsp?"%><%="ACTION=Q"%><%="&OPTION=THIS_PAGE"%><%="&THIS_PAGE="+THIS_PAGE%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('return','','../botton/return-over.gif',1)"> <img border="0" src="../botton/return-on.gif" name="return" alt="返回"></a>
                 </td></tr>
              </table>
<%       
    
    }
    }catch(SQLException e){ 
           if (e.getErrorCode()==17002){
                db.retry();
                System.gc();
                log = "Error Occured,Message="+e.getMessage();
                //out.println(log);
            }
      }
}    
//=====================================================================================================
//產生修改名細
//=====================================================================================================
    if ( FLOW.equals("VIEW_RECORD") ){
        
       try{    
        YYYY  = request.getParameter("YYYY");
            //out.println("YYYY="+YYYY);
            MM  = request.getParameter("MM");
            //out.println("MM="+MM);
            
            strSQL = "SELECT * FROM CALENDAR WHERE YYYY='"+YYYY+"' AND MM='"+MM+"'";
            //out.println("strSQL="+strSQL);
            
            rs = st.executeQuery(strSQL);
            rs.next();

            if ( rs != null ){
                 
            CHECKAry[1]=Util.rtnStr(rs.getString("DAY_01"));
                if (CHECKAry[1].equals("Y")){
                       CHECKAry[1]="checked";
                }else{
                    CHECKAry[1]="";
                }
                   //out.println("CHECKAry[1]="+CHECKAry[1]);
                CHECKAry[2]=Util.rtnStr(rs.getString("DAY_02"));
                if (CHECKAry[2].equals("Y")){
                       CHECKAry[2]="checked";
                }else{
                    CHECKAry[2]="";
                }
                //out.println("CHECKAry[2]="+CHECKAry[2]);
                CHECKAry[3]=Util.rtnStr(rs.getString("DAY_03"));
                if (CHECKAry[3].equals("Y")){
                       CHECKAry[3]="checked";
                }else{
                    CHECKAry[3]="";
                }
                //out.println("CHECKAry[3]="+CHECKAry[3]);
                CHECKAry[4]=Util.rtnStr(rs.getString("DAY_04"));
                if (CHECKAry[4].equals("Y")){
                       CHECKAry[4]="checked";
                }else{
                    CHECKAry[4]="";
                }
                //out.println("CHECKAry[4]="+CHECKAry[4]);
                CHECKAry[5]=Util.rtnStr(rs.getString("DAY_05"));
                if (CHECKAry[5].equals("Y")){
                       CHECKAry[5]="checked";
                }else{
                    CHECKAry[5]="";
                }
                //out.println("CHECKAry[5]="+CHECKAry[5]);
                CHECKAry[6]=Util.rtnStr(rs.getString("DAY_06"));
                if (CHECKAry[6].equals("Y")){
                       CHECKAry[6]="checked";
                }else{
                    CHECKAry[6]="";
                }
                //out.println("CHECKAry[6]="+CHECKAry[6]);
                CHECKAry[7]=Util.rtnStr(rs.getString("DAY_07"));
                if (CHECKAry[7].equals("Y")){
                       CHECKAry[7]="checked";
                }else{
                    CHECKAry[7]="";
                }
                //out.println("CHECKAry[7]="+CHECKAry[7]);
                CHECKAry[8]=Util.rtnStr(rs.getString("DAY_08"));
                if (CHECKAry[8].equals("Y")){
                       CHECKAry[8]="checked";
                }else{
                    CHECKAry[8]="";
                }
                //out.println("CHECKAry[8]="+CHECKAry[8]);
                CHECKAry[9]=Util.rtnStr(rs.getString("DAY_09"));
                if (CHECKAry[9].equals("Y")){
                       CHECKAry[9]="checked";
                }else{
                    CHECKAry[9]="";
                }
                //out.println("CHECKAry[9]="+CHECKAry[9]);
                CHECKAry[10]=Util.rtnStr(rs.getString("DAY_10"));
                if (CHECKAry[10].equals("Y")){
                       CHECKAry[10]="checked";
                }else{
                    CHECKAry[10]="";
                }
                //out.println("CHECKAry[10]="+CHECKAry[10]);
                CHECKAry[11]=Util.rtnStr(rs.getString("DAY_11"));
                if (CHECKAry[11].equals("Y")){
                       CHECKAry[11]="checked";
                }else{
                    CHECKAry[11]="";
                }
                //out.println("CHECKAry[11]="+CHECKAry[11]);
                CHECKAry[12]=Util.rtnStr(rs.getString("DAY_12"));
                if (CHECKAry[12].equals("Y")){
                       CHECKAry[12]="checked";
                }else{
                    CHECKAry[12]="";
                }
                //out.println("CHECKAry[12]="+CHECKAry[12]);
                CHECKAry[13]=Util.rtnStr(rs.getString("DAY_13"));
                if (CHECKAry[13].equals("Y")){
                       CHECKAry[13]="checked";
                }else{
                    CHECKAry[13]="";
                }
                //out.println("CHECKAry[13]="+CHECKAry[13]);
                CHECKAry[14]=Util.rtnStr(rs.getString("DAY_14"));
                if (CHECKAry[14].equals("Y")){
                       CHECKAry[14]="checked";
                }else{
                    CHECKAry[14]="";
                }
                //out.println("CHECKAry[14]="+CHECKAry[14]);
                CHECKAry[15]=Util.rtnStr(rs.getString("DAY_15"));
                if (CHECKAry[15].equals("Y")){
                       CHECKAry[15]="checked";
                }else{
                    CHECKAry[15]="";
                }
                //out.println("CHECKAry[15]="+CHECKAry[15]);
                CHECKAry[16]=Util.rtnStr(rs.getString("DAY_16"));
                if (CHECKAry[16].equals("Y")){
                       CHECKAry[16]="checked";
                }else{
                    CHECKAry[16]="";
                }
                //out.println("CHECKAry[16]="+CHECKAry[16]);
                CHECKAry[17]=Util.rtnStr(rs.getString("DAY_17"));
                if (CHECKAry[17].equals("Y")){
                       CHECKAry[17]="checked";
                }else{
                    CHECKAry[17]="";
                }
                //out.println("CHECKAry[17]="+CHECKAry[17]);
                CHECKAry[18]=Util.rtnStr(rs.getString("DAY_18"));
                if (CHECKAry[18].equals("Y")){
                       CHECKAry[18]="checked";
                }else{
                    CHECKAry[18]="";
                }
                //out.println("CHECKAry[18]="+CHECKAry[18]);
                CHECKAry[19]=Util.rtnStr(rs.getString("DAY_19"));
                if (CHECKAry[19].equals("Y")){
                       CHECKAry[19]="checked";
                }else{
                    CHECKAry[19]="";
                }
                //out.println("CHECKAry[19]="+CHECKAry[19]);
                CHECKAry[20]=Util.rtnStr(rs.getString("DAY_20"));
                if (CHECKAry[20].equals("Y")){
                       CHECKAry[20]="checked";
                }else{
                    CHECKAry[20]="";
                }
                //out.println("CHECKAry[20]="+CHECKAry[20]);
                CHECKAry[21]=Util.rtnStr(rs.getString("DAY_21"));
                if (CHECKAry[21].equals("Y")){
                       CHECKAry[21]="checked";
                }else{
                    CHECKAry[21]="";
                }
                //out.println("CHECKAry[21]="+CHECKAry[21]);
                CHECKAry[22]=Util.rtnStr(rs.getString("DAY_22"));
                if (CHECKAry[22].equals("Y")){
                       CHECKAry[22]="checked";
                }else{
                    CHECKAry[22]="";
                }
                //out.println("CHECKAry[22]="+CHECKAry[22]);
                CHECKAry[23]=Util.rtnStr(rs.getString("DAY_23"));
                if (CHECKAry[23].equals("Y")){
                       CHECKAry[23]="checked";
                }else{
                    CHECKAry[23]="";
                }
                //out.println("CHECKAry[23]="+CHECKAry[23]);
                CHECKAry[24]=Util.rtnStr(rs.getString("DAY_24"));
                if (CHECKAry[24].equals("Y")){
                       CHECKAry[24]="checked";
                }else{
                    CHECKAry[24]="";
                }
                //out.println("CHECKAry[24]="+CHECKAry[24]);
                CHECKAry[25]=Util.rtnStr(rs.getString("DAY_25"));
                if (CHECKAry[25].equals("Y")){
                       CHECKAry[25]="checked";
                }else{
                    CHECKAry[25]="";
                }
                //out.println("CHECKAry[25]="+CHECKAry[25]);
                CHECKAry[26]=Util.rtnStr(rs.getString("DAY_26"));
                if (CHECKAry[26].equals("Y")){
                       CHECKAry[26]="checked";
                }else{
                    CHECKAry[26]="";
                }
                //out.println("CHECKAry[26]="+CHECKAry[26]);
                CHECKAry[27]=Util.rtnStr(rs.getString("DAY_27"));
                if (CHECKAry[27].equals("Y")){
                       CHECKAry[27]="checked";
                }else{
                    CHECKAry[27]="";
                }
                //out.println("CHECKAry[27]="+CHECKAry[27]);
                CHECKAry[28]=Util.rtnStr(rs.getString("DAY_28"));
                if (CHECKAry[28].equals("Y")){
                       CHECKAry[28]="checked";
                }else{
                    CHECKAry[28]="";
                }
                //out.println("CHECKAry[28]="+CHECKAry[28]);
                CHECKAry[29]=Util.rtnStr(rs.getString("DAY_29"));
                if (CHECKAry[29].equals("Y")){
                       CHECKAry[29]="checked";
                }else{
                    CHECKAry[29]="";
                }
                //out.println("CHECKAry[29]="+CHECKAry[29]);
                CHECKAry[30]=Util.rtnStr(rs.getString("DAY_30"));
                if (CHECKAry[30].equals("Y")){
                       CHECKAry[30]="checked";
                }else{
                    CHECKAry[30]="";
                }
                //out.println("CHECKAry[30]="+CHECKAry[30]);
                CHECKAry[31]=Util.rtnStr(rs.getString("DAY_31"));
                if (CHECKAry[31].equals("Y")){
                       CHECKAry[31]="checked";
                }else{
                    CHECKAry[31]="";
                }
                //out.println("CHECKAry[31]="+CHECKAry[31]);

  


%>    
                  
            <form ID="FORM1" NAME="FORM1" METHOD="POST" ACTION="<%="calendar.jsp?"%><%="ACTION=U"%><%="&THIS_PAGE="+THIS_PAGE%>">
            <table border=0 cellspacing=0 cellpadding="0" align="center" style="margin-top:25">
            <tr>
            <td><img src="../botton/modify-on.gif" align="absMiddle">&nbsp;<B>行事曆設定</B></td>
            </tr>
            </table>

            <table border=0 class="1" width=57% cellspacing="0" cellpadding="0" align="center" style="margin-top:7">
            <tr> 
            <td class="f1" style="width:140">減價年月</td>
            <td class="f2" style="width:18"></td>
            <td class="f2" style="width:50"><input class="i3" size=10 NAME="YYYY" value="<%=rs.getString("YYYY")%>" readonly></td>
            <td class="f2" style="width:50">年</td>
            <td class="f2" style="width:50"><input class="i3" size=5  NAME="MM" value="<%=rs.getString("MM")%>" readonly></td>
            <td class="f2">月</td>
            </tr>
            </table>


            
            
            <table border=0 class="2" width=57% cellspacing="2" cellpadding="2" align="center" style="margin-top:-1">
            <tr>
            <td class="i1">日</td>
            <td class="i1">一</td>
            <td class="i1">二</td>
            <td class="i1">三</td>
            <td class="i1">四</td>
            <td class="i1">五</td>
            <td class="i1">六</td>
            </tr>
            <input type="hidden" name="c1" value=<%=CHECKAry[1]%>>
            <input type="hidden" name="c2" value=<%=CHECKAry[2]%>>
            <input type="hidden" name="c3" value=<%=CHECKAry[3]%>>
            <input type="hidden" name="c4" value=<%=CHECKAry[4]%>>
            <input type="hidden" name="c5" value=<%=CHECKAry[5]%>>
            <input type="hidden" name="c6" value=<%=CHECKAry[6]%>>
            <input type="hidden" name="c7" value=<%=CHECKAry[7]%>>
            <input type="hidden" name="c8" value=<%=CHECKAry[8]%>>
            <input type="hidden" name="c9" value=<%=CHECKAry[9]%>>
            <input type="hidden" name="c10" value=<%=CHECKAry[10]%>>
            <input type="hidden" name="c11" value=<%=CHECKAry[11]%>>
            <input type="hidden" name="c12" value=<%=CHECKAry[12]%>>
            <input type="hidden" name="c13" value=<%=CHECKAry[13]%>>
            <input type="hidden" name="c14" value=<%=CHECKAry[14]%>>
            <input type="hidden" name="c15" value=<%=CHECKAry[15]%>>
            <input type="hidden" name="c16" value=<%=CHECKAry[16]%>>
            <input type="hidden" name="c17" value=<%=CHECKAry[17]%>>
            <input type="hidden" name="c18" value=<%=CHECKAry[18]%>>
            <input type="hidden" name="c19" value=<%=CHECKAry[19]%>>
            <input type="hidden" name="c20" value=<%=CHECKAry[20]%>>
            <input type="hidden" name="c21" value=<%=CHECKAry[21]%>>
            <input type="hidden" name="c22" value=<%=CHECKAry[22]%>>
            <input type="hidden" name="c23" value=<%=CHECKAry[23]%>>
            <input type="hidden" name="c24" value=<%=CHECKAry[24]%>>
            <input type="hidden" name="c25" value=<%=CHECKAry[25]%>>
            <input type="hidden" name="c26" value=<%=CHECKAry[26]%>>
            <input type="hidden" name="c27" value=<%=CHECKAry[27]%>>
            <input type="hidden" name="c28" value=<%=CHECKAry[28]%>>
            <input type="hidden" name="c29" value=<%=CHECKAry[29]%>>
            <input type="hidden" name="c30" value=<%=CHECKAry[30]%>>
            <input type="hidden" name="c31" value=<%=CHECKAry[31]%>>
            <SCRIPT LANGUAGE="vbScript">
            <!--
        
            yyyy=document.FORM1.YYYY.value
            mm=document.FORM1.MM.value
            dim cc
            redim cc(31)
            
            cc(1)=document.FORM1.c1.value
            'alert(cc(1))
            cc(2)=document.FORM1.c2.value
            cc(3)=document.FORM1.c3.value
            cc(4)=document.FORM1.c4.value
            cc(5)=document.FORM1.c5.value
            cc(6)=document.FORM1.c6.value
            cc(7)=document.FORM1.c7.value
            cc(8)=document.FORM1.c8.value
            cc(9)=document.FORM1.c9.value
            cc(10)=document.FORM1.c10.value
            cc(11)=document.FORM1.c11.value
            cc(12)=document.FORM1.c12.value
            cc(13)=document.FORM1.c13.value
            cc(14)=document.FORM1.c14.value
            cc(15)=document.FORM1.c15.value
            cc(16)=document.FORM1.c16.value
            cc(17)=document.FORM1.c17.value
            cc(18)=document.FORM1.c18.value
            cc(19)=document.FORM1.c19.value
            cc(20)=document.FORM1.c20.value
            cc(21)=document.FORM1.c21.value
            cc(22)=document.FORM1.c22.value
            cc(23)=document.FORM1.c23.value
            cc(24)=document.FORM1.c24.value
            cc(25)=document.FORM1.c25.value
            cc(26)=document.FORM1.c26.value
            cc(27)=document.FORM1.c27.value
            cc(28)=document.FORM1.c28.value
            cc(29)=document.FORM1.c29.value
            cc(30)=document.FORM1.c30.value
            cc(31)=document.FORM1.c31.value
            
            
            aaa = yyyy+"/"+mm+"/1"
            dim mon
            dim w
            dim d
            dim pw 
            dim mon2
            dim    countday
            mon=Month(aaa)
            mon2=Month(aaa)
            i=1
            pw=DatePart("w",aaa)
            'alert(pw)
            do             
                if i=1 then
                        w=DatePart("w",aaa)
                        'alert(w)
                        document.write "<tr>"
                    
                       for j=1 to w-1
                           document.write "<td class=""i1"">" 
                           document.write ""
                           document.write "</td>"
                       next
                    d=DatePart("d",aaa)
                    document.write "<td class=""i1"">"
                    document.write "<input type=""checkbox"" name=""check"& i &""""&cc(1)&" >"
                    document.write d & "&nbsp;"
                    document.write "</td>"
                    if (pw=7) then
                       document.write "</tr>"
                       document.write "<tr>"
                    end if
                else
                
                     mon2 = DateAdd("d",1,aaa)

                     if (Month(mon2)=mon) then
                         aaa = mon2
                         w=DatePart("w",aaa)
                         d=DatePart("d",aaa)
                        
                             document.write "<td class=""i1"">"
                             document.write "<input type=""checkbox""  name=""check"& i &""""& cc(i) & ">"
                             document.write d & "&nbsp;"
                             document.write "</td>"
                             if i=(8-pw) Or i=(15-pw) Or i=(22-pw) Or i=(29-pw) Or i=(36-pw) Or i=(43-pw) then
                                document.write "</tr>"
                                document.write "<tr>"
                             end if
                            
                             


                     else
                          exit do
                     end if
                end if
                i=i+1
            loop  
                
                document.write "<input type=""hidden"" name=""countday"" value="&i-1&" >"
            //-->
            </SCRIPT>
            </table>

                      
            <table border="0" cellspacing="0" cellpadding="0" align=center style="margin-top:10">
            <tr> 
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../botton/first.gif',1)"><img src="../botton/first.gif" border="0" name="Image1" alt="第一頁"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../botton/up.gif',1)"><img src="../botton/up.gif" border="0" name="Image2" alt="上一頁"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../botton/down.gif',1)"><img src="../botton/down.gif" border="0" name="Image3" alt="下一頁"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../botton/last.gif',1)"><img src="../botton/last.gif" border="0" name="Image4" alt="最後頁"></a></td>

            <td>&nbsp;&nbsp;&nbsp;</td>

            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','../botton/plus.gif',1)"><img src="../botton/plus.gif" border="0" name="Image5" alt="新增"></a></td>

           <td><img onclick="dosubmit2(&quot;form1&quot;)"onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../botton/save-over.gif',1)" alt="儲存" src="../botton/save-on.gif" border="0" name="Image6"></td>

          

           <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../botton/cancel.gif',1)"><img src="../botton/cancel.gif" border="0" name="Image7" alt="執行"></a></td>
        
           <td><a href="<%="calendar.jsp?"%><%="ACTION=Q"%><%="&OPTION=THIS_PAGE"%><%="&THIS_PAGE="+THIS_PAGE%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','../botton/return-over.gif',1)"><img src="../botton/return-on.gif" border="0" name="Image8" alt="返回"></a></td>
           <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','../botton/newreach.gif',1)"><img src="../botton/newreach.gif" border="0" name="Image10" alt="重新搜尋"></a></td>
           <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','../botton/reach.gif',1)"><img src="../botton/reach.gif" border="0" name="Image9" alt="查詢明細"></a></td>
        
      <!-- <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','../botton/help.gif',1)"><img src="../botton/help.gif" border="0" name="Image11" alt="說明"></a></td>-->

           </tr>
           </table>    
           </form>
            
<%
        }
        rs.close();
        }catch(SQLException e){ 
           if (e.getErrorCode()==17002){
                db.retry();
                System.gc();
                log = "Error Occured,Message="+e.getMessage();
                //out.println(log);
            }
      }
    }
}
//=====================================================================================================
                               

conn.createStatement().execute("commit");
//修改客戶資料結束

st.close();
conn.close();
conn = null;
System.gc();
//ia.pConn.close(); 
%>
