# --- Stage: runtime (small, secure Java runtime) ---
FROM eclipse-temurin:17.0.16_8-jre-noble AS runtime

# Create non-root user
RUN useradd -m -d /home/appuser -s /bin/sh appuser

WORKDIR /app
# Copy the fat/uber jar produced by Maven
# The pipeline creates target/*.jar; container expects srikanth.jar (or change as needed)
COPY target/*.jar app.jar

# Make sure jar is readable
RUN chmod 644 /app/app.jar
# Drop to non-root user
USER appuser

# Expose application port (Spring Boot default 8080)
EXPOSE 8080

# Use a small health-friendly JVM invocation (tweak memory/cmdline as needed)
ENTRYPOINT ["java","-XX:+UseContainerSupport","-Xms256m","-Xmx512m","-jar","/app/app.jar"]


