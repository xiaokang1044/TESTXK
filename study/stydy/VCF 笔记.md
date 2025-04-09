### ## 杂项

### abap

5c82759a4cb2b3cf
f3640f02eda29bff
39a724ccc17bcbf3
f4d1e2f27ce01826
3689da64ed7120ff
a3a8c2ba78351a73
9669120b6a9b02f1
33c47c05e6f00fce
49dad14a67bb76d4
4a87e3aabd6985e7

tooken
HB7pQNxuDzPks9_bYV5v

3zPhtyKTrssqTrRV2Z4J

git add .

git commit -m "Update code for xiaokang"

git push origin xiaokang

### btp

## 4.17 - 5.01

1. RTV service workflow
2. inbox
3.

## 5.01 - 5.08

1. inquery my form
2. inquiry customer
3. customer master display             vendor master 文件 一起修改
4. customer display adjust

## 5.08 - 5.15

1. Data Matching   VCF 1.0 - VCF 2.0
2. Register autority - API to set user IAS AZURES

## 5.06

1. RTV UI
2. CUSTOMER MASTER APPROVELIST
3. inquire 的跳转
4. inquire vendor 文件
5. inbbox 添加跳转

### RTV

<https://blogs.sap.com/2021/03/15/sap-btp-cloud-foundry-job-scheduling-for-cap-based-project/>
BTP 组件实现daily 调用

1. purchase org    送整个purchase org资料 ZBAVNPURC0001        R开头年月日+4流水号   _GP_N            N是123456数字表示送进去的次数     送失败的话数字加一接着送（判断 SAP STATUE）   如果error  继续重送直到成功       return vendor 放X
2.
3. general   压 customer
4. head 放表内容   pur org sales org 组合    pur sale 组合   R开头年月日+4流水号——pur号——sales号   _GP_N

##### 送sap

参照workflow

##### 是否需要签核来确定是否送sap

### REGISTER

ECXEL to AZURE
<https://blog.51cto.com/u_14669127/5929024>
<https://blog.51cto.com/u_14669127/5585117>
EXCEL to IAS

### Inquire my form

1. 改成配置文件来实现

### vendor master 文件

### 弹框实现comment必填

如下是Component.js (只需改这个文件)   logan

### 如何实现inbox的修改

1. 怎么通过   外部账号   ias 账号   email来实现  call   btp的官方API?    现在只能用自己的账号用auth2 的认证实现call api
2. 如何实现在磁铁上面加数字
   在加载inbox的时候也会有 相应的请求 实现count 的获取？    这边是可以试下count的获取的

## 开发issue

### inquire vendor部分改动

1. vendor display  下面来做修改   要有对各个申请单的描述    content 放修改的内容
2. 界面修改    添加一栏    将状态和   processor 进行分离
3. inquire my form  可以查询人名  现在会报错   Uncaught Error: Settings must be set    之后需要有单子的人才会出现在这个user list里面
4. 要做成和inbox一样？

### inbox 修改

1. 外面的数量的显示 怎么通过   外部账号   ias   email来实现  call   btp的官方API?    或者在 配置文件里面获取useremail
2. 显示方法    在磁帖上面来显示数量    通过"indicatorDataSource": {"dataSource": "saas_approuter_es-dev",
   "path": "/TaskCollection/$count/?$filter=Status eq 'READY' or Status eq 'RESERVED' or Status eq 'IN_PROGRESS' or Status eq 'EXECUTED'"
   }
   上面的是destionation     下面的是path    还有刷新时间
   可能需要建立cap 来实现  所谓的数据的获取
3. 修改 error 可以通过点击  可以查看    error 信息  message  存在head栏位里面    通过message box的形式来展示
4. 对不同的颜色 做区分
5. 大家对单子的状态进行修改   之后对单子的筛选条件也得做出对应的变动
6. inbox 里的下面创建的单子的状态：   只排除 Delete 和 complete 的状态

6.1  Deleted   (排除)
6.2  人名？   之后会放在其他地方 （）  = > Wait Approve
6.3  Draft                           = > Draft        (要不要编辑)    编辑
6.4  Cancle  (是否   还是排除)        = >           需要             编辑
6.5  Rejected                        = > Rejected     (要不要编辑)   编辑
6.6  Create / modify error           = > Process Error      会回到site finance
6.7  SAP Processing                  = > SAP Processing

7. 上面待签核的单子的状态     只有三种？
   7.1 SAP/ERP  PROCESSING   => SAP Processing
   7.2 APPLY                 => Apply   /  Wait Approve
   7.3 Create/Modify Error   => Process Error   （要跳转到哪里  需不需要编辑单子？）
8. 点击单子直接跳转到对应的单子   获取worklflow instance id
9. 下面的单子的话   会有各个状态  processor 要写哪些人

6.1  Deleted   (排除)
6.2  人名？   之后会放在其他地方 （）   = > Wait Approve
6.3  Draft                           = > Draft        (要不要编辑)    编辑
6.4  Cancle  (是否   还是排除)         = >           需要             编辑
6.5  Rejected                        = > Rejected     (要不要编辑)   编辑
6.6  Create / modify error           = > Process Error                          不需要人名么
6.7  SAP Processing                  = > SAP Processing                         不需要人名么

### inquire customer issue

1. 筛选人名的话  需要通过数据来筛选，有正在签核数据的单子
2. customer master 下面approvelist 的跳转
3.

# 权限

### 具体权限内容

1. adjust block 只有vendor   customer admin 才会有权限
2.

### 权限会议  0518

1. 测试ias数量计算方法                       5.19  添加向 ias 添加54 user
2. 通过api 来实现 azure 的group 分配
3. 通过api 来获取某个group的 所有的user
   API的方法可以实现  邀请用户假如group  <https://learn.microsoft.com/zh-cn/graph/api/resources/invitation?view=graph-rest-beta>
4. Ias 的数量 会不会有限制

## IAS api

BTP_IAS   BTP to IAS
   <https://ae9ldgye1.accounts.ondemand.com>           BasicAuthentication     7e5338bb-1d3b-42ff-a634-ea157046724d      RPk8G6Ud-6?SOqI@z=Q[@B[Y2Ys7AM

IAS API

1. call user
   method：post
   href： <https://ae9ldgye1.accounts.ondemand.com/service/scim/Users>
   auth:  BasicAuthentication    7e5338bb-1d3b-42ff-a634-ea157046724d      RPk8G6Ud-6?SOqI@z=Q[@B[Y2Ys7AM   用destination就不用输入了
   body：
   {
   "emails": [
   {
   "primary": true,
   "value": "Wits.aalmaZhang@wistron.com"
   }
   ],
   "schemas": [
   "urn:ietf:params:scim:schemas:core:2.0:User"
   ],
   "userName": "aalma",
   "displayName": "aalma",
   "active": true
   }
   header:Content-Type   application/scim+json
2. add user to group
   method：patch
   href： <https://ae9ldgye1.accounts.ondemand.com/scim/Groups/b61df367-aec9-4d06-a974-ba2fc0e133e6>
   auth:  BasicAuthentication    7e5338bb-1d3b-42ff-a634-ea157046724d      RPk8G6Ud-6?SOqI@z=Q[@B[Y2Ys7AM   用destination就不用输入了
   body：
   {
   "schemas": [
   "urn:ietf:params:scim:api:messages:2.0:PatchOp"
   ],
   "Operations": [
   {
   "op": "add",
   "path": "members",
   "value": [
   {
   "value": "9c355eae-0575-44fa-aa06-d6dd5dcfefb2"    //这里是user id
   }
   ]
   }
   ]
   }
   header:Content-Type   application/scim+json
3.

6.1

1. inbox 日期格式

6.9

1. Customer Master
   1.1 跳转
   1.2 parnafunction
   1.3 EUVAT
   1.4 block

7.13
portal 现有问题

1. 附件无法显示，但是用范例API 是可以显示的
   但是使用我们的xml 后面加 文件部分内容，会直接不显示单子
2. modify 变颜色部分不完善     继续修改modify的函数的部分
3. 文件阔以上传了但是由于1   暂时还没测试之后在统计一下
4. 描述栏位 去 basedata抓数据

vendor supply type 描述
create vedorcode  分单   有的单子没有vendor code

modify customer
一些描述问题

5. vendor
   conpany - bank -
6. modify customer + divistion

sale orgtaxpartner function

7. comment 乱码问题
