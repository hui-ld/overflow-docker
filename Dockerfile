# 基于官方的 Java 17 镜像
FROM openjdk:17-jdk-slim

# 设置工作目录
WORKDIR /overflow

# 安装 wget 和 unzip 以下载和解压文件
RUN apt-get update && apt-get install -y wget unzip libgl1-mesa-glx fontconfig && rm -rf /var/lib/apt/lists/*

# 下载 with-overflow.zip
RUN wget https://github.com/MrXiaoM/mirai-console-loader/releases/download/v2.1.2-patch1/with-overflow.zip

# 解压 with-overflow.zip 到 overflow 文件夹
RUN unzip with-overflow.zip 

# 确保 mcl 文件具有执行权限
RUN chmod +x /overflow/mcl

# 更换为阿里云的 apt 源
RUN echo "deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib" > /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/debian-security/ bullseye-security main" >> /etc/apt/sources.list

# 进入解压目录
WORKDIR /overflow

# 执行 mcl -u 命令以运行程序
CMD ["./mcl", "-u"]
