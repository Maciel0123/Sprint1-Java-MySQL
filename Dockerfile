# Etapa de construção usando Maven
FROM maven:3.9.9-eclipse-temurin-21 AS build

# Defina o diretório de trabalho
WORKDIR /app

# Copiar os arquivos de configuração Maven e o código-fonte
COPY pom.xml .
COPY src ./src

# Executar a construção do projeto sem rodar os testes
RUN mvn -q -DskipTests package

# Etapa de execução
FROM eclipse-temurin:21-jre

# Defina o diretório de trabalho
WORKDIR /app

# Copiar o arquivo JAR da etapa anterior
COPY --from=build /app/target/*-SNAPSHOT.jar app.jar

# Expor a porta que o aplicativo vai rodar
EXPOSE 8080

# Variáveis de ambiente para otimização da JVM
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75"

# Configuração para conectar ao MySQL (exemplo de configuração com variável de ambiente)
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql-server:3306/dbname
ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=password

# Comando para rodar a aplicação com parâmetros configuráveis
CMD ["sh", "-c", "java -Dserver.port=${PORT:-8080} -Dserver.address=0.0.0.0 -jar app.jar"]
