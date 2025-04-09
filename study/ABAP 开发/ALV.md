

### ALV对比

FM ALV 和 OO ALV 的比较
FM ALV 和 OO ALV都能够实现按钮自定义、数据修改、按钮处理自定义操作，通常情况下FM ALV 主要用于报表数据展示及简单交互；OO ALV 主要用于dialog程序开发，可以进行复杂的控制，比如单元格的修改控制（FM只能控制到列修改）、自定义F4等，OO ALV可以根据容器排列很方便的定义布局，一个屏幕可以放多个ALV,但是FM ALV 只能一屏显示一个ALV.

面向对象（OO）ALV 相较于函数模块（FM）ALV 提供了更多的功能和灵活性。以下是一些 OO ALV 提供的，而 FM ALV 不具备或难以实现的功能：

#### 

OO ALV 提供了更丰富的事件处理机制，可以处理更多类型的用户交互事件，如单击、双击、选择行、菜单选择等

运行时动态修改 ALV 表中的数据，并实时更新显示，而无需重新生成整个 ALV

OO ALV 提供了更灵活的布局和字段目录自定义功能，可以根据需求动态调整字段的显示、隐藏、顺序、标题等。

 提供了更强大的分组和汇总功能，可以对数据进行分组显示，并计算小计和总计



### FUNCTION ALV实现

```ABAP
FORM show_alv_query_com  TABLES   pt_zppskmblg0002 STRUCTURE zppskmblg0002.   "XB240513.SN
  TYPE-POOLS: slis.
*- Fieldcatalog
  DATA: wa_layout TYPE lvc_s_layo.

  DATA:l_index LIKE sy-tabix.

  DATA:l_pos TYPE i VALUE 1.

  append_alv_lvc_field 'WERKS'      'IT_ERROR' l_pos '' '' 'Plant' '12' ''.
  append_alv_lvc_field 'MATNR'      'IT_ERROR' l_pos '' '' 'Material Number' '40' ''.
  append_alv_lvc_field 'MAKTX'      'IT_ERROR' l_pos '' '' 'Material Description' '40' ''.
  append_alv_lvc_field 'REMARK'     'IT_ERROR' l_pos '' '' 'REMARK' '30' ''.
  append_alv_lvc_field 'ZDELFLG'    'IT_ERROR' l_pos '' '' 'ZDELFLG' '1' ''.
  append_alv_lvc_field 'ZZMOD'      'IT_ERROR' l_pos '' '' 'Model Name' '10' ''.
  append_alv_lvc_field 'ZCRTBY'     'IT_ERROR' l_pos '' '' 'Create by' '12' ''.
  append_alv_lvc_field 'ZCPUDT'     'IT_ERROR' l_pos '' '' 'Create Date' '8' ''.
  append_alv_lvc_field 'ZCPUTM'     'IT_ERROR' l_pos '' '' 'Create time' '6' ''.
  append_alv_lvc_field 'ZCHGBY'     'IT_ERROR' l_pos '' '' 'Change by' '12' ''.
  append_alv_lvc_field 'ZCHGDT'     'IT_ERROR' l_pos '' '' 'Change date' '8' ''.
  append_alv_lvc_field 'ZCHGTM'     'IT_ERROR' l_pos '' '' 'Change time' '6' ''.

  wa_layout-cwidth_opt = 'X'.

  SET TITLEBAR 'T1' WITH 'BOM and MO Comparison Skip Error report'.

  SORT pt_zppskmblg0002 BY werks.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = wa_layout
      it_fieldcat_lvc    = it_fieldcat
      i_save             = 'A'
    TABLES
      t_outtab           = pt_zppskmblg0002[]
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.  
```

基本步骤

1. 筛选数据
2. 设置field cat
3. 调用function REUSE_ALV_GRID_DISPLAY_LVC
4. 显示alv

其他功能实现

1. 设置可以选择数据进行操作

   ```
   wa_layout-stylefname = 'field_style'.
   
       SET TITLEBAR 'T1' WITH 'BOM and MO Comparison for Release MO'.
   
       SORT it_mo BY aufnr.
   
       CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
         EXPORTING
           i_callback_pf_status_set = 'SET_PF_STATUS'
           i_callback_user_command  = 'SET_USER_COMMAND'
           i_callback_program       = sy-repid
           is_layout_lvc            = wa_layout
           it_fieldcat_lvc          = it_fieldcat
           i_save                   = 'A'
         TABLES
           t_outtab                 = it_mo[]
         EXCEPTIONS
           program_error            = 1
           OTHERS                   = 2.
       IF sy-subrc NE 0.
         MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
       ENDIF.
   ```

对数据进行操作   先选择数据 然后点击按钮进行相应的操作

```
FORM set_pf_status USING rt_extab TYPE  slis_t_extab.
  SET PF-STATUS 'S1000'.
*  SET PF-STATUS 'S0101'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> R_UCOMM
*&      --> RS_SELFIELD
*&---------------------------------------------------------------------*
FORM set_user_command USING r_ucomm     LIKE sy-ucomm
                            rs_selfield TYPE slis_selfield.

  DATA:l_answer    TYPE c LENGTH 10,
       ref_grid    TYPE REF TO cl_gui_alv_grid,
       ls_stylerow TYPE        lvc_s_styl,
       l_oref      TYPE REF TO cx_root,
       l_text      TYPE c LENGTH 100.

  CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
    IMPORTING
      e_grid = ref_grid.

  CALL METHOD ref_grid->check_changed_data.
  rs_selfield-refresh = 'X'.

  CASE r_ucomm.
    WHEN 'SELALL'.
      LOOP AT it_mo.
        IF it_mo-compareflg = 'OK'.
          it_mo-sel = 'X'.
          MODIFY it_mo.
        ENDIF.
      ENDLOOP.

    WHEN 'UNSELALL'.
      LOOP AT it_mo.
        IF it_mo-compareflg = 'OK'.
          it_mo-sel = ''.
          MODIFY it_mo.
        ENDIF.

      ENDLOOP.

    WHEN 'REL'.
      READ TABLE it_mo WITH KEY sel = 'X'.
      IF sy-subrc <> 0.
        MESSAGE s398(00) WITH 'Please select at least one record!' DISPLAY LIKE 'E'.
        EXIT.
      ENDIF.

      PERFORM call_bapi.

      PERFORM show_release_log_alv.

      LEAVE TO SCREEN 0.
  ENDCASE.
ENDFORM.
```



### OOALV 实现

执行步骤
—— ALV实现相关变量定义
—— 创建本地类的声明以及实现
—— 创建界面，并创建Customer Control 容器
—— 实例化container,关联Customer Control容器
—— 将ALV植入container中
—— ALV格式化(layout及fieldcat的赋值等)
—— 注册相关事件
—— 执行ALV显示（CALL METHOD GS_XXX->SET_TABLE_FOR_FIRST_DISPLAY）



主要使用的类
DATA: gs_alv TYPE REF TO cl_gui_alv_grid, "用于表单输出
gs_con TYPE REF TO cl_gui_custom_container, "用于定义容器
gs_dyndoc_id TYPE REF TO cl_dd_document, “用于表头书写
gs_splitter TYPE REF TO cl_gui_splitter_container. "用于分割容器

主要使用的方法
—— 第一次输出表单： SET_TABLE_FOR_FIRST_DISPLAY
—— 刷新表单内容： REFRESH_TABLE_DISPLAY
I_SOFT_REFRESH, ‘X’ :只刷新单元格（如果有合计不自动更新）
—— 刷新fieldcat: SET_FRONTED_FIELDCATALOG
如果fieldcat 格式有修改，需要刷新格式设置，则调用这个方法



设置fieldcat
COL_POS 输出列 列的位置 ，第几列，例如1,2
FIELDNAME 字段名称
CURRENCY 货币单位/参考的当前单位的字段名称
QUANTITY 计量单位
DO_SUM 总计列值’X’,合计
FIX_COLUMN 固定列
EMPHASIZE 列的颜色
NO_OUT 列没有输出’X’，隐藏此列
DATATYPE ABAP字典中的数据类型
INTTYPE ABAP数据类型（C,D,N）
HOTSPOT 单击敏感’x’ ，下面出现下划线
DECIMALS 设置小数的位数
SCRTEXT_L/M/S 字段标签长/中/短