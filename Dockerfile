# Use uma imagem Python oficial como base
FROM python:3.9-buster

# Definir o diretório de trabalho no container
WORKDIR /app

# Copiar o arquivo de requisitos para o diretório de trabalho
COPY requirements.txt .

# Instalar as outras dependências
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r ./requirements.txt

# Copiar o código da aplicação e o modelo para o diretório de trabalho
COPY ./model/model_xgboost.pkl ./app/model/model_xgboost.pkl
COPY ./app.py /app/

# Expor a porta que a aplicação irá utilizar
EXPOSE 7000

# Definir as variáveis de ambiente para o Flask
ENV FLASK_APP=/app/app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=7000

# Rodar o servidor Flask
CMD ["flask", "run", "--host=0.0.0.0", "--port=7000"]