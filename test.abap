******&---------------------------------------------------------------------*
******& Report ZSXKTEST001
******&---------------------------------------------------------------------*
******&
******&---------------------------------------------------------------------*
REPORT zsxktest001.
*
INCLUDE zsxktest001top.
INCLUDE zsxktest001f01.
*
*
START-OF-SELECTION.
  PERFORM get_file_content.
  PERFORM post_sftp_test.
*
*
*
*
*
*
*
*****
*****  TEST1 GET EXCLE TO DOWNLOAD OR TRANS
**
**DATA: lo_excel                TYPE REF TO zcl_excel,
**      lo_excel_writer         TYPE REF TO zif_excel_writer,
**      lo_worksheet            TYPE REF TO zcl_excel_worksheet,
**      lv_style_bold_border_guid TYPE zexcel_cell_style,
**      lo_style_bold_border TYPE REF TO zcl_excel_style,
**      lo_border_dark TYPE REF TO zcl_excel_style_border.
**
**DATA: lv_file                 TYPE xstring,
**      lv_bytecount            TYPE i,
**      lt_file_tab             TYPE solix_tab.
**
**DATA: lv_full_path      TYPE string,
**      lv_workdir        TYPE string,
**      lv_file_separator TYPE c.
**
**CONSTANTS: lv_default_file_name TYPE string VALUE 'MergedCells.xlsx'.
**
**PARAMETERS: p_path TYPE String.
**
**AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_path.
**  lv_workdir = p_path.
**  cl_gui_frontend_services=>directory_browse( EXPORTING initial_folder  = lv_workdir
**                                              CHANGING  selected_folder = lv_workdir ).
**  p_path = lv_workdir.
**
**INITIALIZATION.
**  cl_gui_frontend_services=>get_sapgui_workdir( CHANGING sapworkdir = lv_workdir ).
**  cl_gui_cfw=>flush( ).
**  p_path = lv_workdir.
**
**START-OF-SELECTION.
**
**  IF p_path IS INITIAL.
**    p_path = lv_workdir.
**  ENDIF.
**  cl_gui_frontend_services=>get_file_separator( CHANGING file_separator = lv_file_separator ).
**  CONCATENATE p_path lv_file_separator lv_default_file_name INTO lv_full_path.
**
**  CREATE OBJECT lo_excel.
**
**  " Get active sheet
**  lo_worksheet = lo_excel->get_active_worksheet( ).
**  lo_worksheet->set_title( 'sheet1' ).
**
**  CREATE OBJECT lo_border_dark.
**  lo_border_dark->border_color-rgb = zcl_excel_style_color=>c_black.
**  lo_border_dark->border_style = zcl_excel_style_border=>c_border_thin.
**
**  lo_style_bold_border = lo_excel->add_new_style( ).
**  lo_style_bold_border->font->bold = abap_true.
**  lo_style_bold_border->font->italic = abap_false.
**  lo_style_bold_border->font->color-rgb = zcl_excel_style_color=>c_black.
**  lo_style_bold_border->alignment->horizontal = zcl_excel_style_alignment=>c_horizontal_center.
**  lo_style_bold_border->borders->allborders = lo_border_dark.
**  lv_style_bold_border_guid = lo_style_bold_border->get_guid( ).
**
**  lo_worksheet->set_cell( ip_row = 2 ip_column = 'A' ip_value = 'Test' ).
**
**  lo_worksheet->set_cell( ip_row = 2 ip_column = 'B' ip_value = 'Banana' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 2 ip_column = 'C' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 2 ip_column = 'D' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 2 ip_column = 'E' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 2 ip_column = 'F' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 2 ip_column = 'G' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 4 ip_column = 'B' ip_value = 'Apple' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 4 ip_column = 'C' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 4 ip_column = 'D' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 4 ip_column = 'E' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 4 ip_column = 'F' ip_value = '' ip_style = lv_style_bold_border_guid ).
**  lo_worksheet->set_cell( ip_row = 4 ip_column = 'G' ip_value = '' ip_style = lv_style_bold_border_guid ).
**
***  lo_worksheet->set_merge( ip_row = 4 ip_column_start = 'B' ip_column_end = 'G' ).
***  lo_worksheet->set_merge( ip_row = 6 ip_column_start = 'B' ip_column_end = 'G' ).
***
***  " Test also if merge works when oher merged chells are empty
***  lo_worksheet->set_cell( ip_row = 6 ip_column = 'B' ip_value = 'Tomato' ).
***  lo_worksheet->set_merge( ip_row = 6 ip_column_start = 'B' ip_column_end = 'G' ).
***
***  " Test the patch provided by Victor Alekhin to merge cells in one column
***  lo_worksheet->set_cell(  ip_row = 8 ip_column       = 'B' ip_value = 'Merge cells also over multiple rows by Victor Alekhin' ).
***  lo_worksheet->set_merge( ip_row = 8 ip_column_start = 'B' ip_column_end = 'G' ip_row_to = 10 ).
**
**  CREATE OBJECT lo_excel_writer TYPE zcl_excel_writer_2007.
**  lv_file = lo_excel_writer->write_file( lo_excel ).
**
**  " Convert to binary
**  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
**    EXPORTING
**      buffer        = lv_file
**    IMPORTING
**      output_length = lv_bytecount
**    TABLES
**      binary_tab    = lt_file_tab.
***  " This method is only available on AS ABAP > 6.40
***  lt_file_tab = cl_bcs_convert=>xstring_to_solix( iv_xstring  = lv_file ).
***  lv_bytecount = xstrlen( lv_file ).
**
**  " Save the file
**  cl_gui_frontend_services=>gui_download( EXPORTING bin_filesize = lv_bytecount
**                                                    filename     = lv_full_path
**                                                    filetype     = 'BIN'
**                                           CHANGING data_tab     = lt_file_tab ).
****
****
****
*****
******
******DATA: o_excel      TYPE OLE2_OBJECT,
******      o_workbook   TYPE OLE2_OBJECT,
******      o_worksheet  TYPE OLE2_OBJECT.
******
******CREATE OBJECT o_excel 'Excel.Application'.
******CREATE OBJECT o_workbook 'Excel.Workbook' .
******CREATE OBJECT o_worksheet 'Excel.Worksheet' .
******
******CALL METHOD OF o_worksheet 'Cells'
******  EXPORTING
******    #1 = 1
******    #2 = 1
******    #3 = 'Hello, World!'.
******
******CALL METHOD OF o_excel 'SaveAs'
******  EXPORTING #1 = 'C:\Users\Z22080010\Desktop\test\test.xlsx'.
******
******CALL METHOD OF o_excel 'Quit'.
******
******FREE OBJECT o_excel.
******FREE OBJECT o_workbook.
******FREE OBJECT o_worksheet.
*****
*****
*****
*****
******// test ole
*****
******TYPE-POOLS: soi,ole2.
******DATA:  lo_application   TYPE  ole2_object,
******       lo_workbook      TYPE  ole2_object,
******       lo_workbooks     TYPE  ole2_object,
******       lo_range         TYPE  ole2_object,
******       lo_worksheet     TYPE  ole2_object,
******       lo_worksheets    TYPE  ole2_object,
******       lo_column        TYPE  ole2_object,
******       lo_row           TYPE  ole2_object,
******       lo_cell          TYPE  ole2_object,
******       lo_font          TYPE ole2_object.
******
******  DATA: lo_cellstart      TYPE ole2_object,
******        lo_cellend        TYPE ole2_object,
******        lo_selection      TYPE ole2_object,
******        lo_validation     TYPE ole2_object.
******
******  DATA: lv_selected_folder TYPE string,
******        lv_complete_path   TYPE char256,
******        lv_titulo          TYPE string,
******        lv_xstring         TYPE xstring.
******
******    CALL METHOD cl_gui_frontend_services=>directory_browse
******      EXPORTING
******        window_title    = lv_titulo
******        initial_folder  = 'C:\Users\Z22080010\Desktop\test'
******      CHANGING
******        selected_folder = lv_selected_folder
******      EXCEPTIONS
******        cntl_error      = 1
******        error_no_gui    = 2
******        OTHERS          = 3.
******  CHECK NOT lv_selected_folder IS INITIAL.
******
******  CREATE OBJECT lo_application 'Excel.Application'.
******  CALL METHOD OF lo_application 'Workbooks' = lo_workbooks.
******  CALL METHOD OF lo_workbooks 'Add' = lo_workbook.
******  SET PROPERTY OF lo_application 'Visible' = 0.
******  GET PROPERTY OF lo_application 'ACTIVESHEET' = lo_worksheet.
******
******  CALL METHOD OF lo_worksheet 'Cells' = lo_cell
******    EXPORTING
******    #1 = 1  "Row
******    #2 = 2. "Column
******
******SET PROPERTY OF lo_cell 'Value' = 'Hello World'.
******
*******
******* ----------
******* ---- PASTE HERE THE CODE
******* ----------
******
******
******CONCATENATE lv_selected_folder '\Test' INTO lv_complete_path.
******
******  CALL METHOD OF lo_workbook 'SaveAs'
******    EXPORTING
******    #1 = lv_complete_path.
******  IF sy-subrc EQ 0.
******     MESSAGE 'File downloaded successfully' TYPE 'S'.
******  ELSE.
******     MESSAGE 'Error downloading the file' TYPE 'E'.
******  ENDIF.
******
******  CALL METHOD OF lo_application 'QUIT'.
******
******TRY.
******    CALL FUNCTION 'WWWDATA_OLE2_CONVERT_TO_SXSTRING'
******      EXPORTING
******        i_ole2_stream  = lo_application
******      IMPORTING
******        e_sx_data      = lv_xstring.
******  CATCH cx_root INTO DATA(cx_root).
******    " 处理异常
******ENDTRY.
******
******CONCATENATE lv_selected_folder '\Test' INTO lv_complete_path.
******
******  CALL METHOD OF lo_workbook 'SaveAs'
******    EXPORTING
******    #1 = lv_complete_path.
******  IF sy-subrc EQ 0.
******     MESSAGE 'File downloaded successfully' TYPE 'S'.
******  ELSE.
******     MESSAGE 'Error downloading the file' TYPE 'E'.
******  ENDIF.
******
******  CALL METHOD OF lo_application 'QUIT'.
******
******
******
******  FREE OBJECT lo_worksheet.
******  FREE OBJECT lo_workbook.
******  FREE OBJECT lo_application.
*****
*****
*****
******  DATA: lv_filename TYPE string,
******      lv_xstring  TYPE xstring,
******      lv_size     TYPE i.
******
******lv_filename = 'C:\path\to\your\file.txt'. " 替换为你的文件路径
******
******CALL METHOD cl_gui_frontend_services=>file_get_size
******  EXPORTING
******    file_name                = lv_filename.
******
******
******IF sy-subrc <> 0.
******  " 错误处理
******ENDIF.
******
*******CALL METHOD cl_gui_frontend_services=>read_file
******  EXPORTING
******    filename                = lv_filename
******    filetype                = 'BIN'
******  IMPORTING
******    filelength              = lv_size
******    data_tab                = lv_xstring
******  EXCEPTIONS
******    file_open_error         = 1s
******    file_read_error         = 2
******    no_batch                = 3
******    gui_refuse_filetransfer = 4
******    invalid_type            = 5
******    no_authority            = 6
******    unknown_error           = 7
******    bad_pathname            = 8
******    file_not_found          = 9
******    path_not_found          = 10
******    file_extension_unknown  = 11.
******
******IF sy-subrc <> 0.
******  " 错误处理
******ENDIF.
*****
*****" 此时lv_xstring包含了文件的内容
****
****
*****DATA: lv_row TYPE i VALUE 2,
*****        lv_column TYPE string,
*****        l_char    TYPE c,
*****        lv_value TYPE string.
*****
*****
***** DO 6 TIMES.
*****    l_char = cl_abap_conv_in_ce=>uccp( lv_row ).
*****    WRITE lv_row .
*****    WRITE lv_column.
*****  ENDDO.
****
*****DATA:lv_cs       TYPE c LENGTH 4,
*****     lv_bcs      TYPE i,
*****     lv_err_text TYPE string,
*****     lr_error    TYPE REF TO cx_root,
*****     lv_cj       TYPE i.
***** TRY.
*****      lv_cj = lv_cs * lv_bcs.
*****      CLEAR lv_err_text.
*****    CATCH cx_root INTO lr_error.
*****      lv_err_text = lr_error->get_text( ).
*****  ENDTRY.
*****  IF lv_err_text IS NOT INITIAL.
*****    MESSAGE s000(oo) WITH lv_err_text DISPLAY LIKE 'E'.
*****    WRITE:/ lv_err_text.
*****  ELSE.
*****    WRITE:/ '执行成功'.
*****  ENDIF.
***
***
***
***
***
***
****test1
***
****DATA: lv_xml_string TYPE string,
****      lv_xstring    TYPE xstring.
****
****DATA: lv_file                 TYPE xstring,
****      lv_bytecount            TYPE i,
****      lt_file_tab             TYPE solix_tab.
****
****lv_xml_string = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' &&
****                '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' &&
****                '  <sheetData>' &&
****                '    <row r="1">' &&
****                '      <c r="A1" t="inlineStr">' &&
****                '        <is>' &&
****                '          <t>Hello, World!</t>' &&
****                '        </is>' &&
****                '      </c>' &&
****                '    </row>' &&
****                '  </sheetData>' &&
****                '</worksheet>'.
****
****CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
****  EXPORTING
****    text   = lv_xml_string
****  IMPORTING
****    buffer = lv_xstring.
****
****lv_bytecount = xstrlen( lv_xstring ).
****
****  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
****    EXPORTING
****      buffer        = lv_xstring
****    IMPORTING
****      output_length = lv_bytecount
****    TABLES
****      binary_tab    = lt_file_tab.
****
*****CALL FUNCTION 'GUI_DOWNLOAD'
*****  EXPORTING
*****    filename = 'C:\Users\Z22080010\Desktop\test\testxk.xlsx'
*****    filetype = 'BIN'
*****  CHANGING
*****    data_tab = lv_xstring.
****
****lt_file_tab = cl_bcs_convert=>xstring_to_solix( iv_xstring  = lv_file ).
****
****
****
****  cl_gui_frontend_services=>gui_download( EXPORTING bin_filesize = lv_bytecount
****                                                    filename     = 'C:\Users\Z22080010\Desktop\test\testxk.xlsx'
****                                                    filetype     = 'BIN'
****                                           CHANGING data_tab     = lt_file_tab ).
**
**
**
**
**
**
***
***DATA: lv_xml_string TYPE string,
***      lv_xstring    TYPE xstring.
***
***lv_xml_string = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' &&
***                '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' &&
***                '  <sheetData>' &&
***                '    <row r="1">' &&
***                '      <c r="A1" t="inlineStr">' &&
***                '        <is>' &&
***                '          <t>Hello, World!</t>' &&
***                '        </is>' &&
***                '      </c>' &&
***                '    </row>' &&
***                '  </sheetData>' &&
***                '</worksheet>'.
***
***CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
***  EXPORTING
***    text   = lv_xml_string
***    mimesubtype = 'xml'
***  IMPORTING
***    buffer = lv_xstring.
***
***CALL FUNCTION 'GUI_DOWNLOAD'
***  EXPORTING
***    filename = 'C:\path\to\your\file.xlsx'
***    filetype = 'BIN'
***  CHANGING
***    data_tab = lv_xstring.
*
*
*
**DATA: ls_sflight TYPE sflight.
**
**FIELD-SYMBOLS: <fs> TYPE any,
**               <fs_field> TYPE any.
**
**ls_sflight-carrid = 'AA'.
**ls_sflight-connid = '0017'.
**ls_sflight-fldate = '20211231'.
**
**ASSIGN ls_sflight TO <fs>.
**
**DO.
**  ASSIGN COMPONENT sy-index OF STRUCTURE <fs> TO <fs_field>.
**  IF sy-subrc <> 0.
**    EXIT.
**  ENDIF.
**
**  WRITE: / 'Field', sy-index, 'value is', <fs_field>.
**ENDDO.
**
**
**TABLES: lfa1,lfb1,lfm1.
**DATA: BEGIN OF it_general OCCURS 0,
**        lifnr      LIKE lfa1-lifnr,
**        ktokk      LIKE lfa1-ktokk,
**        kunnr      LIKE lfa1-kunnr,
**        name1      LIKE adrc-name1,
**        name2      LIKE adrc-name2,
**        name3      LIKE adrc-name3,
**        name4      LIKE adrc-name4,
**        str_suppl1 LIKE adrc-str_suppl1,
**        str_suppl2 LIKE adrc-str_suppl2,
**        str_suppl3 LIKE adrc-str_suppl3,
**        sort1      LIKE adrc-sort1,
**        sort2      LIKE adrc-sort2,
**        post_code1 LIKE adrc-post_code1,
**        land1      LIKE lfa1-land1,
**        spras      LIKE lfa1-spras,
**        stceg      LIKE lfa1-stceg,
**        stcd1      LIKE lfa1-stcd1,
**        city1      LIKE adrc-city1,
**        region     LIKE adrc-region,
**        telf1      LIKE lfa1-telf1,
**        telfx      LIKE lfa1-telfx,
**        vbund      LIKE lfa1-vbund,
**        konzs      LIKE lfa1-konzs,
**      END OF it_general.
**
**DATA: lo_alv TYPE REF TO cl_salv_table,
**          lt_file_tab             TYPE solix_tab,
**            l_size       TYPE i,
**      lv_xml TYPE xstring,
**      lv_file_name TYPE string.
**
**
**SELECT *
**    INTO CORRESPONDING FIELDS OF TABLE it_general
**    FROM lfa1.
**
**CALL METHOD cl_salv_table=>factory
**  IMPORTING
**    r_salv_table = lo_alv
**  CHANGING
**    t_table      = it_general[].
**
***CALL METHOD lo_alv->to_xml
***  EXPORTING
***    XML_type = if_salv_bs_xml=>c_type_xlsx
***  CHANGING
***    r_result = lv_xml.
**
**DATA(l_xstr) = lo_alv->to_xml( if_salv_bs_xml=>c_type_xlsx ).
**
**l_size = xstrlen( l_xstr ).
**
** CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
**        EXPORTING
**          buffer        = l_xstr
**        IMPORTING
**          output_length = L_size
**        TABLES
**          binary_tab    = lt_file_tab.
**
**lv_file_name = 'C:\Users\Z22080010\Desktop\test\report.xlsx'.
**
**CALL METHOD cl_gui_frontend_services=>gui_download
**  EXPORTING
**    bin_filesize = xstrlen( lv_xml )
**    filename     = lv_file_name
**    filetype     = 'BIN'
**  CHANGING
**    data_tab     = lt_file_tab.
*
*
**DATA: wa like mara.
**
**SELECT * FROM mara INTO CORRESPONDING FIELDS OF wa .
**ENDSELECT.

*DATA: l_flag TYPE string VALUE 'test@.sadas@test'.
*
*FIND REGEX '@[^;]*@' IN l_flag.
*
*IF sy-subrc = 0.
*  WRITE: / 'Please user ; to split mail address!'.
*ENDIF.


*DATA: lv_host     TYPE string VALUE 'ftp.example.com',
*      lv_user     TYPE string VALUE 'ftpuser',
*      lv_password TYPE string VALUE 'ftppassword',
*      lv_filename TYPE string VALUE '/path/to/local/file.txt',
*      lv_ftp_path TYPE string VALUE '/remote/path/file.txt',
*      lv_conn     TYPE i,
*      lv_rc       TYPE i.
*
*" 建立 FTP 连接
*CALL FUNCTION 'FTP_CONNECT'
*  EXPORTING
*    user       = lv_user
*    password   = lv_password
*    host       = lv_host
*  IMPORTING
*    handle     = lv_conn
*  EXCEPTIONS
*    tcpip_error = 1
*    command_error = 2
*    OTHERS     = 3.
*
*IF sy-subrc <> 0.
*  " 错误处理
*  WRITE: / '连接失败'.
*  EXIT.
*ENDIF.
*
*" 发送文件
*CALL FUNCTION 'FTP_PUT'
*  EXPORTING
*    handle           = lv_conn
*    filename         = lv_filename
*    r3_name          = lv_ftp_path
*  EXCEPTIONS
*    tcpip_error      = 1
*    command_error    = 2
*    data_error       = 3
*    OTHERS           = 4.
*
*IF sy-subrc <> 0.
*  " 错误处理
*  WRITE: / '文件传输失败'.
*ELSE.
*  WRITE: / '文件成功传输到 FTP 服务器'.
*ENDIF.
*
*" 关闭 FTP 连接
*CALL FUNCTION 'FTP_DISCONNECT'
*  EXPORTING
*    handle = lv_conn.


*DATA: lv_file_name TYPE string VALUE '/interface/wcqfp/F715_Supply_Pool_20240704100630410.zip', " 目标文件路径
*      lv_content   TYPE string VALUE 'Hello, AL11!'.         " 要写入的内容
*
*OPEN DATASET lv_file_name FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
*IF sy-subrc = 0.
*  TRANSFER lv_content TO lv_file_name.
*  CLOSE DATASET lv_file_name.
*  WRITE: / 'File written successfully to AL11 directory.'.
*ELSE.
*  WRITE: / 'Error writing file to AL11 directory.'.
*ENDIF.


*     TYPES: BEGIN OF r_tvarv,
*             sign TYPE tvarvc-sign,
*             opti TYPE tvarvc-opti,
*             low  TYPE tvarvc-low,
*             high TYPE tvarvc-high,
*           END OF r_tvarv. DATA:it_tvarvc9 TYPE TABLE OF r_tvarv.
*    DATA:it_tvarvc20 TYPE TABLE OF r_tvarv.           "XB240718.N  SELECT   sign opti low high
*  DATA:l_ekko TYPE mepoheader.
*
*
*    SELECT sign opti AS option low high               "XB240718.SN
*      INTO TABLE it_tvarvc20
*      FROM tvarvc
*     WHERE name = 'MM_HUB_PRICING_CONDITION'.         "XB240718.EN
*
*l_ekko-ZZHUBID = 'MAPLE-TEST1'.
*    IF ( l_ekko-ZZHUBID NOT IN it_tvarvc20 ) .                     "XB240718.N
*      WRITE 'test'.
*    ENDIF.



*REPORT z_alv_color_example.

*TABLES: ZBAFTPMA0001.
*
*TYPE-POOLS: slis.
*
*CONSTANTS: c_col_positive TYPE lvc_t_scol VALUE '6', "绿色
*           c_col_negative TYPE lvc_t_scol VALUE '7'. "红色
*
*TYPES: BEGIN OF ty_data,
*         col1       TYPE string,
*         col2       TYPE string,
*         color(4)   TYPE c, "颜色字段
*       END OF ty_data.
*
*DATA: lt_data TYPE TABLE OF ty_data,
*      ls_data TYPE ty_data.
*
*DATA: lvc_layout  TYPE lvc_s_layo,
*      lt_fieldcatalog TYPE lvc_t_fcat,
*      gr_alv    TYPE REF TO cl_gui_alv_grid.
*
*lvc_layout = lvc_s_layo.
*lvc_layout-coltab_fieldname = 'COLOR'.
*
*" 从数据库表中读取数据
*SELECT field1 AS col1, field2 AS col2
*  INTO TABLE lt_data
*  FROM ztable.
*
*" 根据条件设置颜色
*LOOP AT lt_data INTO ls_data.
*  IF ls_data-col1 EQ 'positive_value'.
*    ls_data-color = c_col_positive.
*  ELSEIF ls_data-col1 EQ 'negative_value'.
*    ls_data-color = c_col_negative.
*  ELSE.
*    ls_data-color = '0'. " 默认颜色
*  ENDIF.
*  MODIFY lt_data FROM ls_data.
*ENDLOOP.
*
*" 显示 ALV 列表
*CALL FUNCTION 'LVC_F4F_CAT'
*  IMPORTING
*    es_layout = lvc_layout.
*
*CALL METHOD gr_alv->set_table_for_first_display
*  EXPORTING
*    is_layout        = lvc_layout
*  CHANGING
*    it_outtab        = lt_data
*    it_fieldcatalog  = lt_fieldcatalog.

*WRITE: 'This is without frame'.
*
*FORMAT FRAMES ON.
*WRITE: 'This is with frame'.
*
*FORMAT FRAMES OFF.
*WRITE: 'This is without frame again'.

*TABLES:mara.
*DATA: lt_fieldcat TYPE lvc_t_fcat, " Field catalog
*      lr_table    TYPE REF TO data, " Reference to dynamic table
*      lr_line     TYPE REF TO data, " Reference to line of dynamic table
*      lt_data     TYPE TABLE OF string, " Sample data
*      lv_value    TYPE string. " Sample value
*
*FIELD-SYMBOLS: <lt_table> TYPE mara, " Field symbol for dynamic table
*               <ls_line>  TYPE any. " Field symbol for line of dynamic table
*
*" Step 1: Define field catalog
*APPEND VALUE #( fieldname = 'FIELD1' datatype = 'CHAR' ) TO lt_fieldcat.
*APPEND VALUE #( fieldname = 'FIELD2' datatype = 'INT4' ) TO lt_fieldcat.
*
*" Step 2: Create dynamic internal table
*CALL METHOD cl_alv_table_create=>create_dynamic_table
*  EXPORTING
*    it_fieldcatalog = lt_fieldcat
*  IMPORTING
*    ep_table        = lr_table.
*
*ASSIGN lr_table->* TO <lt_table>.
*
*" Step 3: Create a line type for the dynamic table
*CREATE DATA lr_line LIKE LINE OF lr_table.
*ASSIGN lr_line->* TO <ls_line>.
*
*" Step 4: Fill dynamic internal table with data
*lv_value = 'Sample1'.
*<ls_line>-field1 = lv_value.
*<ls_line>-field2 = 123.
*APPEND <ls_line> TO <lt_table>.
*
*lv_value = 'Sample2'.
*<ls_line>-field1 = lv_value.
*<ls_line>-field2 = 456.
*APPEND <ls_line> TO <lt_table>.
*
*" Display the dynamic internal table
*LOOP AT <lt_table> ASSIGNING <ls_line>.
*  WRITE: / <ls_line>-field1, <ls_line>-field2.
*ENDLOOP.


*FIELD-SYMBOLS: <fs_wa>.
*
*DATA: lt_tab     TYPE REF TO data,
*      wa_linedat TYPE REF TO data.
*
*
*DATA: wa_fieldcat TYPE lvc_s_fcat,
*      it_fieldcat TYPE lvc_t_fcat.
*
*TYPES: BEGIN OF ty_result,
*         stdpd LIKE marc-stdpd,
*         data  TYPE REF TO data,
*         type1 LIKE zpprcdump0001-dummy_type,
*         type2 LIKE zpprcdump0001-dummy_type,
*         normt LIKE mara-normt,
*         zzmod LIKE mara-zzmod,
*         srule TYPE c LENGTH 50,
*       END OF ty_result.
*DATA: it_result TYPE TABLE OF ty_result WITH HEADER LINE,
*      wa_result TYPE ty_result.
*
*FIELD-SYMBOLS: <fs_tab> TYPE STANDARD TABLE.
*
**& The dynamic internal tab, cannot fill data to dynamic columns
**  1. Re-generate a new dynamic internal table
**  2. MOVE dynamic fields' value to new internal table
*CALL METHOD cl_alv_table_create=>create_dynamic_table
*  EXPORTING
*    it_fieldcatalog = it_fieldcat
*  IMPORTING
*    ep_table        = lt_tab.
*
*ASSIGN lt_tab->* TO <fs_tab>.
*
*CREATE DATA wa_linedat LIKE LINE OF <fs_tab>.
*ASSIGN  wa_linedat->* TO <fs_wa>.
*
*LOOP AT it_result INTO wa_result.
*  MOVE-CORRESPONDING wa_result TO <fs_wa>.
*
*  IF wa_result-data IS BOUND.
*    MOVE-CORRESPONDING wa_result-data->* TO <fs_wa>.
*  ENDIF.
*
*  APPEND <fs_wa> TO <fs_tab>.
*ENDLOOP.



*REPORT ZALV_EVENT.

*TABLES: mara.

*DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
*      lt_events   TYPE slis_t_event,
*      lt_layout   TYPE slis_layout_alv,
*      lt_data     TYPE TABLE OF mara.
*
*FIELD-SYMBOLS: <fs_data> TYPE mara .
*
** 获取数据
*SELECT * INTO TABLE lt_data FROM mara UP TO 10 ROWS.
*
** 定义字段目录
*CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
*  EXPORTING
*    i_structure_name = 'MARA'
*  CHANGING
*    ct_fieldcat      = lt_fieldcat.
*
** 定义事件处理器
*DATA: ls_event TYPE slis_alv_event.
*
*ls_event-name = 'USER_COMMAND'.
*ls_event-form = 'USER_COMMAND'.
*APPEND ls_event TO lt_events.
*
** 显示ALV
*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*  EXPORTING
*    i_callback_program = sy-repid
*    is_layout          = lt_layout
*    it_fieldcat        = lt_fieldcat
*    it_events          = lt_events
*  TABLES
*    t_outtab           = lt_data
*  EXCEPTIONS
*    program_error      = 1
*    OTHERS             = 2.
*
*IF sy-subrc <> 0.
*  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
*ENDIF.
*
** 事件处理器
*FORM user_command USING r_ucomm LIKE sy-ucomm
*                        rs_selfield TYPE slis_selfield.
*  CASE r_ucomm.
*    WHEN '&IC1'.
*      READ TABLE lt_data INDEX rs_selfield-tabindex INTO <fs_data>.
*      IF sy-subrc = 0.
*        MESSAGE i000(000) WITH <fs_data>-matnr.
*      ENDIF.
*  ENDCASE.
*ENDFORM.


*  TABLES:SFLIGHT.


*  DATA GR_ALVGRID TYPE REF TO CL_GUI_ALV_GRID .
*DATA GC_CUSTOM_CONTROL_NAME TYPE SCRFNAME VALUE 'CC_ALV'.   "对应我们画的控制区的名称
*DATA GR_CCONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER .
**---栏位
*DATA GT_FIELDCAT TYPE LVC_T_FCAT .
**---布局
*DATA GS_LAYOUT TYPE LVC_S_LAYO .
*
**个人定义的变量
*DATA: SET_COLOR       TYPE I,
*      DECI_COUNT      TYPE P,
*      CHR_COUNT(8)    TYPE C,
*      TITLE(50)       TYPE C,
*      ALL_FIELD       TYPE I,
*      ALL_FIELD1      TYPE I,
*      LV_INDEX        TYPE I,
*      TABIX           LIKE SY-TABIX,
*      TMP_TITLE       TYPE STRING.
*
*
**&---------------------------------------------------------------------*
**&      Form  display_alv
**&---------------------------------------------------------------------*
**       显示ALV报表
**----------------------------------------------------------------------*
*FORM DISPLAY_ALV USING IT_TABLE TYPE TABLE.
*  IF GR_ALVGRID IS INITIAL .
**----新建容器，填充到我们画的控制区域
*    CREATE OBJECT GR_CCONTAINER
*    EXPORTING
*      CONTAINER_NAME              = GC_CUSTOM_CONTROL_NAME    "这个地方前面已经赋值了
*    EXCEPTIONS
*      CNTL_ERROR                  = 1
*      CNTL_SYSTEM_ERROR           = 2
*      CREATE_ERROR                = 3
*      LIFETIME_ERROR              = 4
*      LIFETIME_DYNPRO_DYNPRO_LINK = 5
*      OTHERS                      = 6.
*    IF SY-SUBRC EQ 0.
**----容器新建成功，然后在此容器里面新建ALV的实例
*      CREATE OBJECT GR_ALVGRID
*      EXPORTING
*        I_PARENT          = GR_CCONTAINER
*      EXCEPTIONS
*        ERROR_CNTL_CREATE = 1
*        ERROR_CNTL_INIT   = 2
*        ERROR_CNTL_LINK   = 3
*        ERROR_DP_CREATE   = 4
*        OTHERS            = 5.
*      IF SY-SUBRC <> 0.
*      ENDIF.
**----准备获取栏位列表
*      PERFORM SETFIELDS.
*"*-----设置布局
*      PERFORM PREPARE_LAYOUT CHANGING GS_LAYOUT .
*
**准备完毕，显示ALV
*      CALL METHOD GR_ALVGRID->SET_TABLE_FOR_FIRST_DISPLAY
*      EXPORTING
**        I_BUFFER_ACTIVE =
**        I_CONSISTENCY_CHECK =
**        I_STRUCTURE_NAME =
**        IS_VARIANT =
**        I_SAVE =
**        I_DEFAULT = 'X'
*        IS_LAYOUT = GS_LAYOUT
**        IS_PRINT =
**        IT_SPECIAL_GROUPS =
**        IT_TOOLBAR_EXCLUDING =
**        IT_HYPERLINK =
*      CHANGING
*        IT_OUTTAB = IT_TABLE[]     "设置成自己的内表
*        IT_FIELDCATALOG = GT_FIELDCAT
**       IT_SORT =
**       IT_FILTER =
*      EXCEPTIONS
*        INVALID_PARAMETER_COMBINATION = 1
*        PROGRAM_ERROR = 2
*        TOO_MANY_LINES = 3
*        OTHERS = 4 .
*      IF SY-SUBRC <> 0.
*      ENDIF.
**刷新ALV
*      CALL METHOD GR_ALVGRID->REFRESH_TABLE_DISPLAY
**      EXPORTING
**       IS_STABLE =
**       I_SOFT_REFRESH =
*      EXCEPTIONS
*        FINISHED = 1
*        OTHERS = 2 .
*      IF SY-SUBRC <> 0.
**--Exception handling
*      ENDIF.
*    ENDIF .
*  ENDIF.
*
**状态栏里面显示本报表名称和记录等信息
*  CHR_COUNT = DECI_COUNT.
*  CONDENSE CHR_COUNT.
*  CONCATENATE TMP_TITLE '，共' CHR_COUNT '笔记录'  INTO TITLE.
*  MESSAGE TITLE TYPE 'S'.
*
*
*ENDFORM .                    "display_alv
*
**&---------------------------------------------------------------------*
**&      Form  prepare_layout
**&---------------------------------------------------------------------*
**       ALV属性，具体属性意义请参考LVC_S_LAYO
**----------------------------------------------------------------------*
**      -->PS_LAYOUT  text
**----------------------------------------------------------------------*
*FORM PREPARE_LAYOUT CHANGING PS_LAYOUT TYPE LVC_S_LAYO.
*  PS_LAYOUT-ZEBRA      = 'X' .
*  PS_LAYOUT-GRID_TITLE = TITLE .
*  PS_LAYOUT-SMALLTITLE = 'X' .
*  PS_LAYOUT-SEL_MODE   = 'A'.
*  PS_LAYOUT-INFO_FNAME = 'COLOR'.
*  PS_LAYOUT-CWIDTH_OPT = 'X'.
*  PS_LAYOUT-DETAILINIT = 'X'.
*ENDFORM. " prepare_layout
*
**设置ALV表栏位的宏
*DEFINE DSETFIELDS.
*  DATA LS_FCAT TYPE LVC_S_FCAT .
*  LS_FCAT-FIELDNAME = &1.
*  LS_FCAT-INTTYPE   = 'C' .
*  LS_FCAT-OUTPUTLEN = &3.
*  LS_FCAT-COLTEXT   = &2.
*  LS_FCAT-SELTEXT   = &2.
*  APPEND LS_FCAT TO GT_FIELDCAT .
*END-OF-DEFINITION.
*
**&---------------------------------------------------------------------*
**&      FORM  SETFIELDS
**&---------------------------------------------------------------------*
**       调用宏设置栏位
**----------------------------------------------------------------------*
*FORM SETFIELD USING TMP_FIELD  TYPE C
*      TMP_NAME   TYPE C
*      TMP_LENGTH TYPE I.
*  DSETFIELDS TMP_FIELD TMP_NAME TMP_LENGTH.
*ENDFORM.                    "SETFIELDS
*
*  DATA:BEGIN OF IT_SFLIGHT OCCURS 0,
*          CARRID LIKE SFLIGHT-CARRID,
*          CONNID LIKE SFLIGHT-CONNID,
*          FLDATE LIKE SFLIGHT-FLDATE,
*          PRICE  LIKE SFLIGHT-PRICE,
*          COLOR(4) TYPE C,
*       END OF IT_SFLIGHT.
*
*  START-OF-SELECTION.
*    PERFORM GETDATA.  "读取数据
*    CALL SCREEN 100.    "呼叫屏幕
*
**&---------------------------------------------------------------------*
**&      Form  SETFIELDS
**&---------------------------------------------------------------------*
**       设置栏位
**----------------------------------------------------------------------*
*  FORM SETFIELDS.
*    PERFORM SETFIELD USING 'CARRID' '航线承运人ID' 3.
*    PERFORM SETFIELD USING 'CONNID' '航班连接 Id' 4.
*    PERFORM SETFIELD USING 'FLDATE' '航班日期' 8.
*    PERFORM SETFIELD USING 'PRICE' '航空运费' 15.
*  ENDFORM.                    "SETFIELDS
*
**&---------------------------------------------------------------------*
**&      Module  DISPLAY_ALV  OUTPUT
**&---------------------------------------------------------------------*
**       在PBO里面传入内表内容以ALV展现
**----------------------------------------------------------------------*
*  MODULE DISPLAY_ALV OUTPUT.
*    PERFORM DISPLAY_ALV USING IT_SFLIGHT[].
*  ENDMODULE.                 " DISPLAY_ALV  OUTPUT
*
**&---------------------------------------------------------------------*
**&      Form  GETDATA
**&---------------------------------------------------------------------*
**       读取数据
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*  FORM GETDATA .
*    DATA:SET_COLOR TYPE I.
*    SELECT * INTO CORRESPONDING FIELDS OF TABLE IT_SFLIGHT FROM SFLIGHT.
*    DESCRIBE TABLE IT_SFLIGHT LINES DECI_COUNT.  "获取记录数
*    LOOP AT IT_SFLIGHT.
*      SET_COLOR = SY-TABIX MOD 2.
*      IF SET_COLOR = 0.
*        IT_SFLIGHT-COLOR = 'C500'.  "设置颜色
*      ELSE.
*        CLEAR IT_SFLIGHT-COLOR.
*      ENDIF.
*      MODIFY IT_SFLIGHT.
*    ENDLOOP.
*    TMP_TITLE = 'ALV面向对象测试'.    "报表名称
*  ENDFORM.                    " GETDATA



*TYPE-POOLS: slis.
*
*DATA: gt_data TYPE TABLE OF mara, " 定义你的数据表类型
*      gs_data TYPE mara,
*      gt_fieldcat TYPE lvc_t_fcat,
*      gs_fieldcat TYPE lvc_s_fcat,
*      gr_alv_grid TYPE REF TO cl_gui_alv_grid,
*      gr_container TYPE REF TO cl_gui_custom_container,
*      gv_editable_row TYPE i VALUE 1. " 可编辑行的行号
*
*" 定义屏幕上的容器
*DATA: lv_container_name TYPE scrfname VALUE 'ALV_CONTAINER'.
*
*" 获取数据
*SELECT * FROM mara INTO TABLE gt_data.
*
*" 设置字段目录
*CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*  EXPORTING
*    i_structure_name = 'mara' " 你的数据表结构名
*  CHANGING
*    ct_fieldcat      = gt_fieldcat.
*
*" 设置特定字段为可编辑
*LOOP AT gt_fieldcat INTO gs_fieldcat.
*  IF gs_fieldcat-fieldname = 'EDITABLE_FIELD'. " 可编辑字段名
*    gs_fieldcat-edit = 'X'.
*  ELSE.
*    gs_fieldcat-edit = ''.
*  ENDIF.
*  MODIFY gt_fieldcat FROM gs_fieldcat.
*ENDLOOP.
*
*" 创建屏幕上的容器
*CALL SCREEN 100.
*
*MODULE status_0100 OUTPUT.
*  SET PF-STATUS 'SCREEN_100'.
*  SET TITLEBAR 'SCREEN_100'.
*
*  IF gr_container IS INITIAL.
*    CREATE OBJECT gr_container
*      EXPORTING
*        container_name = lv_container_name.
*
*    CREATE OBJECT gr_alv_grid
*      EXPORTING
*        i_parent = gr_container.
*
*    " 注册事件处理
*    SET HANDLER gr_alv_grid->handle_data_changed FOR gr_alv_grid.
*
*    CALL METHOD gr_alv_grid->set_table_for_first_display
*      EXPORTING
*        is_layout       = VALUE lvc_s_layo( edit = 'X' )
*      CHANGING
*        it_outtab       = gt_data
*        it_fieldcatalog = gt_fieldcat.
*  ENDIF.
*ENDMODULE.
*
*MODULE user_command_0100 INPUT.
*  CASE sy-ucomm.
*    WHEN 'EXIT' OR 'BACK' OR 'CANCEL'.
*      LEAVE PROGRAM.
*  ENDCASE.
*ENDMODULE.
*
*CLASS lcl_event_handler DEFINITION.
*  PUBLIC SECTION.
*    METHODS: handle_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
*      IMPORTING er_data_changed.
*ENDCLASS.
*
*CLASS lcl_event_handler IMPLEMENTATION.
*  METHOD handle_data_changed.
*    DATA: lt_mod_cells TYPE lvc_t_modi,
*          ls_mod_cell TYPE lvc_s_modi.
*
*    lt_mod_cells = er_data_changed->mt_mod_cells.
*
*    LOOP AT lt_mod_cells INTO ls_mod_cell.
*      " 检查修改的行号
*      IF ls_mod_cell-INDEX <> gv_editable_row.
*        " 如果不是可编辑行，恢复原值
*        er_data_changed->modify_cell( INDEX = ls_mod_cell-INDEX
*                                      col_id = ls_mod_cell-col_id
*                                      value = ls_mod_cell-value_old ).
*      ENDIF.
*    ENDLOOP.
*  ENDMETHOD.
*ENDCLASS.
*
*DATA: gr_event_handler TYPE REF TO lcl_event_handler.
*
*INITIALIZATION.
*  CREATE OBJECT gr_event_handler.


*TABLES: mara.
*
*
*
*" 注册事件
*
*
*DATA: gt_mara TYPE TABLE OF mara,
*      gs_mara TYPE mara,
*      gt_fieldcat TYPE lvc_t_fcat,
*      gs_fieldcat TYPE lvc_s_fcat,
*      gt_layout TYPE lvc_s_layo,
*      gr_alv_grid TYPE REF TO cl_gui_alv_grid,
*      gr_container TYPE REF TO cl_gui_custom_container.
*
*FIELD-SYMBOLS: <fs_mara> TYPE mara.
*
*
*
*" 获取数据
*SELECT * FROM mara INTO TABLE gt_mara UP TO 10 ROWS.
*
*" 定义字段目录
*gs_fieldcat-fieldname = 'MATNR'.
*gs_fieldcat-seltext = 'Material Number'.
*gs_fieldcat-edit = 'X'. " 设置为可编辑
*APPEND gs_fieldcat TO gt_fieldcat.
*
*gs_fieldcat-fieldname = 'MAKTX'.
*gs_fieldcat-seltext = 'Material Description'.
*gs_fieldcat-edit = 'X'. " 设置为可编辑
*APPEND gs_fieldcat TO gt_fieldcat.
*
*gs_fieldcat-fieldname = 'MTART'.
*gs_fieldcat-seltext = 'Material Type'.
*gs_fieldcat-edit = 'X'. " 设置为不可编辑
*APPEND gs_fieldcat TO gt_fieldcat.
*
*" 设置ALV布局
*gt_layout-zebra = 'X'.
*
*" 创建屏幕容器
*CREATE OBJECT gr_container
*  EXPORTING
*    container_name = 'ALV_CONTAINER'.
*
*" 创建ALV Grid对象
*CREATE OBJECT gr_alv_grid
*  EXPORTING
*    i_parent = gr_container.
*
*" 调用ALV
**CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
**  EXPORTING
**    i_structure_name = 'MARA'
**    is_layout_lvc        = gt_layout
**    it_fieldcat_lvc  = gt_fieldcat
**  TABLES
**    t_outtab         = gt_mara
**  EXCEPTIONS
**    program_error    = 1
**    OTHERS           = 2.
*
*
*
*DATA: lt_events TYPE slis_t_event,
*      ls_event TYPE slis_alv_event.
*
*ls_event-name = 'MODIFY_CELL'.
*ls_event-form = 'MODIFY_CELL'.
*APPEND ls_event TO lt_events.
*
*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
*  EXPORTING
*    i_structure_name = 'MARA'
*    is_layout_lvc        = gt_layout
*    it_fieldcat_lvc  = gt_fieldcat
*    it_events        = lt_events
*  TABLES
*    t_outtab         = gt_mara
*  EXCEPTIONS
*    program_error    = 1
*    OTHERS           = 2.
*
*
*
*" 事件处理：控制行的编辑属性
*FORM modify_cell USING p_row TYPE lvc_s_row
*                        p_col TYPE lvc_s_col
*                        p_cell TYPE lvc_s_styl.
*
*  READ TABLE gt_mara ASSIGNING <fs_mara> INDEX p_row-INDEX.
*  IF sy-subrc = 0.
*    " 只允许第1到第5行的MATNR和MAKTX列可编辑
*    IF p_row-INDEX = 1 .
*      p_cell-style = cl_gui_alv_grid=>mc_style_enabled.
*    ELSE.
*      p_cell-style = cl_gui_alv_grid=>mc_style_disabled.
*    ENDIF.
*  ENDIF.
*
*ENDFORM.


*&---------------------------------------------------------------------*
*& Include          ZSXKTEST001TOP
*&---------------------------------------------------------------------*

  DATA: lo_http_client    TYPE REF TO if_http_client.

  DATA: i_string TYPE string.
  DATA: i_xstring TYPE xstring.


PARAMETERS p_string TYPE STRING.
PARAMETERS p_times  TYPE I.



*&---------------------------------------------------------------------*
*& Include          ZSXKTEST001F01
*&---------------------------------------------------------------------*

FORM post_http USING p_url
                     p_path
                     p_account
                     p_password
                     p_string.


  DATA: l_start_time TYPE timestamp,
        l_end_time TYPE timestamp,
        l_time TYPE timestamp,
        l_lenkb TYPE p DECIMALS 2,
        l_lenmb TYPE p DECIMALS 2.
  DATA: lo_http_entity    TYPE REF TO if_http_entity.
  DATA: l_url         TYPE string,
        l_token       TYPE string,
        l_acc         TYPE string,
        l_pas         TYPE string,
        l_acc2        TYPE string,
        l_body        TYPE string,
        l_string      TYPE string,
        l_string_line TYPE string,
        l_xstring     TYPE xstring,
        l_type        TYPE c LENGTH 50,
        l_path        TYPE string,
        l_len         TYPE i,
        l_file        TYPE string,
        l_file_encode TYPE string,
        l_response    TYPE string.

  l_url  = p_url && p_path.
  l_acc =  p_account.
  l_pas  = p_password.

*& Set url
  CALL METHOD cl_http_client=>create_by_url
    EXPORTING
      url                = l_url
    IMPORTING
      client             = lo_http_client
    EXCEPTIONS
      argument_not_found = 1
      plugin_not_active  = 2
      internal_error     = 3
      OTHERS             = 4.

*& Set POST Method
  CALL METHOD lo_http_client->request->set_method
    EXPORTING
      method = lo_http_client->request->co_request_method_post.

*& Set Header
*    CONCATENATE 'User '  l_acc  ', Organization '  l_pas
*      INTO l_token RESPECTING BLANKS.

*  后续这里需要改成 basic + base64编码的  p_account p_password

  l_token = 'Basic c2ItZGY3OTY5MTItZTgwZS00MzJiLTliNjctZjI1OGQ0MmRhMWI5IWI3NDkwfGl0LXJ0LWlzLWRldiFiNTg6YzBkMTBhYmUtMTAzOS00NjhlLWFiMjEtMTMwNDk1MWZmMjU5JEt5VnBSSkFiNWdtQ3h6VDRsSkE0WmF1Zks1TUx5b3ZZVG5FWE5nSmcxYUU9'.

  lo_http_client->request->set_header_field(
     name  = 'Content-Type'
     value = 'text/plain'
  ).

  lo_http_client->request->set_header_field(
    name  = 'Authorization'
    value = l_token
  ).



*& Set Body



  l_len = xstrlen( i_xstring ).

CALL METHOD lo_http_client->request->set_cdata
  EXPORTING
    data = i_string.

GET TIME STAMP FIELD l_start_time.
  PERFORM send_http CHANGING l_response.
GET TIME STAMP FIELD l_end_time.
  l_time = l_end_time - l_start_time.
  l_lenkb = l_len / 1024.
  l_lenmb = l_lenkb / 1024.

  WRITE: / 'SEND START TIME:' && l_start_time.
  WRITE: / 'SEND END TIME:'   && l_end_time.
  WRITE: / 'FILE LENGTH:'     && l_len && 'B'.
  WRITE: / 'FILE LENGTH:'     && l_lenkb && 'KB'.
  WRITE: / 'FILE LENGTH:'     && l_lenmb && 'MB'.
  WRITE: / 'DURING TIME:'     && l_time && 'S'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form send_http
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- L_RESPONSE
*&---------------------------------------------------------------------*
FORM send_http  CHANGING p_response.
 DATA: l_return TYPE i,
        l_index  LIKE sy-index,
        l_reason TYPE string,
        l_err    TYPE c LENGTH 50,
        l_err1   TYPE c LENGTH 50,
        l_err2   TYPE c LENGTH 50,
        l_err3   TYPE c LENGTH 50,
        l_err4   TYPE c LENGTH 50,
        l_length TYPE i.

* Send http request
  lo_http_client->send(
    EXCEPTIONS
      http_communication_failure = 1
      http_invalid_state         = 2 ).

* Receive the respose
  lo_http_client->receive(
     EXCEPTIONS
       http_communication_failure = 1
       http_invalid_state         = 2
       http_processing_failed     = 3 ).

  CALL METHOD lo_http_client->response->get_status
    IMPORTING
      code   = l_return
      reason = l_reason.

  p_response = lo_http_client->response->get_cdata( ).

  lo_http_client->close( ).

  IF l_return <> '200'.

    DO 4 TIMES.
      l_index = sy-index.
      l_length = strlen( p_response ).
      IF l_length = 0.
        EXIT.
      ENDIF.

      IF l_length >= '50'.
        l_err = p_response.
        p_response = p_response+50.
      ELSE.
        l_err = p_response.
        CLEAR p_response.
      ENDIF.

      CASE l_index.
        WHEN 1.
          l_err1 = l_err.
        WHEN 2.
          l_err2 = l_err.
        WHEN 3.
          l_err3 = l_err.
        WHEN 4.
          l_err4 = l_err.
      ENDCASE.
    ENDDO.

    MESSAGE s398(00) DISPLAY LIKE 'E' WITH l_err1 l_err2 l_err3 l_err4.
    WRITE: / 'Send file to SFTP fail!'.

  ELSE.
    MESSAGE s398(00) DISPLAY LIKE 'S' WITH 'Send file to SFTP success!'.
    WRITE: / 'Send file to SFTP success!'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form post_sftp_test
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM post_sftp_test .
  DATA: l_url       TYPE string VALUE 'https://is-dev.it-cpi011-rt.cfapps.jp20.hana.ondemand.com'.
  DATA: l_path      TYPE string VALUE '/http/B2BTEST'.
  DATA: l_name      TYPE string VALUE 'sb-df796912-e80e-432b-9b67-f258d42da1b9!b7490|it-rt-is-dev!b58'.
  DATA: l_pas       TYPE string VALUE 'c0d10abe-1039-468e-ab21-1304951ff259$KyVpRJAb5gmCxzT4lJA4ZaufK5MLyovYTnEXNgJg1aE='.
  DATA: l_filename  TYPE string VALUE 'CPI-B2B-SFTPTEST.txt'.   "测试阶段现在由CPI  hard code

  PERFORM post_http USING l_url l_path l_name l_pas  l_filename.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_file_content
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_file_content .
  IF p_times is INITIAL .
    p_times = 1000.
  ENDIF.
  DO p_times TIMES.
    i_string = i_string && p_string.
  ENDDO.



CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
  EXPORTING
    text   = i_string
  IMPORTING
    buffer = i_xstring.
ENDFORM.






