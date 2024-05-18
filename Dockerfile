FROM python:3.11-alpine
RUN apk add --no-cache gcc musl-dev linux-headers

WORKDIR /app

COPY ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY . .

EXPOSE 8000

CMD python manage.py makemigrations \
    && python manage.py migrate \
    && python manage.py collectstatic  --no-input\
    && gunicorn stocks_products.wsgi:application -b 0.0.0.0:8000