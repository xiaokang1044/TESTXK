# ABAP Study

## 1.常用T-code



 BAPI                        BAPI浏览器

OSS1                       连接SAP OSS

SA38                        运行程序(SE38开发)

SCAT                       计算机测试工具，测试，数据导入等                数据导入                        （Computer Aided Test Tool）

SE01                       传递传输请求(同一服务器的不同client)

SE09                       传输请求操作

SE10                       同SE09

SE11                       维护ABAP数据字典

SE12                       显示数据字典

SE13                       数据字典相关

SE14                       数据字典相关

SE15                       数据字典相关

SE16|SE17            查看表数据

SE30                       ABAP运行分析

SE32                       ABAP文本元素维护

SE35                       ABAP/4对话框编程维护

SE36                       维护逻辑数据库

SE37                       函数据维护Function module

SE38                       ABAP 编辑器

SE39                       程序比较

SE41                       菜单制作器

SE43                       应用区菜单(相同功能tcode组成一area menu)

SE51                       屏幕绘制器

SE54                       生成表的维护视图,然后SE16|SM30可直接维护表数据

SE55                       生成表维护程序

SE61                       文档维护

SE63                       翻译

SE71->SE76         SAPscript相关 Tcode

SE71                       Form设计                                                            单据打印

SE78                       Form,SmartForms使用图片上载

SE80                       ABAP库（对象浏览器）

SE81                       ABAP应用层次

SE84|SE85|SE86   ABAP/4 Repository Information System
SE90                       对象浏览器

SE91                       建立消息类和消息 

SE92                       维护系统Log消息

SE93                       给程序维护Tcode

SHDB                      批输入代码                                                          数据导入

SEU                         Repository Object Browser

SHD0                      维护Tcode运行变式(Variant)

SM04                      查看当前用户

SM12                      删除显示Locked objects(不可删除被lock的传输请求)

SM21                      Dump log查看

SM30|SM31           维护table|view数据

SM30                      维护表视图 SM32                     维护表

SM35                      进程监控，查看Batch input session(建立BDC使用SHDB)

SM36                      定义后台job SM37                     查看后台job

SM50                      超时用户（Process Overview）

SM51                      Display system servers, processes, etc.

SM62                      Display/Maintain events in SAP 

SMARTFORMS     SmartForms设计                                                   单据打印

SNUM                     编号对象维护

SO10                      标准文本，设定Form使用的TIFF图片等

SPAD                      假脱机管理

SQ01                      Query查询制作

ST05                       SQL等跟踪,使用它可跟踪程序使用的表等.

SU20                       授权字段                                                               授权

SU21                       授权对象                                                               授权

SU53                       检查授权对象,如出现权限问题可使用

WE21                      IDOC处理中的端口                                                IDOC



## 2.常用Table

### a、MM常用表

1、MARA: 常规物料数据 
2、MARC: 物料的工厂数据 
3、MAKT: 物料描述 
4、MARD: 物料的工厂/库存地点数据 
5、MBEW: 物料评估（财务数据），其中MBEW-WERKS指工厂 
6、MVKE: 物料销售数据 
7、MLGN: 每一个仓库号物料数据（仓库） 
8、MLGT: 每一个存储类型的物料数据（仓库/存储类型） 
8.1、MSTA：物料主记录状态 
9、LFA1: 供应商主数据（一般数据） 
10、LFB1: 供应商主数据（公司代码） 
11、LFM1: 供应商采购组织数据 
12、EINA: 采购信息记录（一般数据） 
13、EINE: 采购信息记录（采购组织数据） 
14、EKKO: 采购订单抬头 
15、EKPO: 采购订单行项目 
16、EKET: 计划协议计划行 
17、EKKN: 采购凭证中的帐户设置 
18、EKBE: 采购凭证历史 
19、MKPF: 物料凭证抬头 
20、MSEG: 物料凭证行项目 
21、RBKP: 凭证抬头供应商发票数据 
22、RSEG: 凭证项目供应商发票数据 
       EKKO/EKPO–>MKPF/MSEG–>RBKP/RSEG–>BKPF-BSEG 
23、KNA1: 客户主数据（一般数据） 
24、KNB1: 客户主数据（公司代码） 
25、KNVV: 客户主记录销售数据 
26、ADRC: 地址 
27、EBAN: 采购申请

### b、SD常用表
1、VBAK: 销售凭证：抬头数据 
2、VBAP: 销售凭证：项目数据 
3、VBEP: 销售凭证：计划行数据 
4、VBKD: 销售凭证：业务数据 
5、VBPA: 销售凭证：合作伙伴 
6、LIKP: SD凭证：交货抬头数据 
7、LIPS: SD凭证：交货项目数据 
8、VBRK: 出具发票：抬头数据 
9、VBRP: 出具发票：项目数据 
10、VBFA: 销售凭证流 
11、VBUK: 销售凭证：抬头状态和管理数据 
12、VBUP: 销售凭证 ： 项目状态 
13、T682I: 条件：存取顺序( 产生格式 ) 
14、T681: 条件：结构 
15、T682Z: 条件：存取顺序( 字段 ) 
16、T685: 条件:类型

### c、FICO常用表
1、SKA1: 总帐科目主记录 (科目表) 
2、SKB1: 总帐科目主记录 (公司代码) 
3、SKAT: 总帐科目主记录（描述） 
4、CSKB: 成本要素 
5、BKPF: 会计凭证抬头 
6、BSEG: 会计核算凭证项目数据，BSID客户未清会计核算凭证/BSAD客户已清会计核算凭证/BSIK供应商未清会计核算凭证/BSAK供应商已清会计核算凭证/BSIS总帐未清会计核算凭证/BSAS总帐已清会计核算凭证 
7、FAGLFLEXA: 总账实际行项目 
8、FAGLFLEXT: 总账汇总 
9、ANLA: 资产主记录段 
10、ANLC: 资产值字段 
11、CSKS: 成本中心主数据 
12、COEP: 成本控制对象：与期间相关的各行项目 
13、COSS: CO 对象:内部过帐成本总计 
14、COSP: CO 对象：外部记帐的成本总计 
15、 CKMLPRKEKO: 物料分类帐; 价格的成本组件分割 (标题) 
16、CKMLPRKEPH: 物料分类帐: 价格的成本组件分割 (要素0

### d、PP常用表
1、MAST：BOM链接物料 
2、STKO：BOM表头 
3、STAS：BOMs - 项选择 
4、STPO：BOM项目 
     STKO~STLAN = STAS-STLAN AND STKO~STLAL = STAS-STLAL 
     STAS~STLNR = STPO-STLNR AND STAS~STLKN = STAS-STLKN 
BOM类别包括：D-凭证结构、E-设备BOM、K-订单BOM、M-物料BOM、S-标准BOM、T-功能位置BOM、P-工作分解结构BOM 
5、PLAF: 计划订单 
6、RKPF: 预定/相关需求抬头 
7、RESB: 预定/相关需求行项目 
8、AUFK: 订单主数据 
9、AFKO: 订单表头数据，PP订单 
10、AFPO: 订单项 
11、AFVC: 订单的工序 
12、AFVV: 工序中数量/日期/值的DB结构 
13、JEST: 订单状态，通过AUFK-OBJNR=JEST-OBJNR关联 
14、AFRU: 订单确认 
15、AUFM: 针对订单的货物移动

### e、PM常用表
1、IFLOT: 功能位置(表) 
2、ILOA: PM 对象位置和帐户分配

### f、PS常用表
1、PROJ: 项目定义 
2、PRPS: WBS(工作中断结构) 元素主数据

### g、QM常用表

QALS：检验批记录
QAMR：检验结果记录
PLMK：检验计划
MAPL：物料的工序分配
QASV：检验结果的采样说明
QAVE：使用决策
QPMK：主检验特性

QMIH 通知单表头
QMEL 质量通知
QMDAT 通知日期

JCDS 通知单状态
OBJNR 对象编号（QM+通知单号）
JEST对象状态(I0068 OSNO 未处理 / I0069 延期 / I0070 NOPR 处理中 / I0072 NOCO 完成)
TJ02T 状态描述

### h、库存数据
1、MBEW: 物料评估 
2、MARD: 物料的工厂/库存地点数据 
3、MSLB: 供应商特殊库存（O） 
4、MKOL: 供应商特殊库存（K） 
5、MSKA: 销售订单库存 
6、MCH1/ MCHB: 批次库存

### i、货物移动数据
1、MKPF: 物料凭证抬头 
2、MSEG: 物料凭证行项目 
不是所有的物料移动数据都需要从这物料移动表中进行读取，生产订单相关AUFM，采购订单相关EKBE，销售相关VBFA。

### j、WM常用表
1、LTBK: 转储请求抬头 
2、LTBP: 转储请求项目 
3、LTAK: WM转储单抬头 
4、LTAP: WM转储单项目

### k、销售价格、采购价格
KONV: 价格数据 （s4被取代）
销售价格：通过条件记录号KONV-KNUMV=VBAK-KNUMV关联 
采购价格:：通过条件记录号KONV-KNUMV=EKKO-KNUMV关联

## 3.常用Function

### a.ALV

  call  function

```ABAP
DATA: it_fieldcat TYPE lvc_t_fcat.
  DATA: wa_layout TYPE lvc_s_layo.
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'				“使用这个可以显示左侧的工具栏
EXPORTING
 i_callback_pf_status_set = 'SET_PF_STATUS'            "设置其他屏幕
 i_callback_user_command = 'SET_USER_COMMAND'		   "对屏幕上的按钮进行设定
 i_callback_program    = sy-repid
 is_layout_lvc      = wa_layout						    ”输出样式
 it_fieldcat_lvc     = it_fieldcat					    “栏位名字   具体抓哪个栏位  内容进行定义
 i_save          = 'A'
TABLES
 t_outtab         = it_mo[]								”要显示的表名字
EXCEPTIONS
 program_error      = 1
 OTHERS          = 2.
```



类方法



```ABAP
  cl_salv_table=>factory( IMPORTING r_salv_table = lo_alv
                  CHANGING t_table   = <fs_tab3> ).						"输入alv 类  和对应的表内容
  
  PERFORM set_layout CHANGING lo_alv.									"设置样式
 
  PERFORM set_fields CHANGING lo_alv.									"设置实际上会现实的内容
 	
  DATA(l_xstr) = lo_alv->to_xml( if_salv_bs_xml=>c_type_xlsx ).			"可以选择进行输出   输出xlsx文件
  
  lo_alv->display( ).													"显示alv
  
  
  
  FORM set_layout  CHANGING p_alv  TYPE REF TO cl_salv_table.

  DATA: wa_layout TYPE REF TO cl_salv_layout.
  DATA:g_repid         TYPE sy-repid.
  g_repid = sy-repid.
  wa_layout = p_alv->get_layout( ).
  wa_layout->set_save_restriction( if_salv_c_layout=>restrict_none ).
  wa_layout->set_key( VALUE #( report = g_repid ) ).
  wa_layout->set_default( abap_false ).   "No load default layout

  wa_layout->set_initial_layout( 'DEFAULT' ).


ENDFORM.


ORM set_fields  CHANGING p_alv TYPE REF TO cl_salv_table RAISING cx_salv_not_found.
  DATA: l_i TYPE i.
  DATA: l_short  TYPE scrtext_s,
        l_medium TYPE scrtext_m.

  DEFINE set_field.


    l_short = &2.
    p_alv->get_columns( )->get_column( &1 )->set_short_text( l_short ).
    l_medium = &2.
    p_alv->get_columns( )->get_column( &1 )->set_medium_text( l_medium ).
    p_alv->get_columns( )->get_column( &1 )->set_long_text( &2 ).
    p_alv->get_columns( )->get_column( &1 )->set_leading_zero( 'X' ).
    IF &3 = 'X'.  "Hide Field
      p_alv->get_columns( )->get_column( &1 )->set_visible( ' ' ).
      p_alv->get_columns( )->get_column( &1 )->set_technical( 'X' ).
    ELSE.
      l_i = l_i + 1.
      p_alv->get_columns( )->set_column_position( columnname = &1
                                                    position = l_i ).
    ENDIF.
*    p_alv->get_columns( )->get_column( &1 )->set_leading_zero( ' ' ).

*    p_alv->get_columns( )->get_column( &1 )->set_ddic_domain( abap_false ).
  END-OF-DEFINITION.
  CASE 'X'.
    WHEN r_gen.
      set_field 'LIFNR'     'LFA1-LIFNR'                       ''.
      set_field 'KTOKK'     'LFA1-KTOKK'                       ''.
      set_field 'KUNNR'     'LFA1-KUNNR'                       ''.
      set_field 'NAME1'     'ADRC-NAME1'                       ''.
      set_field 'NAME2'     'ADRC-NAME2'                       ''.
      set_field 'NAME3'     'ADRC-NAME3'                       ''.
      set_field 'NAME4'     'ADRC-NAME4'                       ''.
      set_field 'STR_SUPPL1'     'ADRC-STR_SUPPL1'             ''.
      set_field 'STR_SUPPL2'     'ADRC-STR_SUPPL2'             ''.
      set_field 'STR_SUPPL3'     'ADRC-STR_SUPPL3'             ''.
      set_field 'SORT1'     'ADRC-SORT1'                       ''.
      set_field 'SORT2'     'ADRC-SORT2'                       ''.
      set_field 'POST_CODE1'     'ADRC-POST_CODE1'             ''.
      set_field 'LAND1'     'LFA1-LAND1'                       ''.
      set_field 'SPRAS'     'LFA1-SPRAS'                       ''.
      set_field 'STCEG'     'LFA1-STCEG'                       ''.
      set_field 'STCD1'     'LFA1-STCD1'                       ''.
      set_field 'CITY1'     'ADRC-CITY1'                       ''.
      set_field 'REGION'    'ADRC-REGION'                      ''.
      set_field 'TELF1'     'LFA1-TELF1'                       ''.
      set_field 'TELFX'     'LFA1-TELFX'                       ''.
      set_field 'VBUND'     'LFA1-VBUND'                       ''.
      set_field 'KONZS'     'LFA1-KONZS'                       ''.
  
```





b.上传表格

## 4.小技巧

a.单引号转义。

以下是一个示例：

```abap
DATA: lv_string TYPE string.

lv_string = 'It''s a string with a single quote.'.

WRITE: / lv_string.
```

在这段代码中，字符串`'It''s a string with a single quote.'`中的两个连续的单引号('')会被解释为一个单引号(')，所以`lv_string`的值将会是`It's a string with a single quote.`。

请注意，这只是一个示例，你可能需要根据你的实际情况进行修改。



b. 寻找相应得domain

```
SELECT rollname domname DATATYPE LENG DECIMALS ddtext scrtext_l SIGNFLAG LOWERCASE DDLANGUAGE

 FROM dd04vvt

 WHERE ROLLNAME LIKE 'Z%'      "Z字头 要查domain 用domname

  AND ddtext  LIKE '%rocess%'   "描述含有 分大小写 查domain描述用scrtext_l

​                   "AND SIGNFLAG = 'X' 有负数
```



## 5.增强

在SAP中，增强（Enhancement）是指在不修改标准SAP代码的前提下，对系统功能进行增加或改变，以满足特定的业务需求。增强的类型和实现步骤如下：

### 

### 增强的分类

1. **User Exits（用户出口）**:
   - SAP为特定的标准程序提供了某些预定义的插入点，开发者可以在这些点插入自定义代码。
   - 通常使用函数模块来实现。
2. **Customer Exits（客户出口）**:
   - 类似于User Exits，但设计更灵活，可以包括函数模块、菜单栏和屏幕元素的增强。
   - 大多数情况下通过项目`CMOD`管理。
3. **BAdI（Business Add-Ins）**:
   - 面向对象的增强技术，用于实现更复杂的需求。
   - 提供Standard BAdI (经典BAdI) 和 New BAdI (基于ABAP Objects)。
4. **Enhancement Spots**:
   - 比较新的增强方式，允许在不同层次和不同对象上进行增强。
   - 包括Implicit Enhancement（隐式增强）和Explicit Enhancement（显式增强）。
5. **Enhancement Framework**:
   - 一个框架，结合了多种增强技术，提供了更为先进和一致的增强方法。

### 增强的实现步骤

1. **查找增强点**:

   - 使用事务代码`SE84`或`SE80`，在“增强”节点下查找现有增强点。
   - 使用调试模式或特定工具（如Display Enhancements）查找具体增强点。

2. **实现增强**:

   **User Exits**的实现：

   - 通过事务代码`SMOD`找到相关的增强项目。
   - 在项目中添加相应的自定义代码。

   **Customer Exits**的实现：

   - 创建一个增强项目，通过`CMOD`事务代码管理。
   - 在项目中添加函数模块执行相应代码。

   **BAdI的实现**:

   - 使用事务代码`SE18`查找和显示BAdI。
   - 通过事务代码`SE19`实现BAdI。
   - 创建实现类，添加对应的方法的代码。

   **Enhancement Spots的实现**:

   - 在事务代码`SE18`中查找Enhancement Spot。
   - 在`SE19`中创建实现。
   - 通过增强点插入代码或覆盖标准逻辑。

3. **测试增强**:

   - 执行业务流程，确保增强的功能正确无误。
   - 进行回归测试，确保新增的自定义逻辑没有引入新的错误。

4. **激活和部署**:

   - 确认所有的代码和配置都已经正确激活。
   - 通过适当的开发、测试和生产环境迁移，确保增强顺利运行。

## 6.RFC开发

​	实现步骤

  1. **SE37** 建立function  配置里选项选择RFC   

  2. 添加相应的导入导出参数和表   like   xxx 表结构

  3.  在代码处添加相应的代码逻辑进行判断

  4. 测试代码逻辑

  5. 配置和测试外部系统的连接  <u>SM59</u> (一般是basis 来做)

  6. 完成开发   如果需要暴露到 webservice 还需要做一些特殊处理

  7. 案例：供VCF call 的接口来实现创建vendor /customer   CCS 签核单  MM po gr 的批导 后发送数据

     

## 7.批导程序（ZPPR00424）

1. 步骤    首先下载模板   上传文件    转换内表   alv 显示  执行其他操作  

2. 用到的函数    cl_gui_frontend_services=>directory_browse  获取文件夹   cl_gui_frontend_services=>file_open_dialog      获取文件   ZALSM_EXCEL_TO_INTERNAL_TABLE 转内表

3. 案例：PP release mo,MM po gr 的批导   SD vendor customer 的批导

   

   

## 8.BDC



案例：销售订单多行实现

TCODE:SHDB

步骤：

   1.SHBD 点击生成程序 

   2.从记录获取数据  然后添加数据

   3.然后会生成相应代码   复制到  代码中   并且调整相应的栏位

       4. 然后调用事务码
       5. 进行BDC 消息处理   然后进行  后续的开发 对结果进行验证等等



## 9.MM常用流程

### 1. 采购管理

#### 采购申请 (Purchase Requisition)

- ME51N

  : 创建采购申请

  - 用于创建新的采购申请。

- ME52N

  : 修改采购申请

  - 用于修改现有的采购申请。

- ME53N

  : 显示采购申请

  - 用于查看现有的采购申请。

#### 采购订单 (Purchase Order) EKKO  EKPO  EKET  EKKN   EKBE

1. **EKKO**：采购文档抬头（Purchasing Document Header）
   - 存储采购订单的抬头信息，如采购订单编号、供应商编号、采购组织等。
2. **EKPO**：采购文档项目（Purchasing Document Item）
   - 存储采购订单的项目（行项目）信息，如物料编号、数量、价格等。
3. **EKET**：采购文档交货日程行（Purchasing Document Schedule Lines）
   - 存储采购订单的交货日程行信息，如交货日期、交货数量等。
4. **EKKN**：采购文档账户分配（Purchasing Document Account Assignment）
   - 存储采购订单的账户分配信息，如成本中心、内部订单等。
5. **EKBE**：采购文档历史（Purchasing Document History）
   - 存储采购订单的历史记录，如收货、发票等。

- ME21N

  : 创建采购订单

  - 用于创建新的采购订单。

- ME22N

  : 修改采购订单

  - 用于修改现有的采购订单。

- ME23N

  : 显示采购订单

  - 用于查看现有的采购订单。

#### 采购信息记录 (Purchase Info Record)  EINA   EINE

在SAP中，信息记录（Info Record，简称`INFREC`）是采购信息记录（Purchasing Info Record）的简称，用于存储供应商和物料之间的采购信息。信息记录在采购过程中起着重要作用，帮助企业管理供应商和物料的关系，并提供有关价格、交货时间等关键信息。

以下是信息记录的一些关键功能和作用：

1. **价格信息**：信息记录存储了供应商提供的物料的价格信息，包括净价、折扣、税率等。这些信息在创建采购订单时会自动引用，确保价格的一致性和准确性。
2. **交货时间**：信息记录包含供应商的交货时间信息，帮助企业计划物料的交货和库存管理。
3. **采购条件**：信息记录可以存储与供应商和物料相关的采购条件，如最小订购量、批量折扣等。
4. **供应商信息**：信息记录包含供应商的基本信息，如供应商编号、名称、地址等。
5. **历史记录**：信息记录可以存储历史采购数据，帮助企业分析供应商的表现和采购趋势。
6. **自动引用**：在创建采购订单或采购申请时，系统可以自动引用信息记录中的数据，减少手动输入和错误



- ME11

  : 创建采购信息记录

  - 用于创建新的采购信息记录。

- ME12

  : 修改采购信息记录

  - 用于修改现有的采购信息记录。

- ME13

  : 显示采购信息记录 

  - 用于查看现有的采购信息记录。
  
    

Info Category 信息类别:

Standard - 标准，正常的采购业务，向供应商买材料。

Subcontracting - 分包，委外，把自己仓库的原材料发给委外供应商，供应商加工后再反馈给我，只给加工费。

Pipeline - 管道线, 比如水，电等，用的时候就用，没有库存管理之类的说法。

Consignment - 委托，寄售，把供应商的材料放到一个地方，需要用的时候拿出来用。库存成本比较低。

#### 供应商主数据 (Vendor Master Data)

- XK01

  : 创建供应商主数据

  - 用于创建新的供应商主数据。

- XK02

  : 修改供应商主数据

  - 用于修改现有的供应商主数据。

- XK03

  : 显示供应商主数据

  - 用于查看现有的供应商主数据。
  
- **MK01/FK01/XK01 Create Vendor Master**

  **MK02/FK02/XK02 Change Vendor Master**

  **MK03/FK03/XK03 Display Vendor Master**

### 2. 库存管理

#### 物料收货 (Goods Receipt)

- MIGO

  : 物料移动

  - 用于执行各种物料移动，包括收货、发货、转储等。

- MB01

  : 收货（采购订单）

  - 用于根据采购订单进行收货。

#### 物料发货 (Goods Issue)

- MB1A

  : 发货（其他）

  - 用于执行其他类型的物料发货。

- MB1B

  : 转储

  - 用于执行物料的转储。

- MB1C

  : 其他收货

  - 用于执行其他类型的物料收货。

#### 库存盘点 (Physical Inventory)

- MI01

  : 创建盘点凭证

  - 用于创建新的库存盘点凭证。

- MI04

  : 盘点输入

  - 用于输入盘点结果。

- MI07

  : 过账盘点差异

  - 用于过账盘点差异。

### 3. 物料主数据管理

#### 物料主数据 (Material Master Data)

- MM01

  : 创建物料主数据

  - 用于创建新的物料主数据。

  - 物料分类：

    成品 (FERT)**物料类型: FERT****描述**: 成品是指已经完成生产并准备销售的物料。**用途**: 成品通常用于销售和分销模块 (SD) 中，作为销售订单的项目。**示例**: 电视机、汽车、手机等。**

    **半成品 (HALB)**物料类型: HALB描述**: 半成品是指在生产过程中已经部分完成，但还需要进一步加工的物料。**用途**: 半成品通常用于生产计划和控制模块 (PP) 中，作为生产订单的组件。**示例**: 电视机的显示屏、汽车的发动机、手机的电池等。**

    **原材料 (ROH)**物料类型: ROH描述**: 原材料是指用于生产成品或半成品的基本物料。**用途**: 原材料通常用于物料管理模块 (MM) 中，作为采购订单的项目。**示例**: 钢材、塑料、电子元件等。

- MM02

  : 修改物料主数据

  - 用于修改现有的物料主数据。

- MM03

  : 显示物料主数据

  - 用于查看现有的物料主数据。

### 4. 发票校验 (Invoice Verification)

- MIRO

  : 发票校验

  - 用于处理供应商发票的校验。

- MR8M

  : 取消发票

  - 用于取消已过账的发票。

### 5. 报表和分析

- MB51

  : 物料凭证清单

  - 用于查看物料凭证的详细信息。

- MB52

  : 库存状况

  - 用于查看物料的库存状况。

- ME2N

  : 采购订单清单

  - 用于查看采购订单的详细信息。

- ME80FN

  : 采购文档

  - 用于查看采购文档的详细信息。

### 6. 其他常用 T-Code

- ME5A

  : 采购申请清单

  - 用于查看采购申请的详细信息。

- ME2L

  : 按供应商查看采购订单

  - 用于按供应商查看采购订单的详细信息。

- ME2M

  : 按物料查看采购订单

  - 用于按物料查看采购订单的详细信息。

- ME2K

  : 按账户分配查看采购订单

  - 用于按账户分配查看采购订单的详细信息。

### 7.QUOTA

​	§**MEQ1 Maintain Quota Arrangement**

​	§**MEQ3 Display Quota Arrangement**

A 料有三个厂家提供   L 提供20%   M提供30%   N提供50%





 

















​	

