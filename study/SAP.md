al11  读取文件

FTP（File Transfer Protocol）和SFTP（SSH File Transfer Protocol 或 Secure File Transfer Protocol）都是用于在网络上传输文件的协议，但它们有一些关键的区别。

### 

### FTP（File Transfer Protocol）

1. **安全性**:
   - **加密**: FTP不加密数据，包括用户名和密码在内的所有信息都是明文传输。
   - **端口**: 使用TCP端口21进行控制连接，数据传输可能会使用随机选择的高位端口，这可能在通过防火墙时造成问题。
2. **使用场景**:
   - 适用于不需要高安全性的局域网或信任网络中的文件传输。
3. **易用性**:
   - 有众多客户端和服务器程序可供选择。
   - 设置相对简单，但由于缺乏加密，存在安全风险。

### 

### SFTP（SSH File Transfer Protocol/Secure File Transfer Protocol）

1. **安全性**:
   - **加密**: SFTP使用SSH（Secure Shell）协议加密所有传输的数据，包括用户名、密码、文件内容等，确保数据在传输过程中不被截获或篡改。
   - **端口**: 使用TCP端口22，通常与SSH共用端口，防火墙配置较为简单，因为只需要开放一个端口。
2. **使用场景**:
   - 适用于需要高安全性的环境，如传输敏感数据、连接公共网络时。
3. **易用性**:
   - 同样有许多客户端和服务器程序支持SFTP, 但由于加密的开销，配置和处理稍微复杂一些。
   - 需要SSH服务器支持，一般是Unix/Linux系统自带。

### 

### 总结对比

- **安全性**: SFTP通过加密提供了高级别的安全性，而FTP没有加密，容易受到攻击。
- **兼容性**: FTP在历史上普及较广，支持的客户端和服务器较多。SFTP依赖SSH，通常Unix/Linux系统自带支持，Windows系统可能需要额外配置。
- **复杂性**: FTP简单但不安全，适合无安全需求的场合；SFTP稍微复杂但非常安全，适合需要保护数据的场景。

选择哪种协议通常取决于你的具体需求和网络环境。如果传输的数据敏感度较高，建议使用SFTP来确保安全。







导入外部包

ABAP2XLSX 类

使用ABAP2XLS 需要ABAPGIT / ZSAPLINK 来安装

ABAP如果通过云端 GIT证书安装 教程：   https://docs.abapgit.org/user-guide/setup/ssl-setup.html#sap-trust-manager

				https://github.com/abapGit/abapGit/issues/4142

通过git hub下载  下载地址：https://github.com/abap2xlsx/abap2xlsx/tree/main

abap git Download 上传教程：  https://www.sapcenter.cn/archive/post/299493007650885.html

通过  SAPLINK   安装教程： https://www.sapcenter.cn/archive/post/300842217320517.html