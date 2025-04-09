### CPI study

#### 1. 组件分类

​    1.1  接收方   发送方 组件 

​    1.2  流程  ：  异常子流程（用来处理异常发送邮件）    集成流程（）  本地流程

​    1.3  事件  ： 结束事件  开始事件  开始消息   终止消息  终止事件 xxxxxxxxxxx    所有的里边  都会包含

​    1.4  映射 ： 标识/消息/操作/XSLT映射

​    1.5  转换：  内容修正器（用的最多）  xml 修正   格式转换  转码  编码

​    1.6  流程调用：   包含  内部  外部 流程调用  

​    1.7  路由 ：并行功能    多播     消息聚合  

​    1.8  安全： 加密解密程序    签名程序   验证程序

​    1.9 DB 操作：  DB 变量定义     数据增删  查

​    1.10 验证器： XML和 EDI 格式的验证器

```
映射的内容

标识（Identifiers）
作用
唯一标识：用于唯一标识集成流程中的各种元素，如消息、连接器、步骤等。
跟踪和调试：帮助跟踪和调试集成流程中的消息流和操作。
使用方法
设置标识：在集成流程的各个元素中设置唯一标识符，以便在日志和监控中进行跟踪。
日志记录：在日志记录和错误处理步骤中使用标识符来识别和跟踪特定的消息或操作。

消息（Messages）
作用
数据传输：在集成流程中传输数据，消息可以是 XML、JSON、CSV 等格式。
数据处理：在集成流程中对消息进行处理、转换和增强。
使用方法
消息传输：使用连接器（如 HTTP、SOAP、JDBC 等）在不同系统之间传输消息。
消息处理：使用脚本（如 Groovy）、映射（如 XSLT）和其他步骤对消息进行处理和转换。

操作（Operations）
作用
业务逻辑：定义集成流程中的具体业务逻辑和操作，如数据转换、条件判断、循环等。
流程控制：控制集成流程的执行顺序和逻辑分支。
使用方法
条件判断：使用条件步骤（如路由器、条件分支）根据消息内容或上下文信息执行不同的操作。
循环处理：使用循环步骤（如 For Each）对消息中的每个元素进行处理。
数据转换：使用脚本或映射步骤对消息进行数据转换和增强。


XSLT 映射（XSLT Mapping）
作用
数据转换：使用 XSLT（可扩展样式表语言转换）将 XML 数据从一种格式转换为另一种格式。
复杂映射：处理复杂的数据转换逻辑，如字段重命名、值映射、结构转换等。
使用方法
定义 XSLT 映射：在集成流程中添加 XSLT 映射步骤，并定义 XSLT 样式表来描述数据转换逻辑。
应用 XSLT 映射：将 XSLT 样式表应用于输入消息，生成转换后的输出消息。
```



#### 2. 常用组件

   2.1 Content Modifier 用来 获取参数  或者修改参数

   2.2 Request Reply  发送请求  前面连接  Content Modifier   后面连接接收方

   2.3  

#### 3.例子

   3.1 同步DB VCF 和 CCS 同系统 / 同DB 之间  

​	使用merge 语句实现  如果出现错误进行发mail 进行报错处理  

   3.2  VCF和其他系统   

​	a. 通过脚本实现batch id 检查

​	b. 获取batch id

​        c. 检查差异  判断是否是新数据？  第一次更新？

​	d.JDBC 获取数据   这里可以规定格式  我们用的XML

​	e. 有时候拿到的数据会有问题  xml 修正器

​	f. 然后  通过grovy 脚本插入数据   这里的话  

```SQL
paramList.add(Arrays.asList(xml.select_response.row[i].pkid.text(),xml.select_response.row[i].batchid.text(),xml.select_response.row[i].bu.text(),xml.select_response.row[i].bg.text(),xml.select_response.row[i].site.text(),xml.select_response.row[i].plant.text(),xml.select_response.row[i].location.text(),xml.select_response.row[i].emplid.text(),xml.select_response.row[i].name.text(),xml.select_response.row[i].name_a.text(),xml.select_response.row[i].hire_dt.text(),xml.select_response.row[i].sal_location_a.text(),xml.select_response.row[i].company.text(),xml.select_response.row[i].deptid.text(),xml.select_response.row[i].jobtitle_descr.text(),xml.select_response.row[i].emailid.text(),lowercasemailaddress,xml.select_response.row[i].phone_a.text(),xml.select_response.row[i].officer_level_a.text(),xml.select_response.row[i].supervisor_id.text(),xml.select_response.row[i].tree_level_num.text(),xml.select_response.row[i].termination_dt.text(),xml.select_response.row[i].labor_type.text(),xml.select_response.row[i].job_family.text(),xml.select_response.row[i].last_updt_dt.text()));

i = i + 1;
}

message.setHeader("CamelSqlParameters",paramList);

//Body 
//message.setBody("DELETE FROM 33889480C991422495380D50ECF12001.ZAPI_EMPLOYEE WHERE (pkid='92057061');";
message.setBody("INSERT INTO " + Schema + ".ZAPI_EMPLOYEE(pkid,batchid,bu,bg,site,plant,location,emplid,name,name_a,hire_dt,sal_location_a,company,deptid,jobtitle_descr,emailid,email_address_a,phone_a,officer_level_a,supervisor_id,tree_level_num,termination_dt,labor_type,job_family,last_updt_dt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
return message;
}
```

3.3 call SAP 的RFC 做相应的操作



#### 4. 脚本语言案例

实merge 操作更新DB

```sql
MERGE INTO "ZCCSAPI_COMMON"."ZCCS_CUSTOMER_COMPANY_SALESORG" AS target
USING (
SELECT A."COMPANY_CODE",
	A."SALES_ORG",
	B.CUSTOMER_CODE
FROM "C5D0753E116C42DEAEFD877442F4BBE2"."ZVCF_C_COMPANY_ORG" A
LEFT JOIN "C5D0753E116C42DEAEFD877442F4BBE2"."ZVCF_C_M_COMPANY" B
ON A.COMPANY_CODE = B.COMPANY
WHERE (A."SALES_ORG",B.CUSTOMER_CODE) IN
(SELECT "SALES_ORG",CUSTOMER_CODE
FROM "C5D0753E116C42DEAEFD877442F4BBE2"."ZVCF_C_M_SALES_ORG")
UNION
SELECT A."COMPANY_CODE",
	A."SALES_ORG",
	B.CUSTOMER_CODE
FROM "C5D0753E116C42DEAEFD877442F4BBE2"."ZVCF_C_COMPANY_ORG" A
LEFT JOIN "C5D0753E116C42DEAEFD877442F4BBE2"."ZVCF_C_M_SALES_ORG" B
ON A.SALES_ORG = B.SALES_ORG
WHERE (A."COMPANY_CODE",B.CUSTOMER_CODE) IN
(SELECT "COMPANY",CUSTOMER_CODE
FROM "C5D0753E116C42DEAEFD877442F4BBE2"."ZVCF_C_M_COMPANY"))
AS source
ON (target."CUSTOMER_CODE" = source."CUSTOMER_CODE"
	AND target."COMPANY_CODE" = source."COMPANY_CODE"
	AND target."SALES_ORG" = source."SALES_ORG"
)
WHEN MATCHED THEN
    UPDATE SET
        target."MODIFY_DATE" = CURRENT_TIMESTAMP
WHEN NOT MATCHED THEN
    INSERT (
        "CUSTOMER_CODE",
        "COMPANY_CODE",
        "SALES_ORG",
        "MODIFY_DATE"
    ) VALUES (
        source."CUSTOMER_CODE",
        source."COMPANY_CODE",
        source."SALES_ORG",
        CURRENT_TIMESTAMP
    );
```



#### 5.注意事项和使用技巧

开始事件/结束事件/开始消息/结束消息是必须的

