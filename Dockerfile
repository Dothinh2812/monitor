# Sử dụng image Python chính thức
FROM python:3.9-slim

# Cài đặt các gói phụ thuộc cho Chrome và các công cụ cần thiết
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép requirements.txt (nếu có) và cài đặt các gói Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép code của ứng dụng
COPY . .

# Thiết lập biến môi trường cho Chrome
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_PATH=/usr/bin/chromedriver

# Chạy ứng dụng
CMD ["python", "app.py"] 