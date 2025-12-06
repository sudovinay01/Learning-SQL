FROM mcr.microsoft.com/mssql/server:2025-latest

USER root

# Set environment variables
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=YourStrong!Passw0rd987
ENV MSSQL_PID=Developer

# Copy startup script
COPY start.sh /usr/src/start.sh
RUN chmod +x /usr/src/start.sh

# Expose SQL port
EXPOSE 1433

CMD ["/usr/src/start.sh"]
