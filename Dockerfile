# Sử dụng image Python chính thức
FROM python:3.9-slim

# Cài đặt các gói phụ thuộc và Chromium
RUN apt-get update && apt-get install -y wget gnupg2 apt-transport-https ca-certificates && \
    apt-get clean && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y \
    unzip \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép requirements.txt và cài đặt các gói Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép code của ứng dụng
COPY . .

# Thiết lập biến môi trường cho Chrome
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_PATH=/usr/bin/chromedriver

# Chạy ứng dụng
CMD ["python", "app.py"]