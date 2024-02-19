# 使用官方的 OpenJDK 镜像作为基础镜像
FROM maven:3.8-openjdk-17 AS build

# 设置工作目录
WORKDIR /app

# 将本地的Java项目文件复制到容器的工作目录中
COPY . .

# 运行Maven打包命令，生成JAR包（这里假设最终生成的jar包位于target目录下）
RUN mvn clean package -Dmaven.test.skip=true

# 创建一个新的镜像层用于运行应用
FROM openjdk:17-jdk-alpine

# 设置环境变量
ENV APP_HOME=/


# 创建应用目录并在其中复制生成的JAR包
RUN mkdir -p /
COPY --from=build /app/target/newlangs-springboot-4.0.jar app.jar

# 指定容器启动时运行的命令
ENTRYPOINT ["java","-jar","/app.jar"]

# （可选）如果需要指定运行时的Java参数，可以添加如下CMD指令
# CMD ["-Xms256m", "-Xmx512m"]